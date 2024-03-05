// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery_app/containers/productCartConfirmation.dart';
import 'package:food_delivery_app/containers/productDetialsInformation.dart';
import 'package:food_delivery_app/containers/productSlider.dart';

class ProductDetials extends StatefulWidget {
  ProductDetials({Key? key}) : super(key: key);

  @override
  _ProductDetialsState createState() => _ProductDetialsState();
}

class _ProductDetialsState extends State<ProductDetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15),
          child: Icon(
            Icons.arrow_back,
            color: Colors.red,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          // width: 400,
          margin: EdgeInsets.only(top: 15),
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Color(0xfff0e6d1), width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: Color(0xfff0e6d1), width: 0),
              ),
              filled: true,
              hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              hintText: "Search Your Food",
              fillColor: Color(0xfff0e6d1),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[500],
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.red,
              child: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage('assets/Images/admin.jpeg'),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSlider(),
              ProductDetialsInformation(),
              CartConfirmation(),
            ],
          ),
        ),
      ),
    );
  }
}
