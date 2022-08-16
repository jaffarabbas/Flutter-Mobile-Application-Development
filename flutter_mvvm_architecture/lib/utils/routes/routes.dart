import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routes_names.dart';
import 'package:flutter_mvvm_architecture/view/login_view.dart';
import 'package:flutter_mvvm_architecture/view/splash_view.dart';

import '../../view/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments; 
    switch (routeSettings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginView());
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashView());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text("No route defined for ${routeSettings.name}"),
              ),
            );
          },
        );
    }
  }
}
