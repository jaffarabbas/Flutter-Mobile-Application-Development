import 'package:flutter/material.dart';
import 'package:flutter_bloc_api_fetching/features/home/home_dart.dart';
import 'package:flutter_bloc_api_fetching/features/post/ui/post_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostPage(),
    );
  }
}
