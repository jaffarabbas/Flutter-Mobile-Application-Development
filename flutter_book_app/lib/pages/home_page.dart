// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_book_app/widgits/bestSellerCollection.dart';
import 'package:flutter_book_app/widgits/popularBookCollection.dart';
import 'package:flutter_book_app/widgits/theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                'Popular Now',
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            PopularBooksCollection(),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 14),
              child: Text(
                'BestSellers',
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryFontcolor),
              ),
            ),
            BestSellerBookCollection(),
          ],
        ),
      ),
    );
  }
}
