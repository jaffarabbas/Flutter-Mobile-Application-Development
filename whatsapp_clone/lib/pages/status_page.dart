// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgits/AppSatusTile.dart';

class AppStatusPage extends StatefulWidget {
  AppStatusPage({Key? key}) : super(key: key);

  @override
  _AppStatusPageState createState() => _AppStatusPageState();
}

class _AppStatusPageState extends State<AppStatusPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStatusTitle(isUserStory: true),
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 5),
              child: Text(
                'Recent Updates',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            AppStatusTitle(isUserStory: false),
            AppStatusTitle(isUserStory: false),
            AppStatusTitle(isUserStory: false),
          ],
        ),
      ),
    );
  }
}
