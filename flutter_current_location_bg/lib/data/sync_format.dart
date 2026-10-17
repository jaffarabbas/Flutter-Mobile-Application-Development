import 'package:flutter/material.dart';

import '../tracker/tracker_channel.dart';

/// "12 s ago", "3 min ago", ... for an epoch-ms timestamp; "never" for null.
String formatAgo(int? epochMs, {DateTime? now}) {
  if (epochMs == null) return 'never';
  final diff = (now ?? DateTime.now())
      .difference(DateTime.fromMillisecondsSinceEpoch(epochMs));
  if (diff.inSeconds < 1) return 'just now';
  if (diff.inSeconds < 60) return '${diff.inSeconds} s ago';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} h ago';
  return '${diff.inDays} d ago';
}

/// `2026-10-17 14:03:09` in local time.
String formatTimestamp(int epochMs) {
  final t = DateTime.fromMillisecondsSinceEpoch(epochMs);
  String two(int v) => v.toString().padLeft(2, '0');
  return '${t.year}-${two(t.month)}-${two(t.day)} '
      '${two(t.hour)}:${two(t.minute)}:${two(t.second)}';
}

/// One-line summary for the home screen.
String syncSummary(SyncStatus? s, {DateTime? now}) {
  if (s == null || !s.enabled) return 'Sync off';
  final pending = s.pendingPoints + s.pendingRides;
  final text = 'Sync: $pending pending · last ${formatAgo(s.lastSyncAt, now: now)}';
  return s.lastError == null ? text : '$text · error';
}

/// cloud_off = disabled, cloud_done = nothing pending and no error, else cloud_upload.
IconData syncIcon(SyncStatus? s) {
  if (s == null || !s.enabled) return Icons.cloud_off;
  if (!s.hasPending && s.lastError == null) return Icons.cloud_done;
  return Icons.cloud_upload;
}
