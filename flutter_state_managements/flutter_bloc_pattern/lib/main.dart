import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/routes/routes.dart';
import 'package:flutter_bloc_pattern/config/routes/routes_name.dart';
import 'package:flutter_bloc_pattern/views/home/home_screen.dart';
import 'package:flutter_bloc_pattern/views/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.genrateRoutes,
    );
  }
}
