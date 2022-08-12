import 'package:flutter/material.dart';
import 'package:flutter_rest_api_integration/pages/home_page.dart';
import 'package:flutter_rest_api_integration/pages/product_screen.dart';
import 'package:flutter_rest_api_integration/pages/signup_screen.dart';
import 'package:flutter_rest_api_integration/pages/upload_image_screen.dart';
import 'package:flutter_rest_api_integration/pages/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Api Integration',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UploadImage(),
    );
  }
}