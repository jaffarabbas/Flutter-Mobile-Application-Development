import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController player1 = TextEditingController();
    TextEditingController player2 = TextEditingController();
    double player1value = 0.0;
    double player2value = 0.0;

    void startRace() async{
      print("sdasdasdas");
      // setState(() {
        while (player1value <= 100.0 && player2value <= 100.0) {
        setState(() {
          player1value += 0.1;
          player2value += 0.2;
          print(player1value);
          print(player2value);
        });
         player1.text = player1value.toString();
         player2.text =  player2value.toString();
      }
      // });
    }

 @override
    void initState() {
      super.initState();
      // Timer.periodic(Duration(seconds: 1), (timer) => startRace());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Race App'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                '${player1.value.text} ${player2.value.text}',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Run a Race',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.all(20),
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Player 1',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    // Container(
                    //   width: 250,
                    //   child: LinearProgressIndicator(
                    //     value: double.parse(player1.text.toString()), // a value between 0 and 1
                    //     backgroundColor: Colors.grey,
                    //     minHeight: 30,
                    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 60),
                width: 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${player1value}%',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '100%',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.all(20),
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Player 2',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    // Container(
                    //   width: 250,
                    //   child: LinearProgressIndicator(
                    //     value: double.parse(player2.text.toString()), // a value between 0 and 1
                    //     backgroundColor: Colors.grey,
                    //     minHeight: 30,
                    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 60),
                width: 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${player2value}%',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      '100%',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          // startRace();
                          //  setState(() {
                            startRace();
                            //  Timer.periodic(Duration(seconds: 1), (timer) => startRace());
                          //  });
                        },
                        child: Text('Start'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
