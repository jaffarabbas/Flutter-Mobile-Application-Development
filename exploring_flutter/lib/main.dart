// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:exploring_flutter/constraints/work_1.dart';
import 'package:exploring_flutter/context/work_2.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // body: AppConstrients(),
        body: Center(
          child: AppContext(),
        )
      ),
    );
  }
}