// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class AppStatusTitle extends StatefulWidget {
  bool isUserStory;
  AppStatusTitle({Key? key,required this.isUserStory}) : super(key: key);

  @override
  _AppStatusTitleState createState() => _AppStatusTitleState();
}

class _AppStatusTitleState extends State<AppStatusTitle> {
  @override
  Widget build(BuildContext context) {
    return widget.isUserStory ? Container(
      height: 80,
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD3D3D3),
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(''),
            child: Icon(Icons.add_rounded),
          ),
          SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'My Status',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16),
              children: [
                TextSpan(
                    text: '\nTap To Add Status Update',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    ) :
    Container(
      height: 80,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 27,
            backgroundImage: NetworkImage(''),
          ),
          SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(
              text: 'Ahmed',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15),
              children: [
                TextSpan(
                    text: '\nToday at 00:00',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
