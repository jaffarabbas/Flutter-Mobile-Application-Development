import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_current_location_bg/data/ride_db.dart';
import 'package:flutter_current_location_bg/data/sync_format.dart';
import 'package:flutter_current_location_bg/tracker/tracker_channel.dart';

SyncStatus _status({
  bool enabled = true,
  int rides = 0,
  int points = 0,
  int? lastSyncAt,
  String? error,
}) =>
    SyncStatus.fromMap({
      'enabled': enabled,
      'deviceId': 'd1',
      'pendingRides': rides,
      'pendingPoints': points,
      'lastSyncAt': lastSyncAt,
      'lastError': error,
      'isSyncing': false,
    });

void main() {
  final now = DateTime.fromMillisecondsSinceEpoch(1760700000000);
  int ago(Duration d) => now.subtract(d).millisecondsSinceEpoch;

  group('SyncStatus.fromMap', () {
    test('parses a full native map', () {
      final s = SyncStatus.fromMap({
        'enabled': true,
        'deviceId': '8f0c2b7e',
        'pendingRides': 1,
        'pendingPoints': 120,
        'lastSyncAt': 1760700000000,
        'lastError': 'Network error: timeout',
        'isSyncing': true,
      });
      expect(s.enabled, isTrue);
      expect(s.deviceId, '8f0c2b7e');
      expect(s.pendingRides, 1);
      expect(s.pendingPoints, 120);
      expect(s.lastSyncAt, 1760700000000);
      expect(s.lastError, 'Network error: timeout');
      expect(s.isSyncing, isTrue);
      expect(s.hasPending, isTrue);
    });

    test('tolerates nulls / missing keys', () {
      final s = SyncStatus.fromMap({'lastSyncAt': null, 'lastError': null});
      expect(s.enabled, isFalse);
      expect(s.pendingPoints, 0);
      expect(s.lastSyncAt, isNull);
      expect(s.lastError, isNull);
      expect(s.hasPending, isFalse);
    });
  });

  test('SyncConfig.fromMap', () {
    final c = SyncConfig.fromMap({
      'baseUrl': 'http://192.168.1.10:3001',
      'apiKey': '',
      'enabled': true,
      'deviceId': 'abc',
    });
    expect(c.baseUrl, 'http://192.168.1.10:3001');
    expect(c.enabled, isTrue);
    expect(c.deviceId, 'abc');
    expect(SyncConfig.fromMap({}).enabled, isFalse);
  });

  group('formatAgo', () {
    test('null is never', () => expect(formatAgo(null, now: now), 'never'));
    test('seconds', () {
      expect(formatAgo(ago(Duration.zero), now: now), 'just now');
      expect(formatAgo(ago(const Duration(seconds: 12)), now: now), '12 s ago');
    });
    test('minutes / hours / days', () {
      expect(formatAgo(ago(const Duration(minutes: 3, seconds: 5)), now: now),
          '3 min ago');
      expect(formatAgo(ago(const Duration(hours: 2)), now: now), '2 h ago');
      expect(formatAgo(ago(const Duration(days: 3)), now: now), '3 d ago');
    });
    test('clock skew (future) is just now', () {
      expect(formatAgo(ago(const Duration(seconds: -30)), now: now), 'just now');
    });
  });

  test('formatTimestamp pads fields', () {
    final ms = DateTime(2026, 1, 2, 3, 4, 5).millisecondsSinceEpoch;
    expect(formatTimestamp(ms), '2026-01-02 03:04:05');
  });

  group('syncSummary / syncIcon', () {
    test('off', () {
      expect(syncSummary(null), 'Sync off');
      expect(syncSummary(_status(enabled: false)), 'Sync off');
      expect(syncIcon(_status(enabled: false)), Icons.cloud_off);
    });
    test('pending', () {
      final s = _status(
          rides: 1, points: 4, lastSyncAt: ago(const Duration(seconds: 12)));
      expect(syncSummary(s, now: now), 'Sync: 5 pending · last 12 s ago');
      expect(syncIcon(s), Icons.cloud_upload);
    });
    test('all synced', () {
      final s = _status(lastSyncAt: ago(const Duration(seconds: 1)));
      expect(syncIcon(s), Icons.cloud_done);
    });
    test('error', () {
      final s = _status(error: 'Unauthorized (check API key)');
      expect(syncSummary(s, now: now), 'Sync: 0 pending · last never · error');
      expect(syncIcon(s), Icons.cloud_upload);
    });
  });

  test('RideSyncInfo.isComplete needs ride + all points synced', () {
    expect(const RideSyncInfo(true, 10, 10).isComplete, isTrue);
    expect(const RideSyncInfo(false, 10, 10).isComplete, isFalse);
    expect(const RideSyncInfo(true, 9, 10).isComplete, isFalse);
    expect(const RideSyncInfo(true, 0, 0).isComplete, isTrue);
  });
}
