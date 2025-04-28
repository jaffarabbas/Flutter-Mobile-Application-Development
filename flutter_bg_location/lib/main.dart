import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LocationExample(),
    );
  }
}

class LocationExample extends StatefulWidget {
  const LocationExample({super.key});

  @override
  _LocationExampleState createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    // Initialize flutter_foreground_task
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'location_channel',
        channelName: 'Location Tracking',
        channelDescription: 'This notification keeps the app tracking your location.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000, // Update every 5 seconds
        autoRunOnBoot: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<void> _startTracking() async {
    // Check and request location service
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location service must be enabled')),
        );
        return;
      }
    }

    // Request location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is required')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is permanently denied')),
      );
      return;
    }

    // Request background location permission (Android: ACCESS_BACKGROUND_LOCATION, iOS: Always)
    if (permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Background location permission is required')),
        );
        return;
      }
    }

    // Start foreground task
    await FlutterForegroundTask.startService(
      notificationTitle: 'Location Tracking',
      notificationText: 'Tracking your location in the background',
      callback: startCallback,
    );

    setState(() {
      _isTracking = true;
    });

    // Listen for location updates
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen((Position position) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'last_location',
        '${position.latitude},${position.longitude}',
      );
      print('Location: ${position.latitude}, ${position.longitude}');
    });
  }

  Future<void> _stopTracking() async {
    await FlutterForegroundTask.stopService();
    setState(() {
      _isTracking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Background Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isTracking ? 'Tracking location...' : 'Not tracking'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isTracking ? _stopTracking : _startTracking,
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
            ),
          ],
        ),
      ),
    );
  }
}

// Background task callback for flutter_foreground_task
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(LocationTaskHandler());
}

class LocationTaskHandler extends TaskHandler {
  @override
  void onStart(DateTime timestamp) {
    print('Foreground task started');
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // Called periodically (every 5 seconds as set in interval)
    // Location updates are handled by Geolocator's stream
  }

  @override
  void onDestroy(DateTime timestamp) {
    print('Foreground task stopped');
  }
}