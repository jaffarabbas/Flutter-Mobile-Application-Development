// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_app/dataSource/datamap.dart';

class ProductSlider extends StatefulWidget {
  ProductSlider({Key? key}) : super(key: key);

  @override
  _ProductSliderState createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 110,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                        Datamap.DataSource()["favoriteFoods"][0]["image"]),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.only(left:35.0),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: CircleAvatar(
              radius: 85,
              backgroundColor: Colors.red,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    Datamap.DataSource()["favoriteFoods"][0]["image"]),
              ),
            ),
          ),
          Container(
            height: 110,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.red,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(
                        Datamap.DataSource()["favoriteFoods"][0]["image"]),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.black87,
                    child: Padding(
                      padding: const EdgeInsets.only(right:35.0),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
