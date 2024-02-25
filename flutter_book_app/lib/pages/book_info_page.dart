// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_book_app/containers/rating.dart';
import 'package:flutter_book_app/widgits/theme.dart';

class BookDetials extends StatefulWidget {
  Map bookDetials;
  BookDetials({Key? key, required this.bookDetials}) : super(key: key);

  @override
  _BookDetialsState createState() => _BookDetialsState();
}

class _BookDetialsState extends State<BookDetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.productBackgroundColor,
      appBar: AppBar(
        leadingWidth: 50,
        toolbarHeight: 110,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            color: AppTheme.primaryFontcolor,
            iconSize: 20,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Icon(
            Icons.bookmark_outline_rounded,
            color: AppTheme.primaryFontcolor,
            size: 25,
          ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.more_vert_rounded,
              color: AppTheme.primaryFontcolor,
              size: 25,
            ),
          ),
        ],
        backgroundColor: AppTheme.productBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              width: double.infinity,
              color: AppTheme.productBackgroundColor,
              child: Column(
                children: [
                  Image.asset(widget.bookDetials["image"], height: 200),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      widget.bookDetials["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      widget.bookDetials["author"],
                      style: TextStyle(
                        color: AppTheme.paragraphFontcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  RatingChart(rating: widget.bookDetials["rating"]),
                ],
              ),
            ),
            Container(
              color: AppTheme.secondryFontcolor,
              padding: EdgeInsets.only(top:0,left:0,right:0,bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0),
                    margin: EdgeInsets.only(top: 13, left: 35),
                    width: 300,
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(
                        width: 1.5,
                        color: AppTheme.paragraphFontcolor,
                      ),
                    )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 25),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              color: AppTheme.primaryFontcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 25, bottom: 0),
                          child: Text(
                            widget.bookDetials["decription"],
                            style: TextStyle(
                              height: 1.4,
                              color: AppTheme.paragraphFontcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.primaryFontcolor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.format_align_left_sharp,
                                color: AppTheme.primaryFontcolor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Preview',
                                  style: TextStyle(
                                    color: AppTheme.primaryFontcolor,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppTheme.primaryFontcolor,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.message_outlined,
                                color: AppTheme.primaryFontcolor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Review',
                                style: TextStyle(
                                  color: AppTheme.primaryFontcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 90, vertical: 16),
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Buy Now For \$${widget.bookDetials["price"]}',
                        style: TextStyle(
                          color: AppTheme.secondryFontcolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
