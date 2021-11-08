// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/DataSource/datamap.dart';
import 'package:notes_app/widgits/themes.dart';

class CreateTodo extends StatefulWidget {
  CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController controller = new TextEditingController();
  void insert() {
    // print(controller.value.text);
    print(Datamap.DataSource()["todo"].length);
    setState(() {
      Datamap.DataSource()["todo"].add({
        'heading': controller.value.text,
        'description':
            'How to make your oesonal brand stand out onlineHow to make your oesonal brand stand out onlineHow to make your oesonal brand stand out onlineHow to make your oesonal brand stand out onlineHow to make your oesonal brand stand out onlineHow to make your oesonal brand stand out online',
        'timestamp': '1-jan-2021',
        'isOne': true,
      });
      // print(Datamap.DataSource()["todo"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primarybackground,
      appBar: AppBar(
        leadingWidth: 80,
        leading: Container(
          margin: EdgeInsets.only(left: 30),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            alignment: Alignment.center,
            height: 20,
            // width: 40,
            // margin:EdgeInsets.only(left:10),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppTheme.iconbackground,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              insert();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 25),
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppTheme.iconbackground,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: AppTheme.primarybackground,
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
        ],
      ),
    );
  }
}
