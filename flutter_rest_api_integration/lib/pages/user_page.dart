import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rest_api_integration/Models/UserModel.dart';
import 'package:flutter_rest_api_integration/Services/Api/apiHandler.dart';
import 'package:flutter_rest_api_integration/components/userContainer.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<UserModel> _users = [];

  Future<List<UserModel>> getUsers() async {
    var data = await ApiHandler.fetchApi('https://jsonplaceholder.typicode.com/users').then((value) => {
      for (var i in value) {
        _users.add(UserModel.fromJson(i))
      }
    });
    return _users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      return UserCard(user: _users[index]);
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: getUsers(),
            ),
          ),
        ],
      ),
    );
  }
}
