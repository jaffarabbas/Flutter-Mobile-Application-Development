// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AppContext extends StatefulWidget {
  AppContext({ Key? key }) : super(key: key);

  @override
  _AppContextState createState() => _AppContextState();
}

class _AppContextState extends State<AppContext> {
  @override
  Widget build(BuildContext context) {
    return Text(
      context.runtimeType.toString()
    );
  }
}