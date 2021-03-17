import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

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
  var count = 0;
  var totalScore = 0;

  final question = [
    {
      'questiontext': 'whats your Namme ? ',
      'answer': [
        {'text': 'jaffar', 'score': 10},
        {'text': 'rrrr', 'score': 5},
        {'text': 'dsfsdf', 'score': 9},
        {'text': 'asmi', 'score': 0}
      ]
    },
    {
      'questiontext': 'whats your car ? ',
      'answer': [
        {'text': 'lamborgini', 'score': 10},
        {'text': 'farari', 'score': 5},
        {'text': 'tesla', 'score': 9},
        {'text': 'jaguar', 'score': 0}
      ]
    },
    {
      'questiontext': 'whats your age ? ',
      'answer': [
        {'text': '21', 'score': 10},
        {'text': '22', 'score': 5},
        {'text': '23', 'score': 9},
        {'text': '20', 'score': 0}
      ]
    }
  ];
  // ignore: non_constant_identifier_names
  void CLickedButton(int score) {
    totalScore += score;
    setState(() {
      count += 1;
    });
    print(count);
  }

  void resetQuiz() {
    setState(() {
      count = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dark'),
        ),
        body: count < question.length
            ? Quiz(
                answerQuestion: CLickedButton,
                questionIndex: count,
                questions: question)
            : Result(totalScore,resetQuiz),
      ),
    );
  }
}
