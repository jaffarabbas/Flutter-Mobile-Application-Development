import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/routes/routes.dart';
import 'package:flutter_bloc_pattern/config/routes/routes_name.dart';
import 'package:flutter_bloc_pattern/views/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.homeScreen);
        },
        child: const Center(
          child: Text('GO'),
        ),
      ),
    );
  }
}
