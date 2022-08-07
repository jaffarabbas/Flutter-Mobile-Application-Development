import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_integration/components/convertLatLangToAddress.dart';
import 'package:flutter_map_integration/components/custom_marker.dart';
import 'package:flutter_map_integration/components/custome_Info_window.dart';
import 'package:flutter_map_integration/components/google_places_api.dart';
import 'package:flutter_map_integration/components/polygone_screen.dart';
import 'package:flutter_map_integration/components/polyline.dart';
import 'package:flutter_map_integration/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Map Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PolyLineIntegration(),
    );
  }
}