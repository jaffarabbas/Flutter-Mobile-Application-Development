import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rest_api_integration/Models/PostModel.dart';
import 'package:flutter_rest_api_integration/Services/Api/apiHandler.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> _posts = [];
  Future<List<PostModel>> getPost() async {
    var data = await ApiHandler.fetchApi('https://jsonplaceholder.typicode.com/posts').then((value) => {
      for (var i in value) {
        _posts.add(PostModel.fromJson(i))
      }
    });
    return _posts;
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
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      print(_posts[index].title);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF626365),
                                offset: Offset(0.0, 0.0), //(x,y)
                                blurRadius: 3.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(_posts[index].title.toString()),
                            subtitle: Text(_posts[index].body.toString()),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: getPost(),
            ),
          ),
        ],
      ),
    );
  }
}
