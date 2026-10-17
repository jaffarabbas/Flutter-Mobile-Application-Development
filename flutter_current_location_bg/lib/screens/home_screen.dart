import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../data/ride_db.dart';
import '../tracker/tracker_channel.dart';
import 'map_screen.dart';
import 'rides_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic> _perm = {};
  bool _tracking = false;
  String? _rideId;
  RideStats _stats = RideStats.empty;
  bool _busy = false;
  StreamSubscription<TrackPoint>? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _sub = TrackerChannel.points.listen(_onPoint);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Coming back from settings / background: permissions and counts may have changed.
    if (state == AppLifecycleState.resumed) _refresh();
  }

  /// Re-syncs everything from native + SQLite. Also how an app restart
  /// mid-ride picks the active ride back up.
  Future<void> _refresh() async {
    final perm = await TrackerChannel.getPermissionStatus();
    final t = await TrackerChannel.isTracking();
    final stats =
        t.rideId == null ? RideStats.empty : await RideDb.stats(t.rideId!);
    if (!mounted) return;
    setState(() {
      _perm = perm;
      _tracking = t.tracking;
      _rideId = t.rideId;
      _stats = stats;
    });
  }

  void _onPoint(TrackPoint p) {
    if (p.rideId != _rideId) return;
    setState(() {
      _stats = RideStats(
        _stats.total + 1,
        _stats.good + (p.isFiltered ? 0 : 1),
        _stats.filtered + (p.isFiltered ? 1 : 0),
        p.accuracy,
      );
    });
  }

  Future<void> _requestPermissions() async {
    final perm = await TrackerChannel.requestPermissions();
    if (mounted) setState(() => _perm = perm);
  }

  Future<void> _start() async {
    setState(() => _busy = true);
    try {
      if (_perm['fineLocation'] != true) await _requestPermissions();
      if (_perm['fineLocation'] != true) {
        _snack('Location permission is required');
        return;
      }
      final id = const Uuid().v4();
      await TrackerChannel.startRide(id);
      setState(() {
        _tracking = true;
        _rideId = id;
        _stats = RideStats.empty;
      });
    } catch (e) {
      _snack('Start failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _stop() async {
    setState(() => _busy = true);
    try {
      await TrackerChannel.stopRide();
      await _refresh();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  Widget _permRow(String label, String key) {
    final ok = _perm[key] == true;
    return Row(children: [
      Icon(ok ? Icons.check_circle : Icons.cancel,
          color: ok ? Colors.green : Colors.red, size: 18),
      const SizedBox(width: 8),
      Text(label),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final isAndroid = Platform.isAndroid;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: 'Rides',
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RidesScreen()));
              _refresh();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Permissions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            _permRow('Precise location', 'fineLocation'),
            _permRow(isAndroid ? 'Background location (Allow all the time)' : 'Always location',
                'backgroundLocation'),
            if (isAndroid) _permRow('Notifications', 'notifications'),
            if (isAndroid)
              _permRow('Battery optimization disabled',
                  'ignoringBatteryOptimizations'),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              OutlinedButton(
                onPressed: _requestPermissions,
                child: const Text('Request permissions'),
              ),
              if (isAndroid)
                OutlinedButton(
                  onPressed: TrackerChannel.openBatteryOptimizationSettings,
                  child: const Text('Battery optimization'),
                ),
            ]),
            const Divider(height: 32),
            SizedBox(
              height: 56,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: _tracking ? Colors.red : Colors.green),
                onPressed: _busy ? null : (_tracking ? _stop : _start),
                child: Text(_tracking ? 'STOP RIDE' : 'START RIDE',
                    style: const TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),
            if (_rideId != null) ...[
              Text('Ride: $_rideId', style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Text('Total points: ${_stats.total}'),
              Text('Good points: ${_stats.good}'),
              Text('Filtered points: ${_stats.filtered}'),
              Text('Last accuracy: '
                  '${_stats.lastAccuracy?.toStringAsFixed(1) ?? '-'} m'),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Live map'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MapScreen(rideId: _rideId!))),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
