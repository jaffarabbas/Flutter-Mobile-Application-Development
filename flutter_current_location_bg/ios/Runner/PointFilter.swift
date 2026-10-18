import Foundation

/// Tunable thresholds. Keep in sync with android/.../tracking/PointFilter.kt.
enum FilterConfig {
  /// Reject fixes whose reported horizontal accuracy is worse than this.
  static let maxAccuracyM = 20.0

  /// Reject fixes implying a faster move than this from the last good point.
  static let maxSpeedMps = 55.0

  /// Below this reported speed the device is treated as standing still (GPS drift).
  static let stationarySpeedMps = 0.5

  /// A move smaller than the fix's own accuracy is noise. Never use less than this floor.
  static let minMoveM = 3.0

  /// At or above this reported (Doppler) speed the device is really moving, so the
  /// jitter check is skipped: at ~3 m/s with ~10 m accuracy it would reject 2 of 3 real fixes.
  static let movingSpeedMps = 1.5
}

/// Flags (never drops) suspicious fixes. Every distance check is measured
/// against the last point that passed the filter.
///
/// Order: mocked -> low_accuracy -> speed_jump -> stationary -> jitter
final class PointFilter {
  var lastGood: GoodFix?

  /// Debug builds only (see LocationTracker.allowMock): mocked points are still stored with is_mocked = 1.
  var allowMock = false

  /// Returns the filter reason, or nil if the point is good.
  func evaluate(
    lat: Double, lng: Double, accuracy: Double?, speed: Double?,
    isMocked: Bool, recordedAt: Int64
  ) -> String? {
    let reason = check(lat: lat, lng: lng, accuracy: accuracy, speed: speed,
                       isMocked: isMocked, recordedAt: recordedAt)
    if reason == nil { lastGood = GoodFix(lat: lat, lng: lng, recordedAt: recordedAt) }
    return reason
  }

  private func check(
    lat: Double, lng: Double, accuracy: Double?, speed: Double?,
    isMocked: Bool, recordedAt: Int64
  ) -> String? {
    if isMocked && !allowMock { return "mocked" }
    guard let accuracy = accuracy, accuracy <= FilterConfig.maxAccuracyM else { return "low_accuracy" }
    // The first good point of a ride is always accepted so the route has an anchor.
    guard let prev = lastGood else { return nil }

    let dist = PointFilter.haversine(prev.lat, prev.lng, lat, lng)
    if impliedSpeed(prev, dist: dist, recordedAt: recordedAt) > FilterConfig.maxSpeedMps {
      return "speed_jump"
    }
    if let speed = speed, speed < FilterConfig.stationarySpeedMps { return "stationary" }
    let isMoving = (speed ?? 0) >= FilterConfig.movingSpeedMps
    if !isMoving && dist < max(accuracy, FilterConfig.minMoveM) { return "jitter" }
    return nil
  }

  private func impliedSpeed(_ prev: GoodFix, dist: Double, recordedAt: Int64) -> Double {
    let dtSec = Double(recordedAt - prev.recordedAt) / 1000.0
    // Same/backwards timestamp: any real movement is impossible.
    if dtSec <= 0 { return dist > 1.0 ? .greatestFiniteMagnitude : 0 }
    return dist / dtSec
  }

  static func haversine(_ lat1: Double, _ lng1: Double, _ lat2: Double, _ lng2: Double) -> Double {
    let r = 6_371_000.0
    let rad = Double.pi / 180
    let dLat = (lat2 - lat1) * rad
    let dLng = (lng2 - lng1) * rad
    let a = pow(sin(dLat / 2), 2) + cos(lat1 * rad) * cos(lat2 * rad) * pow(sin(dLng / 2), 2)
    return 2 * r * asin(sqrt(a))
  }
}
