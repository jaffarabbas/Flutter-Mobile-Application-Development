// ignore_for_file: prefer_const_constructors_in_immutables, file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:food_delivery_app/dataSource/datamap.dart';
import 'package:food_delivery_app/widgits/favorateProduct.dart';

class FavorateAppCollection extends StatefulWidget {
  FavorateAppCollection({Key? key})
      : super(key: key);

  @override
  _FavorateAppCollectionState createState() => _FavorateAppCollectionState();
}

class _FavorateAppCollectionState extends State<FavorateAppCollection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top:20,left: 35),
        scrollDirection: Axis.horizontal,
        itemCount: Datamap.DataSource()["favoriteFoods"].length,
        itemBuilder: (context, index) {
          return FavoriteProduct(foodProductInformation: Datamap.DataSource()["favoriteFoods"][index]);
        },
      ),
    );
  }
}
