// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class FoodCategoryTag extends StatelessWidget {
  Map<dynamic, dynamic> itemInformation;
  FoodCategoryTag({Key? key, required this.itemInformation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return itemInformation["flag"]
        ? Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(top: 20, right: 16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 80,
            child: Text(
              itemInformation["itemName"],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.only(top: 20, right: 16),
            decoration: BoxDecoration(
              color: Color(0xfffcdb9a),
              borderRadius: BorderRadius.circular(10),
            ),
            width: 90,
            child: Row(
              children: [
                SizedBox(
                  width: 3,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(itemInformation["itemImage"]),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  itemInformation["itemName"],
                  style: TextStyle(
                      color: Colors.red[500],
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          );
  }
}
