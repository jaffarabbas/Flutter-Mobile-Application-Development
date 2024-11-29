import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/routes/routes_name.dart';
import '../../views/views.dart';

class Routes {
  static Route<dynamic> genrateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route Found'),
            ),
          ),
        );
    }
  }
}
