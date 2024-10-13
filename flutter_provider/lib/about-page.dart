import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/providers/counter-provider.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('About Page'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
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
