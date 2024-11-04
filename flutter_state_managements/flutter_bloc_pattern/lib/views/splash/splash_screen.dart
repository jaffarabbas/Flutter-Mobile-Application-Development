import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/components/internet_exception_widgit.dart';
import 'package:flutter_bloc_pattern/config/components/round_button.dart';
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
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InternetExceptionWidgit(
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
