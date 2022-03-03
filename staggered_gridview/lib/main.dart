import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_gridview/Components/MasonaryGridView.dart';
import 'package:staggered_gridview/Components/Quiled.dart';
import 'package:staggered_gridview/Components/staggred_gridview.dart';
import 'package:staggered_gridview/widgets/grid_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: StaggeredGridView(),
          ),
        ),
      ),
    );
  }
}
