import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_integration/Screens/home-screens.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDCorG2Pz9IfuLagKz1pHLjiblqD-60yyE",
          authDomain: "water-level-indicator-19529.firebaseapp.com",
          databaseURL:
              "https://water-level-indicator-19529-default-rtdb.firebaseio.com",
          projectId: "water-level-indicator-19529",
          storageBucket: "water-level-indicator-19529.appspot.com",
          messagingSenderId: "605971871935",
          appId: "1:605971871935:web:cdf506d31761b5e3fa2e0a"),
    );
  } else {
    await Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScrren(),
    );
  }
}
