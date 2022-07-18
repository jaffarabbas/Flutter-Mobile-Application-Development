import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'dart:io' as io;

class CommitPage extends StatefulWidget {
  String path;
  CommitPage({Key? key, required this.path}) : super(key: key);

  @override
  State<CommitPage> createState() => _CommitPageState();
}

class _CommitPageState extends State<CommitPage> {

  @override
  Widget build(BuildContext context) {
    String output = "";
    Future<String> test() async {

      var shell = Shell();
      shell = shell.pushd(widget.path);
      await shell.run('''

      # Display some text
      cd
      git status
      ''').then((value) => {
        setState(() {
          output = value.outText;
        }),
      });
      return output;
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
                    test();
                  },
                ),
              ),
              FutureBuilder<String>(
                future: test(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
