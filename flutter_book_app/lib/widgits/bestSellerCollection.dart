// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_book_app/dataSource/datamap.dart';
import 'package:flutter_book_app/widgits/bestSeller.dart';
import 'package:flutter_book_app/widgits/popularBook.dart';

class BestSellerBookCollection extends StatelessWidget {
  BestSellerBookCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 20, left: 35),
        scrollDirection: Axis.horizontal,
        itemCount: Datamap.DataSource()["bestSeller"].length,
        itemBuilder: (context, index) {
          return BestSeller(
              bookInformation: Datamap.DataSource()["bestSeller"][index]);
        },
      ),
    );
  }
}
