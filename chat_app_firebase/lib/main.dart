// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_10/pages/home_page.dart';
import 'package:flutter_app_10/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Container(
              child: Text("Error"),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                print("Sign out");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                );
              } else {
                print("Sign in");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePage(user: user),
                  ),
                );
              }
            });
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
