// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class AppCallTile extends StatefulWidget {
  AppCallTile({Key? key}) : super(key: key);

  @override
  _AppCallTileState createState() => _AppCallTileState();
}

class _AppCallTileState extends State<AppCallTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      leading: CircleAvatar(
        radius: 27,
        backgroundImage: NetworkImage(''),
      ),
      title: Text(
        'Ahmed',
      ),
      subtitle: Text('Today 00:00'),
      trailing: Icon(
        Icons.phone,
        color: Colors.green,
      ),
    );
  }
}
