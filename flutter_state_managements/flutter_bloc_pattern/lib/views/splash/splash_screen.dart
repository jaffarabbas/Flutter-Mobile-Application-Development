import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/components/internet_exception_widgit.dart';
import 'package:flutter_bloc_pattern/config/routes/routes_name.dart';
import 'package:flutter_bloc_pattern/services/splash/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    splashService.isLogin(context);
    super.initState();
  }

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
