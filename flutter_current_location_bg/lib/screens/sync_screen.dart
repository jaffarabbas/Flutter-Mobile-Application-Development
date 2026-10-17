import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/ride_db.dart';
import '../data/sync_format.dart';
import '../tracker/tracker_channel.dart';

/// Pre-filled when no server URL has been saved yet (dev PC on the local Wi-Fi).
/// Change this if the PC's LAN IP changes.
const defaultServerUrl = 'http://192.168.100.116:3001';

/// Server URL / API key / on-off, plus live upload status.
/// Native code does the actual upload (also while this UI is dead).
class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  final _url = TextEditingController();
  final _key = TextEditingController();
  bool _enabled = false;
  bool _showKey = false;
  bool _loaded = false;
  bool _saving = false;
  bool _syncing = false;
  String _deviceId = '';
  SyncStatus? _status;
  String? _channelError;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _load();
    _timer =
        Timer.periodic(const Duration(seconds: 2), (_) => _refreshStatus());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _url.dispose();
    _key.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final c = await TrackerChannel.getSyncConfig();
      if (!mounted) return;
      setState(() {
        _url.text = c.baseUrl.isEmpty ? defaultServerUrl : c.baseUrl;
        _key.text = c.apiKey;
        _enabled = c.enabled;
        _deviceId = c.deviceId;
        _loaded = true;
      });
      await _refreshStatus();
    } catch (e) {
      _onChannelError(e);
    }
  }

  Future<void> _refreshStatus() async {
    try {
      final s = await TrackerChannel.getSyncStatus();
      if (mounted) setState(() => _status = s);
    } catch (e) {
      _onChannelError(e);
    }
  }

  /// MissingPluginException = the installed APK has older native code than
  /// this Dart code (hot reload/restart never updates Kotlin/Swift).
  void _onChannelError(Object e) {
    _timer?.cancel();
    if (!mounted || _channelError != null) return;
    setState(() {
      _loaded = true;
      _channelError = e is MissingPluginException
          ? 'Native sync code is not installed. Stop the app and run '
              '"flutter run" again (hot reload does not update native code).'
          : 'Sync status unavailable: $e';
    });
  }

  Future<void> _save() async {
    final url = _url.text.trim();
    if (_enabled && !(url.startsWith('http://') || url.startsWith('https://'))) {
      _snack('Server URL must start with http:// or https://');
      return;
    }
    setState(() => _saving = true);
    try {
      final c = await TrackerChannel.setSyncConfig(
          baseUrl: url, apiKey: _key.text, enabled: _enabled);
      if (!mounted) return;
      setState(() {
        _url.text = c.baseUrl;
        _key.text = c.apiKey;
        _enabled = c.enabled;
      });
      _snack('Saved');
      await _refreshStatus();
    } catch (e) {
      _snack('Save failed: $e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _syncNow() async {
    setState(() => _syncing = true);
    try {
      final s = await TrackerChannel.syncNow();
      if (!mounted) return;
      setState(() => _status = s);
      if (!s.enabled) {
        _snack('Sync is off (enable it and Save first)');
      } else {
        _snack(s.lastError == null ? 'Sync complete' : 'Sync failed');
      }
    } catch (e) {
      _snack('Sync failed: $e');
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final s = _status;
    final busy = _syncing || (s?.isSyncing ?? false);
    return Scaffold(
      appBar: AppBar(title: const Text('Server sync')),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : _channelError != null
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Text(_channelError!,
                  style: const TextStyle(color: Colors.red, fontSize: 16)),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  controller: _url,
                  keyboardType: TextInputType.url,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    labelText: 'Server URL',
                    hintText: 'http://192.168.1.10:3001',
                    helperText:
                        'Plain http:// works in debug builds; use https:// in release.',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _key,
                  obscureText: !_showKey,
                  autocorrect: false,
                  decoration: InputDecoration(
                    labelText: 'API key (optional)',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _showKey ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _showKey = !_showKey),
                    ),
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Enabled'),
                  value: _enabled,
                  onChanged: (v) => setState(() => _enabled = v),
                ),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: const Text('Save'),
                ),
                const Divider(height: 32),
                const Text('Device ID'),
                SelectableText(_deviceId,
                    style: const TextStyle(fontFamily: 'monospace')),
                const SizedBox(height: 12),
                if (s != null) ...[
                  Text('Pending rides: ${s.pendingRides}'),
                  Text('Pending points: ${s.pendingPoints}'),
                  Text('Last sync: ${formatAgo(s.lastSyncAt)}'
                      '${s.lastSyncAt == null ? '' : '  (${formatTimestamp(s.lastSyncAt!)})'}'),
                  if (s.lastError != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(s.lastError!,
                          style: const TextStyle(color: Colors.red)),
                    ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  height: 48,
                  child: FilledButton.icon(
                    icon: busy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.sync),
                    label: Text(busy ? 'Syncing…' : 'Sync now'),
                    onPressed: _syncing ? null : _syncNow,
                  ),
                ),
              ],
            ),
    );
  }
}

/// Small cloud + "synced/total" badge for one ride (rides list, map app bar).
class RideSyncBadge extends StatelessWidget {
  final RideSyncInfo info;
  const RideSyncBadge(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    final done = info.isComplete;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(done ? Icons.cloud_done : Icons.cloud_upload,
          size: 18, color: done ? Colors.green : Colors.grey),
      const SizedBox(width: 4),
      Text('${info.syncedPoints}/${info.totalPoints}',
          style: const TextStyle(fontSize: 12)),
    ]);
  }
}
