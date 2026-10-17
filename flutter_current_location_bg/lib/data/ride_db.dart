import 'dart:math';

import 'package:sqflite/sqflite.dart';

import '../tracker/tracker_channel.dart';

class Ride {
  final String id;
  final int startedAt;
  final int? endedAt;
  final String status;
  final int totalPoints;
  final int goodPoints;
  final double distanceM;

  const Ride({
    required this.id,
    required this.startedAt,
    required this.endedAt,
    required this.status,
    required this.totalPoints,
    required this.goodPoints,
    required this.distanceM,
  });

  bool get isActive => status == 'active';
  int get filteredPoints => totalPoints - goodPoints;
  DateTime get start => DateTime.fromMillisecondsSinceEpoch(startedAt);

  Duration get duration => Duration(
        milliseconds:
            (endedAt ?? DateTime.now().millisecondsSinceEpoch) - startedAt,
      );
}

class RideStats {
  final int total;
  final int good;
  final int filtered;
  final double? lastAccuracy;
  const RideStats(this.total, this.good, this.filtered, this.lastAccuracy);
  static const empty = RideStats(0, 0, 0, null);
}

/// Read-only access to the SQLite file owned by native code.
/// Native creates the schema; Flutter never writes to it.
class RideDb {
  static Future<Database>? _db;

  static Future<Database> get db => _db ??= _open();

  static Future<Database> _open() async {
    final path = await TrackerChannel.getDbPath();
    return openDatabase(
      path,
      singleInstance: true,
      onConfigure: (db) async {
        // WAL lets us read while the native side is inserting.
        await db.rawQuery('PRAGMA journal_mode=WAL');
      },
    );
  }

  static Future<List<Ride>> rides() async {
    final d = await db;
    final rows = await d.rawQuery('''
      SELECT r.*,
        (SELECT COUNT(*) FROM points p WHERE p.ride_id = r.id) AS total,
        (SELECT COUNT(*) FROM points p WHERE p.ride_id = r.id AND p.is_filtered = 0) AS good
      FROM rides r ORDER BY r.started_at DESC
    ''');
    final result = <Ride>[];
    for (final r in rows) {
      final id = r['id'] as String;
      result.add(Ride(
        id: id,
        startedAt: r['started_at'] as int,
        endedAt: r['ended_at'] as int?,
        status: r['status'] as String,
        totalPoints: r['total'] as int,
        goodPoints: r['good'] as int,
        distanceM: distanceOf(await points(id, goodOnly: true)),
      ));
    }
    return result;
  }

  static Future<Ride?> ride(String id) async {
    final all = await rides();
    for (final r in all) {
      if (r.id == id) return r;
    }
    return null;
  }

  static Future<List<TrackPoint>> points(String rideId,
      {bool goodOnly = false}) async {
    final d = await db;
    final rows = await d.query(
      'points',
      where: goodOnly ? 'ride_id = ? AND is_filtered = 0' : 'ride_id = ?',
      whereArgs: [rideId],
      orderBy: 'recorded_at ASC',
    );
    return rows.map(TrackPoint.fromMap).toList();
  }

  static Future<RideStats> stats(String rideId) async {
    final d = await db;
    final rows = await d.rawQuery('''
      SELECT COUNT(*) AS total,
        COALESCE(SUM(CASE WHEN is_filtered = 0 THEN 1 ELSE 0 END), 0) AS good,
        (SELECT accuracy FROM points WHERE ride_id = ?1 ORDER BY recorded_at DESC LIMIT 1) AS last_acc
      FROM points WHERE ride_id = ?1
    ''', [rideId]);
    final r = rows.first;
    final total = r['total'] as int;
    final good = r['good'] as int;
    return RideStats(
        total, good, total - good, (r['last_acc'] as num?)?.toDouble());
  }

  /// Total Haversine distance in meters along the given points.
  static double distanceOf(List<TrackPoint> pts) {
    var sum = 0.0;
    for (var i = 1; i < pts.length; i++) {
      sum += haversine(pts[i - 1].lat, pts[i - 1].lng, pts[i].lat, pts[i].lng);
    }
    return sum;
  }

  static double haversine(double lat1, double lng1, double lat2, double lng2) {
    const r = 6371000.0;
    double rad(double d) => d * pi / 180;
    final dLat = rad(lat2 - lat1);
    final dLng = rad(lng2 - lng1);
    final a = pow(sin(dLat / 2), 2) +
        cos(rad(lat1)) * cos(rad(lat2)) * pow(sin(dLng / 2), 2);
    return 2 * r * asin(sqrt(a));
  }
}
