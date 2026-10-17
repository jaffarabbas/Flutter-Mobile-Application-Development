import CoreLocation
import Flutter
import UIKit

/// Owns CLLocationManager, filters every fix and writes it to SQLite
/// immediately. Streams to Flutter when an EventChannel listener exists.
final class LocationTracker: NSObject, CLLocationManagerDelegate, FlutterStreamHandler {
  static let shared = LocationTracker()

  private static let activeRideKey = "tracker.active_ride_id"

  private let manager = CLLocationManager()
  private let db = TrackerDb.shared
  private let filter = PointFilter()
  private var eventSink: FlutterEventSink?
  private(set) var rideId: String?

  private var permissionResult: FlutterResult?
  private var permissionTimer: Timer?

  private override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    manager.activityType = .automotiveNavigation
    manager.distanceFilter = kCLDistanceFilterNone
    manager.pausesLocationUpdatesAutomatically = false
  }

  var activeRideId: String? {
    UserDefaults.standard.string(forKey: LocationTracker.activeRideKey)
  }

  // MARK: - Ride control

  func startRide(_ id: String) {
    UserDefaults.standard.set(id, forKey: LocationTracker.activeRideKey)
    db.startRide(id, startedAt: nowMs())
    beginUpdates(for: id)
  }

  func stopRide() {
    manager.stopUpdatingLocation()
    manager.stopMonitoringSignificantLocationChanges()
    manager.allowsBackgroundLocationUpdates = false
    if let id = rideId ?? activeRideId { db.endRide(id, endedAt: nowMs()) }
    UserDefaults.standard.removeObject(forKey: LocationTracker.activeRideKey)
    rideId = nil
  }

  /// Called at launch (including a background relaunch by significant-change
  /// monitoring): resume high-accuracy updates for an unfinished ride.
  func resumeIfNeeded() {
    guard let id = activeRideId, rideId == nil else { return }
    beginUpdates(for: id)
  }

  private func beginUpdates(for id: String) {
    rideId = id
    filter.lastGood = db.lastGoodPoint(id)
    manager.allowsBackgroundLocationUpdates = true
    manager.showsBackgroundLocationIndicator = true
    manager.startUpdatingLocation()
    // Lets iOS relaunch the app if it is terminated mid-ride.
    manager.startMonitoringSignificantLocationChanges()
  }

  // MARK: - CLLocationManagerDelegate

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let id = rideId else { return }
    for loc in locations { handle(loc, rideId: id) }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    NSLog("LocationTracker error: \(error.localizedDescription)")
  }

  private func handle(_ loc: CLLocation, rideId: String) {
    var mocked = false
    if #available(iOS 15.0, *) {
      mocked = loc.sourceInformation?.isSimulatedBySoftware ?? false
    }
    let accuracy: Double? = loc.horizontalAccuracy >= 0 ? loc.horizontalAccuracy : nil
    let speed: Double? = loc.speed >= 0 ? loc.speed : nil
    let recordedAt = Int64(loc.timestamp.timeIntervalSince1970 * 1000)
    let reason = filter.evaluate(
      lat: loc.coordinate.latitude, lng: loc.coordinate.longitude,
      accuracy: accuracy, speed: speed, isMocked: mocked, recordedAt: recordedAt)

    let point = TrackPoint(
      id: UUID().uuidString.lowercased(),
      rideId: rideId,
      lat: loc.coordinate.latitude,
      lng: loc.coordinate.longitude,
      accuracy: accuracy,
      altitude: loc.verticalAccuracy > 0 ? loc.altitude : nil,
      speed: speed,
      bearing: loc.course >= 0 ? loc.course : nil,
      provider: "ios",
      isMocked: mocked,
      isFiltered: reason != nil,
      filterReason: reason,
      recordedAt: recordedAt)
    db.insertPoint(point)
    eventSink?(point.toMap())
  }

  // MARK: - Permissions: When In Use -> Always

  func permissionStatus() -> [String: Any] {
    let status = manager.authorizationStatus
    let authorized = status == .authorizedAlways || status == .authorizedWhenInUse
    return [
      "platform": "ios",
      "fineLocation": authorized && manager.accuracyAuthorization == .fullAccuracy,
      "backgroundLocation": status == .authorizedAlways,
      "notifications": true,
      "ignoringBatteryOptimizations": true,
    ]
  }

  func requestPermissions(_ result: @escaping FlutterResult) {
    if permissionResult != nil {
      result(FlutterError(code: "BUSY", message: "Permission request already in progress", details: nil))
      return
    }
    permissionResult = result
    requestNextPermission()
  }

  private func requestNextPermission() {
    switch manager.authorizationStatus {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedWhenInUse:
      manager.requestAlwaysAuthorization()
      // iOS shows the "Always" prompt at most once and gives no callback when
      // the status does not change, so don't wait forever.
      permissionTimer?.invalidate()
      permissionTimer = Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { [weak self] _ in
        self?.finishPermissions()
      }
    default:
      finishPermissions()
    }
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    guard permissionResult != nil else { return }
    switch manager.authorizationStatus {
    case .notDetermined:
      return // initial callback right after delegate assignment; wait for the user's answer
    case .authorizedWhenInUse where permissionTimer == nil:
      requestNextPermission() // step 2: ask for Always
    default:
      finishPermissions()
    }
  }

  private func finishPermissions() {
    permissionTimer?.invalidate()
    permissionTimer = nil
    permissionResult?(permissionStatus())
    permissionResult = nil
  }

  // MARK: - FlutterStreamHandler

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    eventSink = events
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }

  private func nowMs() -> Int64 { Int64(Date().timeIntervalSince1970 * 1000) }
}
