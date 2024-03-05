// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class RatingChart extends StatefulWidget {
  int rating;
  RatingChart({Key? key, required this.rating}) : super(key: key);

  @override
  _RatingChartState createState() => _RatingChartState();
}

class _RatingChartState extends State<RatingChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.rating,
            itemBuilder: (context, index) {
              return Icon(
                Icons.star,
                size: 20,
                color: Colors.yellowAccent
              );
            },
          ),
        ],
      ),
    );
  }
}
