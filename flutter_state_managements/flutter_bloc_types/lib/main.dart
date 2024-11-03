import 'package:flutter/material.dart';
import 'package:flutter_bloc_types/features/ui/counter_page.dart';
import 'package:flutter_bloc_types/features/ui/counter_snact.dart';
import 'package:flutter_bloc_types/features/ui/snack_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(child: CounterElementSnack()),
    );
  }
}
