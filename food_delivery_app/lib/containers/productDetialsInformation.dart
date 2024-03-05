// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_app/containers/rating.dart';
import 'package:food_delivery_app/dataSource/datamap.dart';

class ProductDetialsInformation extends StatefulWidget {
  const ProductDetialsInformation({Key? key}) : super(key: key);

  @override
  _ProductDetialsInformationState createState() =>
      _ProductDetialsInformationState();
}

class _ProductDetialsInformationState extends State<ProductDetialsInformation> {
  bool flag = false;
  void SetFlag() {
    setState(() {
      if(flag){
        flag = false;
      }else{
        flag = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Datamap.DataSource()["favoriteFoods"][0]["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        Datamap.DataSource()["favoriteFoods"][0]["extras"],
                        style: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                      RatingChart(
                          rating: Datamap.DataSource()["favoriteFoods"][0]
                              ["rating"]),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '\$ ',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    children: [
                      TextSpan(
                        text:
                            '${Datamap.DataSource()["favoriteFoods"][0]["price"]}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30,left:0),
            width: 340,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flag
                      ? Datamap.DataSource()["favoriteFoods"][0]["decription"] +
                          Datamap.DataSource()["favoriteFoods"][0]["decription"]
                      : Datamap.DataSource()["favoriteFoods"][0]["decription"],
                  style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.w900,
                      height: 1.8,
                      fontSize: 15),
                ),
                TextButton(
                  onPressed: () => SetFlag(),
                  child: Text(flag?'Readless...':'Readmore...',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w900)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
