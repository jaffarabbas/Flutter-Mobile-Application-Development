// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIconSet extends StatelessWidget {
  const SocialIconSet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(top: 30),
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Color(0xFFFC5D2B),
                  size: 30,
                ),
                FaIcon(
                  FontAwesomeIcons.google,
                  color: Color(0xFFFC5D2B),
                  size: 30,
                ),
                FaIcon(
                  FontAwesomeIcons.github,
                  color: Color(0xFFFC5D2B),
                  size: 30,
                ),
              ],
            ),
          );
  }
}