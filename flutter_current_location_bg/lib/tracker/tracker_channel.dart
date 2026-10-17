import 'package:flutter/services.dart';

/// One GPS fix. Keys match the `points` table columns, so the same model is
/// used for EventChannel payloads and SQLite rows.
class TrackPoint {
  final String id;
  final String rideId;
  final double lat;
  final double lng;
  final double? accuracy;
  final double? altitude;
  final double? speed;
  final double? bearing;
  final String? provider;
  final bool isMocked;
  final bool isFiltered;
  final String? filterReason;
  final int recordedAt;

  const TrackPoint({
    required this.id,
    required this.rideId,
    required this.lat,
    required this.lng,
    this.accuracy,
    this.altitude,
    this.speed,
    this.bearing,
    this.provider,
    required this.isMocked,
    required this.isFiltered,
    this.filterReason,
    required this.recordedAt,
  });

  factory TrackPoint.fromMap(Map<dynamic, dynamic> m) => TrackPoint(
        id: m['id'] as String,
        rideId: m['ride_id'] as String,
        lat: (m['lat'] as num).toDouble(),
        lng: (m['lng'] as num).toDouble(),
        accuracy: (m['accuracy'] as num?)?.toDouble(),
        altitude: (m['altitude'] as num?)?.toDouble(),
        speed: (m['speed'] as num?)?.toDouble(),
        bearing: (m['bearing'] as num?)?.toDouble(),
        provider: m['provider'] as String?,
        isMocked: (m['is_mocked'] as num? ?? 0) != 0,
        isFiltered: (m['is_filtered'] as num? ?? 0) != 0,
        filterReason: m['filter_reason'] as String?,
        recordedAt: (m['recorded_at'] as num).toInt(),
      );

  DateTime get time => DateTime.fromMillisecondsSinceEpoch(recordedAt);
}

class TrackingState {
  final bool tracking;
  final String? rideId;
  const TrackingState(this.tracking, this.rideId);
}

/// Thin wrapper over the native `tracker/control` and `tracker/points` channels.
class TrackerChannel {
  static const _control = MethodChannel('tracker/control');
  static const _events = EventChannel('tracker/points');

  static Stream<TrackPoint>? _points;

  /// Live points while the Flutter UI is alive. Native writes to SQLite regardless.
  static Stream<TrackPoint> get points => _points ??= _events
      .receiveBroadcastStream()
      .map((e) => TrackPoint.fromMap(e as Map));

  static Future<void> startRide(String rideId) =>
      _control.invokeMethod('startRide', {'rideId': rideId});

  static Future<void> stopRide() => _control.invokeMethod('stopRide');

  static Future<TrackingState> isTracking() async {
    final m = await _control.invokeMapMethod<String, dynamic>('isTracking');
    return TrackingState(m?['tracking'] == true, m?['rideId'] as String?);
  }

  static Future<String> getDbPath() async =>
      (await _control.invokeMethod<String>('getDbPath'))!;

  /// Runs the platform permission chain and returns the final status.
  static Future<Map<String, dynamic>> requestPermissions() async =>
      await _control.invokeMapMethod<String, dynamic>('requestPermissions') ??
      {};

  static Future<Map<String, dynamic>> getPermissionStatus() async =>
      await _control.invokeMapMethod<String, dynamic>('getPermissionStatus') ??
      {};

  static Future<void> openBatteryOptimizationSettings() =>
      _control.invokeMethod('openBatteryOptimizationSettings');
}
