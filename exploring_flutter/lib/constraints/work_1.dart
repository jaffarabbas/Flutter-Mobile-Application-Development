// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AppConstrients extends StatefulWidget {
  AppConstrients({ Key? key }) : super(key: key);

  @override
  _AppConstrientsState createState() => _AppConstrientsState();
}

class _AppConstrientsState extends State<AppConstrients> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      constraints: BoxConstraints(
        minHeight: 50,
        minWidth: 100,
        maxHeight: 200,
        maxWidth: 200
      ),
     // padding: EdgeInsets.all(20),
      child: Container(
        height: 50,
        width: 90,
        color: Colors.red,
      ),
    );
  }
}