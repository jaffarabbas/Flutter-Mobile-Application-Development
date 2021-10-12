// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:widgits_practice/pages/home_page.dart';
import 'package:widgits_practice/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgits_practice/utils/routes.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: AppRoutes.homeRoute,
      routes: {
        AppRoutes.homeRoute: (context) => HomePage(),
        AppRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}