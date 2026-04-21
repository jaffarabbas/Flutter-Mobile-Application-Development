import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class DeviceUUIDService {
  static const String _keystorageKey = 'app_device_uuid';
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const AndroidId _androidIdPlugin = AndroidId();
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> getUUID() async {
    if (Platform.isAndroid) {
      return _getAndroidUUID();
    }

    if (Platform.isIOS) {
      return _getIOSUUID();
    }

    return _generateNewUUID();
  }

  // Android: directly read ANDROID_ID (same as Cordova).
  static Future<String> _getAndroidUUID() async {
    try {
      final String? androidId = await _androidIdPlugin.getId();
      if (androidId != null && androidId.isNotEmpty) {
        debugPrint('Got Android ID: $androidId');
        return androidId;
      }
    } on MissingPluginException {
      // Plugin may be unavailable until a full app restart after adding it.
    } on PlatformException {
      // Some devices can fail reading ANDROID_ID via platform channel.
    }

    try {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      if (androidInfo.id.isNotEmpty) {
        return androidInfo.id;
      }
    } catch (_) {
      // Fall through to generated UUID.
    }

    return _generateNewUUID();
  }

  // iOS: read from Keychain first (saved by Cordova).
  static Future<String> _getIOSUUID() async {
    String? uuid = await _storage.read(key: _keystorageKey);

    if (uuid != null && uuid.isNotEmpty) {
      return uuid;
    }

    final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
    uuid = iosInfo.identifierForVendor;

    if (uuid != null && uuid.isNotEmpty) {
      await _storage.write(key: _keystorageKey, value: uuid);
      return uuid;
    }

    return _generateNewUUID();
  }

  static Future<String> _generateNewUUID() async {
    final String uuid = const Uuid().v4();
    await _storage.write(key: _keystorageKey, value: uuid);
    return uuid;
  }
}
