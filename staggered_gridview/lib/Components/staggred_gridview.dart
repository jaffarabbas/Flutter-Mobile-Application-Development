import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_gridview/widgets/grid_container.dart';

class StaggeredGridView extends StatefulWidget {
  StaggeredGridView({Key? key}) : super(key: key);

  @override
  State<StaggeredGridView> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView> {
  @override
  var twoCount = 1;
  var threeCount = 0;
  Widget build(BuildContext context) {
    int indexIncreatement() {
      int result = 0;
      if (twoCount != 2) {
        result = 2;
        setState(() {
          twoCount++;
        });
      } else if (threeCount != 2) {
        result = 3;
        setState(() {
          threeCount++;
        });
        if (threeCount == 2 && twoCount == 2) {
          setState(() {
            twoCount = 0;
            threeCount = 0;
          });
        }
      }
      return result;
    }

    List<Widget> stg = [];

    // int size = stg.indexOf(element);

    stg = [
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.amber, text: "1"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.red, text: "2"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.blueAccent, text: "3"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.pinkAccent, text: "4"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.pinkAccent, text: "4"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.amber, text: "1"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.red, text: "2"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.blueAccent, text: "3"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.pinkAccent, text: "4"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.blueAccent, text: "3"),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: indexIncreatement(),
        child: GridContainer(color: Colors.pinkAccent, text: "4"),
      ),
    ];

    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 20,
      crossAxisSpacing: 30,
      children: stg,
    );
  }
}
