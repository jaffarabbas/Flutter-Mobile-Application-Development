import 'package:flutter/material.dart';

class GridContainer extends StatelessWidget {
  String text;
  Color? color;
  GridContainer({Key? key, required this.text,required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      height: 60,
      width: 40,
      child: Text('$text'),
    );
  }
}
