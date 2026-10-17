import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../data/gpx.dart';
import '../data/ride_db.dart';
import '../tracker/tracker_channel.dart';
import 'sync_screen.dart';

class MapScreen extends StatefulWidget {
  final String rideId;
  const MapScreen({super.key, required this.rideId});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _map = MapController();
  final List<TrackPoint> _points = [];
  final Set<String> _ids = {};
  StreamSubscription<TrackPoint>? _sub;
  RideSyncInfo? _syncInfo;
  Timer? _syncTimer;

  bool _loading = true;
  bool _active = false;
  bool _mapReady = false;
  bool _showRaw = false;
  bool _showFiltered = true;
  bool _follow = true;

  @override
  void initState() {
    super.initState();
    // Subscribe before loading so no point falls between the DB read and the stream.
    _sub = TrackerChannel.points.listen(_onLivePoint);
    _load();
    _loadSync();
    _syncTimer =
        Timer.periodic(const Duration(seconds: 5), (_) => _loadSync());
  }

  Future<void> _loadSync() async {
    final info = await RideDb.syncInfo(widget.rideId);
    if (mounted) setState(() => _syncInfo = info);
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    final ride = await RideDb.ride(widget.rideId);
    final pts = await RideDb.points(widget.rideId);
    if (!mounted) return;
    setState(() {
      _active = ride?.isActive ?? false;
      for (final p in pts) {
        if (_ids.add(p.id)) _points.add(p);
      }
      _points.sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
      _loading = false;
    });
  }

  void _onLivePoint(TrackPoint p) {
    if (p.rideId != widget.rideId || !_ids.add(p.id)) return;
    setState(() => _points.add(p));
    if (_active && _follow && _mapReady) {
      _map.move(LatLng(p.lat, p.lng), _map.camera.zoom);
    }
  }

  List<LatLng> get _good => [
        for (final p in _points)
          if (!p.isFiltered) LatLng(p.lat, p.lng)
      ];

  void _showDetails(TrackPoint p) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filtered: ${p.filterReason ?? '-'}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Accuracy: ${p.accuracy?.toStringAsFixed(1) ?? '-'} m'),
            Text('Speed: ${p.speed?.toStringAsFixed(2) ?? '-'} m/s'),
            Text('Time: ${p.time}'),
            Text('Provider: ${p.provider ?? '-'}   Mocked: ${p.isMocked}'),
            Text('Lat/Lng: ${p.lat.toStringAsFixed(6)}, ${p.lng.toStringAsFixed(6)}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final good = _good;
    final all = [for (final p in _points) LatLng(p.lat, p.lng)];
    final fitTo = good.isNotEmpty ? good : all;

    return Scaffold(
      appBar: AppBar(
        title: Text(_active ? 'Live ride' : 'Ride map'),
        actions: [
          if (_syncInfo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(child: RideSyncBadge(_syncInfo!)),
            ),
          Builder(
            builder: (ctx) => PopupMenuButton<bool>(
              icon: const Icon(Icons.ios_share),
              tooltip: 'Export GPX',
              onSelected: (includeAll) => Gpx.exportAndShare(
                  ctx, widget.rideId,
                  includeAll: includeAll),
              itemBuilder: (_) => const [
                PopupMenuItem(value: false, child: Text('GPX — good points')),
                PopupMenuItem(value: true, child: Text('GPX — all points')),
              ],
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Wrap(spacing: 8, children: [
                  FilterChip(
                    label: const Text('Raw track'),
                    selected: _showRaw,
                    onSelected: (v) => setState(() => _showRaw = v),
                  ),
                  FilterChip(
                    label: const Text('Filtered points'),
                    selected: _showFiltered,
                    onSelected: (v) => setState(() => _showFiltered = v),
                  ),
                  if (_active)
                    FilterChip(
                      label: const Text('Follow'),
                      selected: _follow,
                      onSelected: (v) => setState(() => _follow = v),
                    ),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                      '${_points.length} pts · ${good.length} good · '
                      '${(RideDb.distanceOf(_points.where((p) => !p.isFiltered).toList()) / 1000).toStringAsFixed(2)} km'),
                ),
                Expanded(
                  child: FlutterMap(
                    mapController: _map,
                    options: MapOptions(
                      initialCenter: const LatLng(0, 0),
                      initialZoom: 2,
                      initialCameraFit: fitTo.isEmpty
                          ? null
                          : CameraFit.coordinates(
                              coordinates: fitTo,
                              padding: const EdgeInsets.all(32),
                              maxZoom: 18,
                            ),
                      onMapReady: () => _mapReady = true,
                      onPositionChanged: (_, hasGesture) {
                        // User panned: stop auto-follow so the map doesn't fight them.
                        if (hasGesture && _follow && _active) {
                          setState(() => _follow = false);
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'com.example.flutter_current_location_bg',
                      ),
                      if (_showRaw && all.length > 1)
                        PolylineLayer(polylines: [
                          Polyline(
                              points: all,
                              color: Colors.grey.withValues(alpha: 0.7),
                              strokeWidth: 2),
                        ]),
                      if (good.length > 1)
                        PolylineLayer(polylines: [
                          Polyline(
                              points: good, color: Colors.blue, strokeWidth: 4),
                        ]),
                      if (_showFiltered)
                        MarkerLayer(markers: [
                          for (final p in _points)
                            if (p.isFiltered)
                              Marker(
                                point: LatLng(p.lat, p.lng),
                                width: 18,
                                height: 18,
                                child: GestureDetector(
                                  onTap: () => _showDetails(p),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                        ]),
                      if (good.isNotEmpty)
                        MarkerLayer(markers: [
                          Marker(
                            point: good.last,
                            width: 22,
                            height: 22,
                            child: const Icon(Icons.navigation,
                                color: Colors.blue, size: 22),
                          ),
                        ]),
                      const RichAttributionWidget(attributions: [
                        TextSourceAttribution('OpenStreetMap contributors'),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
