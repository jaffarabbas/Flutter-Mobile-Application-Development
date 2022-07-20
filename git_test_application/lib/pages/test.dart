import 'package:flutter/material.dart';

class CommitData extends StatefulWidget {
  Future<List<String>> data;
  CommitData({Key? key, required this.data}) : super(key: key);

  @override
  State<CommitData> createState() => _CommitDataState();
}

class _CommitDataState extends State<CommitData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.data.then((value) => {
      setState(() {
        print(value);
      }),
    });
  }
  @override
  Widget build(BuildContext context) {
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
      body:  Container(
        height: 500,
        child: Text(widget.data.toString()),
      ),
    );
  }
}
