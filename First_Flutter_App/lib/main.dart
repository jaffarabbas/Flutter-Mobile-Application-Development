import 'package:flutter/material.dart';
import './question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _count = 0;
  var answer = [
    'This is Question one ',
    'this is Question 2',
    'this is Question 3'
  ];
  // ignore: non_constant_identifier_names
  void CLickedButton() {
    setState(() {
      _count += 1;
      if (_count >= 3) {
        _count = 0;
      }
    });
    print(_count);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dark'),
        ),
        body: Column(
          children: [
            Question(answer[_count]),
            RaisedButton(
              child: Text('Answer 1'),
              onPressed: CLickedButton,
            ),
            RaisedButton(
              child: Text('Answer 2'),
              onPressed: CLickedButton,
            ),
            RaisedButton(
              child: Text('Answer 3'),
              onPressed: () {
                print('Answer 3');
              },
            ),
          ],
        ),
      ),
    );
  }
}
