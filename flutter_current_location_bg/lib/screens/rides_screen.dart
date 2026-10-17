import 'package:flutter/material.dart';

import '../data/ride_db.dart';
import 'map_screen.dart';
import 'sync_screen.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late Future<List<Ride>> _rides = RideDb.rides();

  Future<void> _reload() async {
    setState(() => _rides = RideDb.rides());
    await _rides;
  }

  static String _fmtDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  static String _fmtDate(DateTime t) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${t.year}-${two(t.month)}-${two(t.day)} ${two(t.hour)}:${two(t.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rides')),
      body: FutureBuilder<List<Ride>>(
        future: _rides,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final rides = snap.data!;
          return RefreshIndicator(
            onRefresh: _reload,
            child: rides.isEmpty
                ? ListView(children: const [
                    Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: Text('No rides yet')))
                  ])
                : ListView.separated(
                    itemCount: rides.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final r = rides[i];
                      return ListTile(
                        leading: Icon(
                            r.isActive ? Icons.fiber_manual_record : Icons.route,
                            color: r.isActive ? Colors.red : null),
                        title: Text(_fmtDate(r.start)),
                        subtitle: Text(
                            '${_fmtDuration(r.duration)} · '
                            '${(r.distanceM / 1000).toStringAsFixed(2)} km · '
                            '${r.totalPoints} pts (${r.filteredPoints} filtered)'
                            '${r.isActive ? ' · ACTIVE' : ''}'),
                        trailing: RideSyncBadge(r.syncInfo),
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MapScreen(rideId: r.id)));
                          _reload();
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
