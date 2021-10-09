// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:login_app/widgits/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Login Page',
       theme: ThemeData(
         fontFamily: GoogleFonts.roboto().fontFamily,
       ),
       home: Material(
         child: LoginPage(),
       ),
     );
  }
}

void main() {
  runApp(MyApp());
}
