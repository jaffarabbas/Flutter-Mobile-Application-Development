// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

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
                  "data:image/png;base64,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",
                ),
              ),
              accountName: Text("Jaffar"),
              accountEmail: Text("gamaportal8@gmail.com"),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.deepPurple,
            ),
            title: Text(
              "Home",
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.deepPurple
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.deepPurple,
            ),
            title: Text(
              "Profile",
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.deepPurple
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.mail,
              color: Colors.deepPurple,
            ),
            title: Text(
              "Email me",
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.deepPurple
              ),
            ),
          ),
        ],
      ),
    );
  }
}
