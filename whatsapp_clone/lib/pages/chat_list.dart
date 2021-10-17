// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/dataSource/dataMap.dart';
import 'package:whatsapp_clone/widgits/AppListTile.dart';

class ChatList extends StatefulWidget {
  const ChatList({ Key? key }) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  //populate list with map
  List<Widget> Populate(){
    List<Widget> lst = [];
    for(int i = 0; i < DataSource.Datamap()["friendsList"].length;i++){
      lst.add(AppChatTile(userInformation : DataSource.Datamap()["friendsList"][i]));
    }
    print(lst);
    return lst;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: Populate(),
      ),
    );
  }
}