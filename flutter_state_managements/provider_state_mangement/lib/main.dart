import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_mangement/pages/count.dart';
import 'package:provider_state_mangement/pages/favourite_screen.dart';
import 'package:provider_state_mangement/provider/count_provider.dart';
import 'package:provider_state_mangement/provider/favourite_provider.dart';
import 'package:provider_state_mangement/provider/slider_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create:  (_) => CountProvider()),
         ChangeNotifierProvider(create:  (_) => SliderProvider()),
         ChangeNotifierProvider(create:  (_) => FavouriteProvider())
      ],
      child: MaterialApp(
        title: 'Provider Sate Mangement',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Favouritepage(),
      ),
    );
  }
}
