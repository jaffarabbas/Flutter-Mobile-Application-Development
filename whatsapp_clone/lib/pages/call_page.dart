// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgits/AppCallTile.dart';

class AppCallPage extends StatefulWidget {
  AppCallPage({Key? key}) : super(key: key);

  @override
  _AppCallPageState createState() => _AppCallPageState();
}

class _AppCallPageState extends State<AppCallPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCallTile(),
            AppCallTile(),
            AppCallTile(),
            AppCallTile(),
            AppCallTile(),
            AppCallTile(),
            AppCallTile(),
          ],
        ),
      ),
    );
  }
}
