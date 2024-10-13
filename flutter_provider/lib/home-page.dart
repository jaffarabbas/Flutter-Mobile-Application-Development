import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/about-page.dart';
import 'package:flutter_provider/providers/counter-provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Provider'),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              icon: Icon(Icons.folder)),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            value.add();
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: value.numbers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value.numbers[index].toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
