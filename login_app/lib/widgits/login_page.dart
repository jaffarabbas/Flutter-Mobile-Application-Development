// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, use_full_hex_values_for_flutter_colors, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:login_app/containers/textfeild_holder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/main-background.png"),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 20),
                  ),
                ),
                //it hold the textfeild , icons , buttons
                TextFeildHolder(),
                Container(
                  padding : EdgeInsets.only(top:30),
                  child: FlatButton(
                    child: Text(
                      "Forget Passowrd ? ",
                      style: TextStyle(
                        color : Color(0xFFFC5D2B),
                        fontSize:16
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
