import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final List messages;
  Messages({Key? key, required this.messages}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}