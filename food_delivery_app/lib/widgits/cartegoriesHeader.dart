// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FoodCategoryHeader extends StatelessWidget {
  List<String> headings;
  FoodCategoryHeader({Key? key, required this.headings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.only(left: 35.0,right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: headings[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: headings[1],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'See more >',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
