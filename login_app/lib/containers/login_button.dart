// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(top: 24),
      child: FlatButton(
        padding: EdgeInsets.all(13),
        color: Color(0xFFFC5D2B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Text(
          'LOGIN HERE',
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }
}
