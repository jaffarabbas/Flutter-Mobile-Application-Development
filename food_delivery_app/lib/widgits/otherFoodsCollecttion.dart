// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:food_delivery_app/dataSource/datamap.dart';
import 'package:food_delivery_app/widgits/otherFood.dart';

class OtherFoodCollection extends StatefulWidget {
  OtherFoodCollection({Key? key}) : super(key: key);

  @override
  _OtherFoodCollectionState createState() => _OtherFoodCollectionState();
}

class _OtherFoodCollectionState extends State<OtherFoodCollection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top:20,left: 35),
        scrollDirection: Axis.horizontal,
        itemCount: Datamap.DataSource()["otherFoods"].length,
        itemBuilder: (context, index) {
          return OtherFood(foodProductInformation: Datamap.DataSource()["otherFoods"][index]);
        },
      ),
    );
  }
}

