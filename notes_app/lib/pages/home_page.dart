// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:notes_app/DataSource/datamap.dart';
import 'package:notes_app/pages/create_todo.dart';
import 'package:notes_app/widgits/themes.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primarybackground,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Notes ',
            style: TextStyle(fontSize: 30),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 5),
            child: Container(
              margin: EdgeInsets.only(right: 25),
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.iconbackground,
              ),
              child: Icon(
                Icons.search,
                size: 33,
              ),
            ),
          ),
        ],
        backgroundColor: AppTheme.primarybackground,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: Datamap.DataSource()["todo"].length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 5
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.noteColor2,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    Datamap.DataSource()["todo"][index]["heading"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      Datamap.DataSource()["todo"][index]["timestamp"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.dateColor),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 30, right: 25),
        child: FloatingActionButton(
          backgroundColor: AppTheme.primarybackground,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateTodo()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
