import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_current_location_bg/data/gpx.dart';
import 'package:flutter_current_location_bg/data/ride_db.dart';
import 'package:flutter_current_location_bg/tracker/tracker_channel.dart';

TrackPoint _pt(String id, double lat, double lng, {bool filtered = false}) =>
    TrackPoint.fromMap({
      'id': id,
      'ride_id': 'r1',
      'lat': lat,
      'lng': lng,
      'accuracy': 5,
      'is_mocked': 0,
      'is_filtered': filtered ? 1 : 0,
      'filter_reason': filtered ? 'low_accuracy' : null,
      'recorded_at': 1700000000000,
    });

void main() {
  test('haversine: 1 degree of latitude is ~111 km', () {
    final d = RideDb.haversine(0, 0, 1, 0);
    expect(d, closeTo(111195, 50));
  });

  test('TrackPoint parses native map with int columns', () {
    final p = _pt('a', 31.5, 74.3, filtered: true);
    expect(p.accuracy, 5.0);
    expect(p.isFiltered, isTrue);
    expect(p.filterReason, 'low_accuracy');
  });

  test('GPX contains every point and marks filtered ones', () {
    final gpx = Gpx.build('r1', [_pt('a', 1, 2), _pt('b', 3, 4, filtered: true)]);
    expect('<trkpt'.allMatches(gpx).length, 2);
    expect(gpx, contains('<type>filtered:low_accuracy</type>'));
    expect(gpx, contains('lat="1.0" lon="2.0"'));
  });
}
