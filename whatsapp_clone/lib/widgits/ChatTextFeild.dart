// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'package:flutter/material.dart';

class AppChatFeild extends StatefulWidget {
  AppChatFeild({Key? key}) : super(key: key);

  @override
  AppChatFeildState createState() => AppChatFeildState();
}

class AppChatFeildState extends State<AppChatFeild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
                style: TextStyle(
                  fontSize: 18,
                  height: 2
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      )),
                  hintText: 'Enter a Message',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        size: 30,
                      )),
                )),
          ),
          SizedBox(
            width: 10,
          ),
          CircleAvatar(
            radius: 24,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
              iconSize: 27,
              padding: EdgeInsets.only(left: 2),
            ),
          ),
        ],
      ),
    );
  }
}
