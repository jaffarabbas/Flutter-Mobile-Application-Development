// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/widgits/AppChatBubble.dart';
import 'package:whatsapp_clone/widgits/ChatTextFeild.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(''),
            ),
            SizedBox(
              width: 15,
            ),
            Text('Jaffar'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
                  AppChatBubble(isUserMessage: false),
                  AppChatBubble(isUserMessage: true),
               ],
              ),
            ),
          ),
          AppChatFeild(),
        ],
      ),
    );
  }
}
