import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home App'),
        ),
        body: Center(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Text("Hello world!"),
          ),
        ),
        drawer: Drawer(),
      );
  }
}