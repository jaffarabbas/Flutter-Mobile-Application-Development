// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';

class FavoriteProduct extends StatefulWidget {
  Map foodProductInformation;
  FavoriteProduct({ Key? key, required this.foodProductInformation }) : super(key: key);

  @override
  _FavoriteProductState createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
   List<Widget> FoodRating(int rating) {
    List<Widget> lst = [];
    for (var i = 0; i < rating; i++) {
      lst.add(Icon(
        Icons.star,
        size: 15,
        color: Colors.yellowAccent,
      ));
    }
    return lst;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          width: 150,
          height: 50,
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.only(top: 10),
          child: Stack(
            clipBehavior: Clip.none, children: [
              Positioned(
                top: 70,
                child: Container(
                  width: 150,
                  height: 90,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(top:12,left: 15,bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.foodProductInformation["name"]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10
                        ),
                      ),
                      Text(
                        '${widget.foodProductInformation["extras"]}',
                        style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w300,
                            fontSize: 10),
                      ),
                      Row(
                          children: FoodRating(
                              widget.foodProductInformation["rating"])),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 23,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.black45,
                          spreadRadius: 0.1)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage(widget.foodProductInformation["image"]),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.black45,
                          spreadRadius: 0.1)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: RichText(
                      text: TextSpan(
                        text: '\$',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: '${widget.foodProductInformation["price"]}',
                            style: TextStyle(
                              color: Colors.black,
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
        );
  }
}