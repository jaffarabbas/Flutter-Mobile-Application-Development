// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';

class OtherFood extends StatefulWidget {
  Map foodProductInformation;
  OtherFood({Key? key, required this.foodProductInformation}) : super(key: key);

  @override
  _OtherFoodState createState() => _OtherFoodState();
}

class _OtherFoodState extends State<OtherFood> {
  List<Widget> FoodRating(int rating) {
    List<Widget> lst = [];
    for (var i = 0; i < rating; i++) {
      lst.add(Icon(
        Icons.star,
        size: 12,
        color: Colors.yellowAccent,
      ));
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(right: 12),
      width: 150,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none, children: [
            Positioned(
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  children: [
                    Container(
                      height: 110,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage(widget.foodProductInformation["image"]),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: 8, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: FoodRating(
                              widget.foodProductInformation["rating"],
                            ),
                          ),
                          Text(
                            '${widget.foodProductInformation["name"]}',
                            style: TextStyle(
                                backgroundColor: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              ),
            ),
            Positioned(
              right: -13,
              top: -10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3, color: Colors.black45, spreadRadius: 0.1)
                  ],
                ),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.red,
                  child: RichText(
                    text: TextSpan(
                      text: '\$',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: '${widget.foodProductInformation["price"]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
