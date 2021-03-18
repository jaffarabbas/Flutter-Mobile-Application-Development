import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function reset;

  Result(this.score, this.reset);

  String get result {
    String message;
    if (score <= 25) {
      message = "You Are the DarkLord";
    } else {
      message = "Your not";
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(result,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Submit Again'),
            onPressed: reset,
          ),
        ],
      ),
    );
  }
}
