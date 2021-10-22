// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:widgits_practice/pages/home_page.dart';
import 'package:widgits_practice/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgits_practice/utils/routes.dart';
import 'package:widgits_practice/widgits/themes.dart';

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
      theme: AppTheme.lightTheme(context),
      darkTheme : AppTheme.darkTheme(context),
      initialRoute: AppRoutes.homeRoute,
      routes: {
        AppRoutes.homeRoute: (context) => HomePage(),
        AppRoutes.loginRoute: (context) => LoginPage()
      },
    );
  }
}