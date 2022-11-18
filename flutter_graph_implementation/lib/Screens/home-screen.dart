import 'package:flutter/material.dart';
import 'package:flutter_graph_implementation/Screens/Graphs/LineChart.dart';
import 'package:flutter_graph_implementation/Screens/Graphs/LineChart2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            LineChartExample(),
            LineChart2()
          ],
        ),
      ),
    );
  }
}