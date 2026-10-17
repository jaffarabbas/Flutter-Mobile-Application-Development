import Foundation
import SQLite3

private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

struct TrackPoint {
  let id: String
  let rideId: String
  let lat: Double
  let lng: Double
  let accuracy: Double?
  let altitude: Double?
  let speed: Double?
  let bearing: Double?
  let provider: String
  let isMocked: Bool
  let isFiltered: Bool
  let filterReason: String?
  let recordedAt: Int64

  /// nil must cross the channel as NSNull.
  private func nullable(_ v: Any?) -> Any { v ?? NSNull() }

  /// Keys match the `points` columns (same payload as Android).
  func toMap() -> [String: Any] {
    return [
      "id": id,
      "ride_id": rideId,
      "lat": lat,
      "lng": lng,
      "accuracy": nullable(accuracy),
      "altitude": nullable(altitude),
      "speed": nullable(speed),
      "bearing": nullable(bearing),
      "provider": provider,
      "is_mocked": isMocked ? 1 : 0,
      "is_filtered": isFiltered ? 1 : 0,
      "filter_reason": nullable(filterReason),
      "recorded_at": recordedAt,
    ]
  }
}

/// A ride row waiting for upload (rides.synced = 0).
struct PendingRide {
  let id: String
  let startedAt: Int64
  let endedAt: Int64?
  let status: String
}

struct GoodFix {
  let lat: Double
  let lng: Double
  let recordedAt: Int64
}

/// SQLite storage shared with Flutter (sqflite opens the same file).
/// Schema must stay identical to android/.../tracking/TrackerDb.kt.
final class TrackerDb {
  static let shared = TrackerDb()

  let path: String
  private var db: OpaquePointer?

  private init() {
    let fm = FileManager.default
    let dir = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    try? fm.createDirectory(at: dir, withIntermediateDirectories: true)
    // Must stay writable while the phone is locked during a ride.
    try? fm.setAttributes(
      [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication],
      ofItemAtPath: dir.path)
    path = dir.appendingPathComponent("tracker.db").path

    let flags = SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX
    if sqlite3_open_v2(path, &db, flags, nil) != SQLITE_OK {
      NSLog("TrackerDb: open failed: \(String(cString: sqlite3_errmsg(db)))")
    }
    exec("PRAGMA journal_mode=WAL")
    exec("PRAGMA foreign_keys=ON")
    exec("PRAGMA busy_timeout=3000")
    exec("""
      CREATE TABLE IF NOT EXISTS rides (
        id TEXT PRIMARY KEY,
        started_at INTEGER NOT NULL,
        ended_at INTEGER,
        status TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
      """)
    exec("""
      CREATE TABLE IF NOT EXISTS points (
        id TEXT PRIMARY KEY,
        ride_id TEXT NOT NULL REFERENCES rides(id),
        lat REAL NOT NULL,
        lng REAL NOT NULL,
        accuracy REAL,
        altitude REAL,
        speed REAL,
        bearing REAL,
        provider TEXT,
        is_mocked INTEGER NOT NULL DEFAULT 0,
        is_filtered INTEGER NOT NULL DEFAULT 0,
        filter_reason TEXT,
        recorded_at INTEGER NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0
      )
      """)
    exec("CREATE INDEX IF NOT EXISTS idx_points_ride ON points(ride_id, recorded_at)")
    // Partial index: only unsynced points are in it, so it stays tiny.
    exec("CREATE INDEX IF NOT EXISTS idx_points_unsynced ON points(recorded_at) WHERE synced = 0")
  }

  private func exec(_ sql: String) {
    var err: UnsafeMutablePointer<CChar>?
    if sqlite3_exec(db, sql, nil, nil, &err) != SQLITE_OK {
      NSLog("TrackerDb: \(sql.prefix(40)) failed: \(err.map { String(cString: $0) } ?? "?")")
      sqlite3_free(err)
    }
  }

  /// Runs a prepared statement; `bind` receives the statement to bind parameters.
  @discardableResult
  private func run(_ sql: String, _ bind: (OpaquePointer?) -> Void) -> Bool {
    var stmt: OpaquePointer?
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
      NSLog("TrackerDb: prepare failed: \(String(cString: sqlite3_errmsg(db)))")
      return false
    }
    defer { sqlite3_finalize(stmt) }
    bind(stmt)
    if sqlite3_step(stmt) != SQLITE_DONE {
      NSLog("TrackerDb: step failed: \(String(cString: sqlite3_errmsg(db)))")
      return false
    }
    return true
  }

  private func bindText(_ s: OpaquePointer?, _ i: Int32, _ v: String?) {
    if let v = v { sqlite3_bind_text(s, i, v, -1, SQLITE_TRANSIENT) } else { sqlite3_bind_null(s, i) }
  }

  private func bindDouble(_ s: OpaquePointer?, _ i: Int32, _ v: Double?) {
    if let v = v { sqlite3_bind_double(s, i, v) } else { sqlite3_bind_null(s, i) }
  }

  /// Idempotent so a relaunch mid-ride is safe.
  func startRide(_ rideId: String, startedAt: Int64) {
    run("INSERT OR IGNORE INTO rides (id, started_at, status) VALUES (?, ?, 'active')") { s in
      bindText(s, 1, rideId)
      sqlite3_bind_int64(s, 2, startedAt)
    }
  }

  func endRide(_ rideId: String, endedAt: Int64) {
    // synced = 0: the "ended" status must be uploaded again.
    run("UPDATE rides SET ended_at = ?, status = 'ended', synced = 0 WHERE id = ?") { s in
      sqlite3_bind_int64(s, 1, endedAt)
      bindText(s, 2, rideId)
    }
  }

  func insertPoint(_ p: TrackPoint) {
    run("""
      INSERT OR IGNORE INTO points (id, ride_id, lat, lng, accuracy, altitude, speed, bearing,
        provider, is_mocked, is_filtered, filter_reason, recorded_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      """) { s in
      bindText(s, 1, p.id)
      bindText(s, 2, p.rideId)
      sqlite3_bind_double(s, 3, p.lat)
      sqlite3_bind_double(s, 4, p.lng)
      bindDouble(s, 5, p.accuracy)
      bindDouble(s, 6, p.altitude)
      bindDouble(s, 7, p.speed)
      bindDouble(s, 8, p.bearing)
      bindText(s, 9, p.provider)
      sqlite3_bind_int(s, 10, p.isMocked ? 1 : 0)
      sqlite3_bind_int(s, 11, p.isFiltered ? 1 : 0)
      bindText(s, 12, p.filterReason)
      sqlite3_bind_int64(s, 13, p.recordedAt)
    }
  }

  /// Seeds the speed-jump filter after a relaunch.
  func lastGoodPoint(_ rideId: String) -> GoodFix? {
    var stmt: OpaquePointer?
    let sql = "SELECT lat, lng, recorded_at FROM points WHERE ride_id = ? AND is_filtered = 0 " +
      "ORDER BY recorded_at DESC LIMIT 1"
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return nil }
    defer { sqlite3_finalize(stmt) }
    bindText(stmt, 1, rideId)
    guard sqlite3_step(stmt) == SQLITE_ROW else { return nil }
    return GoodFix(
      lat: sqlite3_column_double(stmt, 0),
      lng: sqlite3_column_double(stmt, 1),
      recordedAt: sqlite3_column_int64(stmt, 2))
  }

  // MARK: - Sync (only SyncManager calls these; points stay immutable except `synced`)

  private func columnText(_ s: OpaquePointer?, _ i: Int32) -> String? {
    guard sqlite3_column_type(s, i) != SQLITE_NULL, let c = sqlite3_column_text(s, i) else { return nil }
    return String(cString: c)
  }

  private func columnDouble(_ s: OpaquePointer?, _ i: Int32) -> Double? {
    sqlite3_column_type(s, i) == SQLITE_NULL ? nil : sqlite3_column_double(s, i)
  }

  /// nil must become NSNull for JSONSerialization.
  private func orNull(_ v: Any?) -> Any { v ?? NSNull() }

  func pendingRides() -> [PendingRide] {
    var stmt: OpaquePointer?
    let sql = "SELECT id, started_at, ended_at, status FROM rides WHERE synced = 0 ORDER BY started_at"
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return [] }
    defer { sqlite3_finalize(stmt) }
    var result: [PendingRide] = []
    while sqlite3_step(stmt) == SQLITE_ROW {
      guard let id = columnText(stmt, 0), let status = columnText(stmt, 3) else { continue }
      let endedAt: Int64? = sqlite3_column_type(stmt, 2) == SQLITE_NULL ? nil : sqlite3_column_int64(stmt, 2)
      result.append(PendingRide(
        id: id, startedAt: sqlite3_column_int64(stmt, 1), endedAt: endedAt, status: status))
    }
    return result
  }

  /// Marks the ride synced only if it still has the uploaded values, so an
  /// endRide() that raced with the upload is sent on the next pass.
  func markRideSynced(_ r: PendingRide) {
    run("UPDATE rides SET synced = 1 WHERE id = ? AND status = ? AND ended_at IS ?") { s in
      bindText(s, 1, r.id)
      bindText(s, 2, r.status)
      if let e = r.endedAt { sqlite3_bind_int64(s, 3, e) } else { sqlite3_bind_null(s, 3) }
    }
  }

  /// Oldest unsynced points first, already shaped as the API's JSON objects
  /// (camelCase keys, Bool flags, NSNull for missing values).
  func pendingPointPayloads(limit: Int) -> [[String: Any]] {
    var stmt: OpaquePointer?
    let sql = "SELECT id, ride_id, lat, lng, accuracy, altitude, speed, bearing, provider, " +
      "is_mocked, is_filtered, filter_reason, recorded_at FROM points " +
      "WHERE synced = 0 ORDER BY recorded_at LIMIT ?"
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return [] }
    defer { sqlite3_finalize(stmt) }
    sqlite3_bind_int(stmt, 1, Int32(limit))
    var result: [[String: Any]] = []
    while sqlite3_step(stmt) == SQLITE_ROW {
      guard let id = columnText(stmt, 0), let rideId = columnText(stmt, 1) else { continue }
      result.append([
        "id": id,
        "rideId": rideId,
        "lat": sqlite3_column_double(stmt, 2),
        "lng": sqlite3_column_double(stmt, 3),
        "accuracy": orNull(columnDouble(stmt, 4)),
        "altitude": orNull(columnDouble(stmt, 5)),
        "speed": orNull(columnDouble(stmt, 6)),
        "bearing": orNull(columnDouble(stmt, 7)),
        "provider": orNull(columnText(stmt, 8)),
        "isMocked": sqlite3_column_int(stmt, 9) != 0,
        "isFiltered": sqlite3_column_int(stmt, 10) != 0,
        "filterReason": orNull(columnText(stmt, 11)),
        "recordedAt": sqlite3_column_int64(stmt, 12),
      ])
    }
    return result
  }

  /// A single UPDATE statement is atomic on its own (implicit transaction), which
  /// avoids an explicit BEGIN on the connection shared with insertPoint().
  /// ids.count <= 500, below SQLite's 999 variable limit.
  func markPointsSynced(_ ids: [String]) {
    guard !ids.isEmpty else { return }
    let marks = Array(repeating: "?", count: ids.count).joined(separator: ",")
    run("UPDATE points SET synced = 1 WHERE id IN (\(marks))") { s in
      for (i, id) in ids.enumerated() { bindText(s, Int32(i + 1), id) }
    }
  }

  func pendingCounts() -> (rides: Int, points: Int) {
    func count(_ sql: String) -> Int {
      var stmt: OpaquePointer?
      guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return 0 }
      defer { sqlite3_finalize(stmt) }
      return sqlite3_step(stmt) == SQLITE_ROW ? Int(sqlite3_column_int64(stmt, 0)) : 0
    }
    return (count("SELECT COUNT(*) FROM rides WHERE synced = 0"),
            count("SELECT COUNT(*) FROM points WHERE synced = 0"))
  }
}
