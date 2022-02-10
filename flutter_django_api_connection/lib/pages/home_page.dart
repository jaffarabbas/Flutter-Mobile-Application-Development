// ignore_for_file: unnecessary_new, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_django_api_connection/models/Students.dart';
import 'package:flutter_django_api_connection/services/fetchApi.dart';
import 'package:flutter_django_api_connection/widgits/insert_data.dart';
import 'package:flutter_django_api_connection/widgits/userList.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getStudent() async {
    ApiService _apiServices = new ApiService();
    List<Students> dataSource = await _apiServices.fetchData();
    return dataSource;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insert Student Data'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                InsertData()
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Fetching'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder(
            future: getStudent(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return UserList(
                    itemCount: snapshot.data.length,
                    snapshot: snapshot.data,
                );
              } else if (snapshot.hasError) {
                print(getStudent());
                return Text('${snapshot.error}');
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: _showMyDialog,
      child: Icon(Icons.add),
      backgroundColor: Colors.blueAccent,
    ),
    );
  }
}
