import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duaration = Duration.zero;
  Duration position = Duration.zero;
  @override
  Widget build(BuildContext context) {
    // final a = Provider.of<ChangeNotifier>(context, listen: false);
    initState(){
      print('asdasd');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Player'),
      ),
      body: Container(
        child: Column(
          children: [
            Slider(
              min: 0,
              max: duaration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(position.toString()),
                Text((duaration - position).toString())
              ],
            ),
            CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                  if(isPlaying){
                    await audioPlayer.pause();
                  }else{
                    String url = '';
                    await audioPlayer.play(UrlSource(url));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}