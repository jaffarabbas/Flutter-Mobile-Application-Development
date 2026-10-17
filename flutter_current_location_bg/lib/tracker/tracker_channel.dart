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

/// Native sync settings (`getSyncConfig` / `setSyncConfig`).
class SyncConfig {
  final String baseUrl;
  final String apiKey;
  final bool enabled;
  final String deviceId;

  const SyncConfig({
    required this.baseUrl,
    required this.apiKey,
    required this.enabled,
    required this.deviceId,
  });

  factory SyncConfig.fromMap(Map<dynamic, dynamic> m) => SyncConfig(
        baseUrl: m['baseUrl'] as String? ?? '',
        apiKey: m['apiKey'] as String? ?? '',
        enabled: m['enabled'] == true,
        deviceId: m['deviceId'] as String? ?? '',
      );
}

/// Native sync state (`getSyncStatus` / `syncNow`). Counts come from SQL.
class SyncStatus {
  final bool enabled;
  final String deviceId;
  final int pendingRides;
  final int pendingPoints;

  /// Epoch ms of the last fully successful pass, or null if never.
  final int? lastSyncAt;
  final String? lastError;
  final bool isSyncing;

  const SyncStatus({
    required this.enabled,
    required this.deviceId,
    required this.pendingRides,
    required this.pendingPoints,
    this.lastSyncAt,
    this.lastError,
    required this.isSyncing,
  });

  factory SyncStatus.fromMap(Map<dynamic, dynamic> m) => SyncStatus(
        enabled: m['enabled'] == true,
        deviceId: m['deviceId'] as String? ?? '',
        pendingRides: (m['pendingRides'] as num? ?? 0).toInt(),
        pendingPoints: (m['pendingPoints'] as num? ?? 0).toInt(),
        lastSyncAt: (m['lastSyncAt'] as num?)?.toInt(),
        lastError: m['lastError'] as String?,
        isSyncing: m['isSyncing'] == true,
      );

  bool get hasPending => pendingRides > 0 || pendingPoints > 0;
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

  /// Debug builds only: let mocked fixes pass the filter (still stored with
  /// is_mocked = 1) so routes can be simulated at a desk. Native ignores it in release.
  static Future<bool> getAllowMock() async =>
      await _control.invokeMethod<bool>('getAllowMock') ?? false;

  static Future<bool> setAllowMock(bool allow) async =>
      await _control.invokeMethod<bool>('setAllowMock', {'allow': allow}) ??
      false;

  // --- Server sync (native owns the upload; see docs/SYNC_API.md) ---

  static Future<SyncConfig> getSyncConfig() async => SyncConfig.fromMap(
      await _control.invokeMapMethod<String, dynamic>('getSyncConfig') ?? {});

  /// Native trims the URL, strips a trailing `/` and clears a stored 400 block.
  static Future<SyncConfig> setSyncConfig({
    required String baseUrl,
    required String apiKey,
    required bool enabled,
  }) async =>
      SyncConfig.fromMap(await _control.invokeMapMethod<String, dynamic>(
              'setSyncConfig',
              {'baseUrl': baseUrl, 'apiKey': apiKey, 'enabled': enabled}) ??
          {});

  /// Forced pass (ignores throttle/backoff); completes when the pass is done.
  static Future<SyncStatus> syncNow() async => SyncStatus.fromMap(
      await _control.invokeMapMethod<String, dynamic>('syncNow') ?? {});

  static Future<SyncStatus> getSyncStatus() async => SyncStatus.fromMap(
      await _control.invokeMapMethod<String, dynamic>('getSyncStatus') ?? {});

  static Future<void> openBatteryOptimizationSettings() =>
      _control.invokeMethod('openBatteryOptimizationSettings');
}
