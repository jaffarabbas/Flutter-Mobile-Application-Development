import 'package:flutter/material.dart';
import 'package:git_test_application/methods/commitMessage.dart';
import 'package:process_run/shell.dart';
import 'dart:io' as io;

class CommitPage extends StatefulWidget {
  String path;
  List<String> data;
  CommitPage({Key? key, required this.path, required this.data})
      : super(key: key);

  @override
  State<CommitPage> createState() => _CommitPageState();
}

class _CommitPageState extends State<CommitPage> {
  TextEditingController controller = TextEditingController();
  List<String> fileForCommit = [];
  @override
  Widget build(BuildContext context) {
    bool flag = false;
    //get commit detials of a repo
    Future<void> GetCommitDetails() async {
      var shell = Shell();
      shell = shell.pushd(widget.path);
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

    //commit the files
    Future<void> CommitFiles(String file) async {
      var shell = Shell();
      shell = shell.pushd(widget.path);
      await shell.run('''
      # Display some text
      cd
      git add $file
      git commit -m "Commited $file ${CommitHelperClass.commitMessage(file.toString())}"
      ''');
    }

    Future<void> Committer(List file) async {
      int c = 0;
      for (var element in file) {
        c++;
        print("$c $element");
        await CommitFiles(element);
      }
      fileForCommit = [];
    }

    Future<void> PushCommitedFile() async {
      var shell = Shell();
      shell = shell.pushd(widget.path);
      await shell.run('''
      # Display some text
      cd
      git push
      ''');
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Commit'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.path),
              Container(
                color: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 50),
                margin: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: const Icon(Icons.done),
                  color: Colors.white,
                  onPressed: () {
                    setState(() {});
                    print(widget.data);
                    GetCommitDetails();
                  },
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: InkWell(
                      onTap: () {
                        CommitFiles(widget.data[index]);
                      },
                      child: Text("$index ${widget.data[index]}"),
                    ));
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  // Committer(fileForCommit)
                  //     .whenComplete(() => PushCommitedFile());
                },
                child: Container(
                  color: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 50),
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Commit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
