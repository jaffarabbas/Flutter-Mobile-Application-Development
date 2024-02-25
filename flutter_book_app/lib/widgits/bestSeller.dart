// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_book_app/pages/book_info_page.dart';
import 'package:flutter_book_app/widgits/theme.dart';

class BestSeller extends StatefulWidget {
  Map bookInformation;
  BestSeller({Key? key,required this.bookInformation}) : super(key: key);

  @override
  _BestSellerState createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetials(bookDetials: widget.bookInformation),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.bookInformation["image"],
                height: 200),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                widget.bookInformation["name"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                widget.bookInformation["author"],
                style: TextStyle(
                  color: AppTheme.paragraphFontcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
