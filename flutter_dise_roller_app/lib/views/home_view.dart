import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dise_roller_app/constants/assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int diseValue = 0;
  List<String> diseImages = [
    Assets.d1,
    Assets.d2,
    Assets.d3,
    Assets.d4,
    Assets.d5,
    Assets.d6,
  ];
  String image = Assets.d1;
  @override
  Widget build(BuildContext context) {
    initState() {
      super.initState();
      diseValue = 0;
    }

    void rollDise() {
      setState(() {
        diseValue = 1 + Random().nextInt(5);
        image = diseImages[diseValue];
      });
      print(diseValue);
      print(image);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF6C6C),
        title: Text('Dice Roller'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Dise Roller App',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'You Scored : ${diseValue + 1}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DiseImage(
                image: image,
              ),
              const SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  rollDise();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 90.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFF6C6C),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    'Roll',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiseImage extends StatelessWidget {
  String image;
  DiseImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.asset(image);
  }
}
