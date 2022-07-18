import 'dart:io';

import 'package:flutter/material.dart';
import 'package:git_test_application/pages/commit_page.dart';
import 'package:path/path.dart' as p;

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myDir = Directory('J:\\Github\\');
    return Scaffold(
      body: Container(
        child: Center(
          child: FutureBuilder<List<FileSystemEntity>>(
            future: myDir.list().toList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommitPage(path: snapshot.data![index].path),
                            ),
                          );
                        },
                        child: Text(snapshot.data![index].path),
                      )
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}