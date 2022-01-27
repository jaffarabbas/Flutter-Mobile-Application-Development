// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_10/pages/home_page.dart';
import 'package:flutter_app_10/pages/profile.dart';

class AppDrawer extends StatefulWidget {
  User user;
  AppDrawer({Key? key,required this.user}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              currentAccountPictureSize: Size(50, 50),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  "${widget.user.photoURL}"
                ),
              ),
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text("${widget.user.displayName}"),
              accountEmail: Text("${widget.user.email}"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(user:widget.user)),
              );
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.green,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(user:widget.user)),
              );
            },
            child: ListTile(
              leading: Icon(
                CupertinoIcons.chat_bubble_fill,
                color: Colors.green,
              ),
              title: Text(
                "Chat",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
