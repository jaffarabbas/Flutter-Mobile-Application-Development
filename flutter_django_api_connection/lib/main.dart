// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_django_api_connection/pages/dashboard.dart';
import 'package:flutter_django_api_connection/pages/home_page.dart';
import 'package:flutter_django_api_connection/pages/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}