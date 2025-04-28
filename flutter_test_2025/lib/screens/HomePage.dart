import 'package:flutter/material.dart';
import 'package:flutter_test_2025/shared/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home Page',
        backgroundColor: Colors.blue,
        titleColor: Colors.white,
        showBackButton: false,
      ),
      body: Column(
        children: [
          Text('Test')
        ],
      ),
    );
  }
}