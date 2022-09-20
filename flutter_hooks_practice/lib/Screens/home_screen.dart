import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1), (_) => DateTime.now().toIso8601String());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
