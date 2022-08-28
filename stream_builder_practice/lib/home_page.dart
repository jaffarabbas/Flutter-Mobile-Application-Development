import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> list = [];
  StreamSocket socket = StreamSocket();
  TextEditingController _textController = TextEditingController();
  Stream generateNumber() async* {
    yield 454;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socket.add(list);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Streams'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: socket.getResponce,
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if(snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index]),
                    );
                  },
                );
              }else{
                return Text('No data');
              }
            },),
          ),
           Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                   list.add(_textController.text);
                   socket.add(list);
                   _textController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StreamSocket{
  final _stream = StreamController<List<String>>.broadcast();
  void Function(List<String>) get add => _stream.sink.add;
  Stream<List<String>> get getResponce => _stream.stream.asBroadcastStream();
}