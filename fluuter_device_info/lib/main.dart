import 'package:flutter/material.dart';

import 'device_uuid_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device UUID',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const UUIDPage(),
    );
  }
}

class UUIDPage extends StatefulWidget {
  const UUIDPage({super.key});

  @override
  State<UUIDPage> createState() => _UUIDPageState();
}

class _UUIDPageState extends State<UUIDPage> {
  late Future<String> _uuidFuture;

  @override
  void initState() {
    super.initState();
    _uuidFuture = DeviceUUIDService.getUUID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Device UUID'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _uuidFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              debugPrint('Error getting UUID: ${snapshot.error}');
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Failed to get UUID: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'This device UUID is:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    snapshot.data ?? 'Unavailable',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
