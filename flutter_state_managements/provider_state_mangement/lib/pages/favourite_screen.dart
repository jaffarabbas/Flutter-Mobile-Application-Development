import 'package:flutter/material.dart';

class Favouritepage extends StatefulWidget {
  Favouritepage({Key? key}) : super(key: key);

  @override
  State<Favouritepage> createState() => _FavouritepageState();
}

class _FavouritepageState extends State<Favouritepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Page'),
      ),
      body: Center(
        child: Text('Favourite Page'),
      ),
    );
  }
}