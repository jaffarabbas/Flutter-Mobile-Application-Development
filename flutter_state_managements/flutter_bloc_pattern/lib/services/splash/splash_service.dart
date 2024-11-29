import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/config/routes/routes_name.dart';

class SplashService {
  void isLogin(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.loginScreen, (route) => false));
  }
}
