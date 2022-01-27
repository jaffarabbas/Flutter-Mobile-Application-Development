// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_10/widgits/drawer.dart';

class ProfilePage extends StatefulWidget {
  User user;
  ProfilePage({ Key? key,required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green,
              width: 400,
              height: 300,
              child: Container(
                padding: EdgeInsets.all(50),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("${widget.user.photoURL}"),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text(
                    "Name",
                  ),
                  subtitle: Text(
                    "${widget.user.displayName}"
                  ),
                ),
                ListTile(
                  title: Text(
                    "Email",
                  ),
                  subtitle: Text(
                    "${widget.user.email}"
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: AppDrawer(user: widget.user),
    );
  }
}