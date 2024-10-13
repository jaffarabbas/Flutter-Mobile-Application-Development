import 'package:flutter/material.dart';
import 'package:flutter_provider/home-page.dart';
import 'package:flutter_provider/providers/counter-provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CounterProvider())
        ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
