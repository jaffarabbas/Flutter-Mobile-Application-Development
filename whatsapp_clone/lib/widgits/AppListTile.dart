// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_initializing_formals, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/routes.dart';

class AppChatTile extends StatefulWidget {
  Map<dynamic, dynamic> userInformation;
  AppChatTile(
      {Key? key,
      required this.userInformation,
      })
      : super(key: key);
  @override
  _AppChatTileState createState() => _AppChatTileState();
}

class _AppChatTileState extends State<AppChatTile> {
  void ChatScreen(BuildContext context){
    Navigator.pushNamed(context, AppRoutes.chatRoute);
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap:() => ChatScreen(context),
        title: Text(widget.userInformation["username"]),
        subtitle: Text('hii jaffar'),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(widget.userInformation["image"]),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '00:00',
              style: TextStyle(
                fontSize: 12
              ),
            ),
          ],
        ),
      );
  }
}
