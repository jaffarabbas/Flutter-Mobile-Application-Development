import 'package:flutter/material.dart';

void main() => runApp(myApp());

// ignore: camel_case_types
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("First App"),
      ),
      body:Container(
        child: Text("My name is Jaffar"),
      ),
    );
  }
}
