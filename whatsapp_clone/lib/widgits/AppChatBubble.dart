// ignore_for_file: file_names, prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AppChatBubble extends StatefulWidget {
  bool isUserMessage;
  AppChatBubble({Key? key,required this.isUserMessage}) : super(key: key);

  @override
  _AppChatBubbleState createState() => _AppChatBubbleState();
}

class _AppChatBubbleState extends State<AppChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      child: Container(
        width: 230,
        padding: EdgeInsets.all(10),
        alignment: widget.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
            color: widget.isUserMessage ? Colors.green[200] : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('heloo'),
          ],
        ),
      ),
    );
  }
}
