import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jz_instagram_app/responsive/mobile_screen_layout.dart';
import 'package:jz_instagram_app/responsive/responsive_layout_screen.dart';
import 'package:jz_instagram_app/responsive/web_screen_layout.dart';
import 'package:jz_instagram_app/screens/login_screen.dart';
import 'package:jz_instagram_app/screens/signup_screen.dart';
import 'package:jz_instagram_app/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD9jOcUZ_kGnqcZbY8HrHArJm_0lvq6ohA',
        appId: '1:643737933616:web:50d5ee3ed1a3c7ef13daf5',
        messagingSenderId: '643737933616',
        projectId: 'jz-instagram-app',
        storageBucket: 'jz-instagram-app.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram app',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   WebScreenLayout: WebScreenLayout(),
      //   MobileScreenLayout: MobileScreenLayout(),
      // ),
      home: SignUpScreen(),
    );
  }
}
