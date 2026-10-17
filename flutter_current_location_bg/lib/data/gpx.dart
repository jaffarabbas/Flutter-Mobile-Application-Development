import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../tracker/tracker_channel.dart';
import 'ride_db.dart';

class Gpx {
  /// GPX 1.1 track. Filtered points (only present when [includeAll]) carry
  /// their reason in `<type>`; accuracy and speed go in `<cmt>`.
  static String build(String rideId, List<TrackPoint> pts) {
    final b = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="UTF-8"?>')
      ..writeln('<gpx version="1.1" creator="flutter_current_location_bg" '
          'xmlns="http://www.topografix.com/GPX/1/1">')
      ..writeln('  <trk>')
      ..writeln('    <name>Ride $rideId</name>')
      ..writeln('    <trkseg>');
    for (final pt in pts) {
      b.writeln('      <trkpt lat="${pt.lat}" lon="${pt.lng}">');
      if (pt.altitude != null) b.writeln('        <ele>${pt.altitude}</ele>');
      b.writeln('        <time>${pt.time.toUtc().toIso8601String()}</time>');
      b.writeln('        <cmt>acc=${pt.accuracy?.toStringAsFixed(1)}m '
          'speed=${pt.speed?.toStringAsFixed(2)}m/s provider=${pt.provider}</cmt>');
      if (pt.isFiltered) {
        b.writeln('        <type>filtered:${pt.filterReason}</type>');
      }
      b.writeln('      </trkpt>');
    }
    b
      ..writeln('    </trkseg>')
      ..writeln('  </trk>')
      ..writeln('</gpx>');
    return b.toString();
  }

  static Future<void> exportAndShare(BuildContext context, String rideId,
      {required bool includeAll}) async {
    final box = context.findRenderObject() as RenderBox?;
    final pts = await RideDb.points(rideId, goodOnly: !includeAll);
    final dir = await getTemporaryDirectory();
    final name = 'ride_${rideId.substring(0, 8)}_${includeAll ? 'all' : 'good'}.gpx';
    final file = File(p.join(dir.path, name));
    await file.writeAsString(build(rideId, pts));
    await SharePlus.instance.share(ShareParams(
      files: [XFile(file.path, mimeType: 'application/gpx+xml')],
      subject: name,
      // Required on iPad, harmless elsewhere.
      sharePositionOrigin:
          box == null ? null : box.localToGlobal(Offset.zero) & box.size,
    ));
  }
}
