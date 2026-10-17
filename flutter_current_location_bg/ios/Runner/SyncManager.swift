import Foundation
import UIKit

/// nil must become NSNull for JSONSerialization and the Flutter codec.
private func jsonValue(_ v: Any?) -> Any { v ?? NSNull() }

private func nowMs() -> Int64 { Int64(Date().timeIntervalSince1970 * 1000) }

/// Reference holder so @Sendable callbacks never mutate a captured var.
private final class Box<T> {
  var value: T
  init(_ value: T) { self.value = value }
}

/// Server sync settings, stored natively so sync runs without Flutter.
/// Keep keys/behavior in sync with android/.../tracking/SyncConfig.kt.
struct SyncConfig {
  let baseUrl: String
  let apiKey: String
  let enabled: Bool

  var isUsable: Bool { enabled && !baseUrl.isEmpty }

  private static let baseUrlKey = "tracker.sync.base_url"
  private static let apiKeyKey = "tracker.sync.api_key"
  private static let enabledKey = "tracker.sync.enabled"
  private static let deviceIdKey = "tracker.sync.device_id"
  private static let deviceIdLock = NSLock()

  static func load() -> SyncConfig {
    let d = UserDefaults.standard
    return SyncConfig(
      baseUrl: d.string(forKey: baseUrlKey) ?? "",
      apiKey: d.string(forKey: apiKeyKey) ?? "",
      enabled: d.bool(forKey: enabledKey))
  }

  /// Trims and strips trailing slashes so paths can be appended directly.
  @discardableResult
  static func save(baseUrl: String, apiKey: String, enabled: Bool) -> SyncConfig {
    var url = baseUrl.trimmingCharacters(in: .whitespacesAndNewlines)
    while url.hasSuffix("/") { url.removeLast() }
    let c = SyncConfig(
      baseUrl: url, apiKey: apiKey.trimmingCharacters(in: .whitespacesAndNewlines), enabled: enabled)
    let d = UserDefaults.standard
    d.set(c.baseUrl, forKey: baseUrlKey)
    d.set(c.apiKey, forKey: apiKeyKey)
    d.set(c.enabled, forKey: enabledKey)
    return c
  }

  /// Generated once on first use, never changes (lost only on uninstall).
  static var deviceId: String {
    deviceIdLock.lock()
    defer { deviceIdLock.unlock() }
    let d = UserDefaults.standard
    if let id = d.string(forKey: deviceIdKey) { return id }
    let id = UUID().uuidString.lowercased()
    d.set(id, forKey: deviceIdKey)
    return id
  }
}

/// Uploads unsynced rides/points to the server (docs/SYNC_API.md, "Client sync rules").
/// Keep behavior in sync with android/.../tracking/SyncManager.kt.
///
/// All network + sync DB work runs on one serial background queue, so passes
/// never overlap and tracking (main thread) never waits on sync.
final class SyncManager {
  static let shared = SyncManager()

  private enum Trigger {
    /// Fix inserted / app open: throttled to ~10 s, respects backoff and the 400 block.
    case auto
    /// Stop Ride / config saved: ignores throttle and backoff, respects the 400 block.
    case soon
    /// "Sync now": ignores everything and clears the 400 block.
    case manual
  }

  private enum HttpResult {
    case ok
    case status(Int, String)
    case network(String)
    case badUrl(String)
  }

  private static let throttleMs: Int64 = 10_000
  private static let backoffMinMs: Int64 = 10_000
  private static let backoffMaxMs: Int64 = 5 * 60_000
  private static let batchSize = 500

  private static let lastSyncAtKey = "tracker.sync.last_sync_at"
  private static let lastErrorKey = "tracker.sync.last_error"
  private static let blockedKey = "tracker.sync.blocked"

  private let db = TrackerDb.shared
  private let queue = DispatchQueue(label: "tracker.sync", qos: .utility)
  /// Status reads (COUNT queries) for the UI; must not wait behind a slow upload.
  private let statusQueue = DispatchQueue(label: "tracker.sync.status", qos: .userInitiated)
  private let session: URLSession

  // Guarded by `lock`.
  private let lock = NSLock()
  private var queued = false
  private var waiters: [([String: Any]) -> Void] = []
  private var syncing = false
  private var lastStartAt: Int64 = 0
  private var backoffMs: Int64 = 0
  private var retryAt: Int64 = 0

  private init() {
    let config = URLSessionConfiguration.default
    // iOS has no separate connect timeout: this is the idle timeout per request.
    config.timeoutIntervalForRequest = 20
    config.timeoutIntervalForResource = 60
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    session = URLSession(configuration: config)

    // "App open" trigger also when coming back from background.
    NotificationCenter.default.addObserver(
      forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil
    ) { [weak self] _ in
      self?.requestSync(force: false)
    }
  }

  // MARK: - Public API (cheap; call from any thread)

  /// `force` = manual "Sync now". `completion` gets the status map on a background queue.
  func requestSync(force: Bool, completion: (([String: Any]) -> Void)? = nil) {
    request(force ? .manual : .auto, completion: completion)
  }

  /// Final upload after Stop Ride. Must be called on the main thread: holds a
  /// background task so the pass can finish after the app leaves the foreground.
  func syncAfterStop() {
    let app = UIApplication.shared
    let task = Box(UIBackgroundTaskIdentifier.invalid)
    let end = {
      if task.value != .invalid {
        app.endBackgroundTask(task.value)
        task.value = .invalid
      }
    }
    task.value = app.beginBackgroundTask(withName: "ride-final-sync") { end() }
    request(.soon) { _ in DispatchQueue.main.async { end() } }
  }

  /// Saves config, clears the 400 block / backoff, then kicks a pass.
  @discardableResult
  func updateConfig(baseUrl: String, apiKey: String, enabled: Bool) -> SyncConfig {
    let c = SyncConfig.save(baseUrl: baseUrl, apiKey: apiKey, enabled: enabled)
    lock.lock()
    backoffMs = 0
    retryAt = 0
    lock.unlock()
    let d = UserDefaults.standard
    d.set(false, forKey: SyncManager.blockedKey)
    d.removeObject(forKey: SyncManager.lastErrorKey)
    request(.soon, completion: nil)
    return c
  }

  func configMap() -> [String: Any] {
    let c = SyncConfig.load()
    return ["baseUrl": c.baseUrl, "apiKey": c.apiKey, "enabled": c.enabled, "deviceId": SyncConfig.deviceId]
  }

  func statusAsync(_ completion: @escaping ([String: Any]) -> Void) {
    statusQueue.async { completion(self.status()) }
  }

  // MARK: - Scheduling

  private func request(_ trigger: Trigger, completion: (([String: Any]) -> Void)?) {
    guard SyncConfig.load().isUsable else {
      if let c = completion { statusAsync(c) }
      return
    }
    let now = nowMs()
    let d = UserDefaults.standard
    lock.lock()
    if trigger == .manual {
      d.set(false, forKey: SyncManager.blockedKey)
    } else {
      let blocked = d.bool(forKey: SyncManager.blockedKey)
      let throttled = trigger == .auto
        && (now - lastStartAt < SyncManager.throttleMs || now < retryAt)
      if blocked || throttled {
        lock.unlock()
        if let c = completion { statusAsync(c) }
        return
      }
    }
    lastStartAt = now
    if let c = completion { waiters.append(c) }
    // A pass already waiting will pick up everything that is pending now.
    let alreadyQueued = queued
    queued = true
    lock.unlock()
    if !alreadyQueued {
      queue.async { self.runQueued() }
    }
  }

  private func runQueued() {
    lock.lock()
    queued = false
    let callbacks = waiters
    waiters = []
    syncing = true
    lock.unlock()

    runPass()

    lock.lock()
    syncing = false
    lock.unlock()
    if !callbacks.isEmpty {
      let s = status()
      callbacks.forEach { $0(s) }
    }
  }

  // MARK: - One pass: rides first, then points oldest first

  private func runPass() {
    let config = SyncConfig.load()
    guard config.isUsable else { return }
    let deviceId = SyncConfig.deviceId

    for ride in db.pendingRides() {
      let body: [String: Any] = [
        "deviceId": deviceId,
        "startedAt": ride.startedAt,
        "endedAt": jsonValue(ride.endedAt),
        "status": ride.status,
      ]
      let res = send("PUT", config.baseUrl + "/api/v1/rides/" + ride.id, body, apiKey: config.apiKey)
      guard accept(res) else { return }
      db.markRideSynced(ride)
    }

    while true {
      let points = db.pendingPointPayloads(limit: SyncManager.batchSize)
      if points.isEmpty { break }
      let body: [String: Any] = ["deviceId": deviceId, "points": points]
      let res = send("POST", config.baseUrl + "/api/v1/points/batch", body, apiKey: config.apiKey)
      guard accept(res) else { return }
      db.markPointsSynced(points.compactMap { $0["id"] as? String })
      // A short batch means we caught up; new fixes go in the next pass.
      if points.count < SyncManager.batchSize { break }
    }

    lock.lock()
    backoffMs = 0
    retryAt = 0
    lock.unlock()
    let d = UserDefaults.standard
    d.set(NSNumber(value: nowMs()), forKey: SyncManager.lastSyncAtKey)
    d.removeObject(forKey: SyncManager.lastErrorKey)
  }

  /// True to continue the pass; false after recording the error.
  private func accept(_ res: HttpResult) -> Bool {
    switch res {
    case .ok:
      return true
    case .badUrl(let url):
      return fail("Invalid server URL: \(url)", retry: false)
    case .network(let msg):
      return fail("Network error: \(msg)", retry: true)
    case .status(400, let msg):
      // Same payload would be rejected forever: stop until config change / Sync now.
      return fail("Rejected by server (400): \(msg)", retry: false)
    case .status(401, _):
      return fail("Unauthorized (check API key)", retry: true)
    case .status(let code, let msg):
      return fail("Server error \(code): \(msg)", retry: true)
    }
  }

  /// retry = exponential backoff; otherwise block automatic syncs. Always returns false.
  private func fail(_ error: String, retry: Bool) -> Bool {
    NSLog("SyncManager: %@", error) // server text is not a format string
    let d = UserDefaults.standard
    d.set(error, forKey: SyncManager.lastErrorKey)
    if retry {
      lock.lock()
      backoffMs = backoffMs == 0 ? SyncManager.backoffMinMs : min(backoffMs * 2, SyncManager.backoffMaxMs)
      retryAt = nowMs() + backoffMs
      lock.unlock()
    } else {
      d.set(true, forKey: SyncManager.blockedKey)
    }
    return false
  }

  func status() -> [String: Any] {
    let counts = db.pendingCounts()
    let d = UserDefaults.standard
    let last = (d.object(forKey: SyncManager.lastSyncAtKey) as? NSNumber)?.int64Value ?? 0
    lock.lock()
    let isSyncing = syncing
    lock.unlock()
    return [
      "enabled": SyncConfig.load().enabled,
      "deviceId": SyncConfig.deviceId,
      "pendingRides": counts.rides,
      "pendingPoints": counts.points,
      "lastSyncAt": jsonValue(last > 0 ? last : nil),
      "lastError": jsonValue(d.string(forKey: SyncManager.lastErrorKey)),
      "isSyncing": isSyncing,
    ]
  }

  // MARK: - HTTP (URLSession + JSONSerialization only)

  /// Blocks the sync queue until the response arrives (the session calls back on its own queue).
  private func send(_ method: String, _ urlString: String, _ body: [String: Any], apiKey: String) -> HttpResult {
    guard let url = URL(string: urlString),
          let scheme = url.scheme?.lowercased(), scheme == "http" || scheme == "https",
          url.host != nil else {
      return .badUrl(urlString)
    }
    // Also rejects NaN/Infinity, which would otherwise raise an ObjC exception.
    guard JSONSerialization.isValidJSONObject(body),
          let data = try? JSONSerialization.data(withJSONObject: body) else {
      return .status(400, "Payload is not valid JSON")
    }

    var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 20)
    req.httpMethod = method
    req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    req.setValue("application/json", forHTTPHeaderField: "Accept")
    if !apiKey.isEmpty { req.setValue(apiKey, forHTTPHeaderField: "X-Api-Key") }
    req.httpBody = data

    let done = DispatchSemaphore(value: 0)
    let result = Box(HttpResult.network("No response"))
    session.dataTask(with: req) { data, response, error in
      defer { done.signal() }
      if let error = error {
        // No network, DNS, timeout, refused, ATS blocked plain HTTP ...
        result.value = .network(error.localizedDescription)
        return
      }
      guard let http = response as? HTTPURLResponse else {
        result.value = .network("Invalid response")
        return
      }
      result.value = (200..<300).contains(http.statusCode)
        ? .ok
        : .status(http.statusCode, SyncManager.serverMessage(data))
    }.resume()
    done.wait()
    return result.value
  }

  /// `{ "success": false, "message": "..." }` -> message; otherwise a short raw snippet.
  private static func serverMessage(_ data: Data?) -> String {
    guard let data = data else { return "" }
    if let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
       let msg = obj["message"] as? String, !msg.isEmpty {
      return msg
    }
    return String(String(decoding: data, as: UTF8.self).prefix(200))
  }
}
