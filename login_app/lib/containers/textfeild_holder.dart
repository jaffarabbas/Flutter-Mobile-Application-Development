// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, use_full_hex_values_for_flutter_colors, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_app/containers/login_button.dart';
import 'package:login_app/containers/social_icon_set.dart';

class TextFeildHolder extends StatelessWidget {
  const TextFeildHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 300,
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 6,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 250,
            margin: EdgeInsets.only(top: 40),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter Username",
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Color(0xFFFC5D2B),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: FaIcon(
                    FontAwesomeIcons.solidUserCircle,
                    color: Color(0xFFFC5D2B),
                    size: 30,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFC5D2B), width: 2.3),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFC5D2B), width: 2.3),
                ),
              ),
            ),
          ),
          Container(
            width: 250,
            margin: EdgeInsets.only(top: 40),
            child: TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Enter Password",
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Color(0xFFFC5D2B),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: FaIcon(
                    FontAwesomeIcons.lock,
                    color: Color(0xFFFC5D2B),
                    size: 30,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFC5D2B), width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFC5D2B), width: 2),
                ),
              ),
            ),
          ),
          //contains icon set facebook,google,github
          SocialIconSet(),
          //it contains the logon button
          LoginButton(),
        ],
      ),
    );
  }
}
