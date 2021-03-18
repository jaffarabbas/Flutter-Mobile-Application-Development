import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function SelectHandler;
  final String answer;
  Answer(this.SelectHandler, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(answer),
        onPressed: SelectHandler,
      ),
    );
  }
}
