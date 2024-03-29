import 'dart:io';

import 'package:flutter/material.dart';
import 'package:git_test_application/pages/commit_page.dart';
import 'package:git_test_application/pages/test.dart';
import 'package:path/path.dart' as p;
import 'package:process_run/shell.dart';
import 'dart:io' as io;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<String> fileForCommit = [];
    var myDir = Directory('J:\\Github\\');

    Future<void> GetCommitDetails(String path) async {
      var shell = Shell();
      shell = shell.pushd(path);
      await shell.run('''

      # Display some text
      cd
      git status --porcelain
      ''').then((value) => {
            setState(() {
              controller.text = value.outText;
            }),
          });
    }

    Future<List<String>> CommitDataList(List data) async {
      // GetCommitDetails();
      for (var element in data) {
        fileForCommit.add(element.toString().split(" ").last);
      }
      //removing file url from the list
      fileForCommit.removeAt(0);
      return fileForCommit;
    }

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
                      onTap: () async {
                        await GetCommitDetails(snapshot.data![index].path).then(
                          (value) => {
                            CommitDataList(
                              controller.text.split("\n"),
                            ),
                          },
                        );
                        // print(fileForCommit);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommitPage(
                              path: snapshot.data![index].path,
                              data: fileForCommit,
                            ),
                          ),
                        );
                      },
                      child: Text(snapshot.data![index].path),
                    ));
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
