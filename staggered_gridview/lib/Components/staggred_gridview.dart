import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_gridview/widgets/grid_container.dart';

class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 4,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GridContainer(color: Colors.amber, text: "1"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: GridContainer(color: Colors.red, text: "2"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: GridContainer(color: Colors.blueAccent, text: "3"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GridContainer(color: Colors.pinkAccent, text: "4"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GridContainer(color: Colors.amber, text: "1"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: GridContainer(color: Colors.red, text: "2"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: GridContainer(color: Colors.blueAccent, text: "3"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GridContainer(color: Colors.pinkAccent, text: "4"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GridContainer(color: Colors.amber, text: "1"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: GridContainer(color: Colors.red, text: "2"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 3,
          child: GridContainer(color: Colors.blueAccent, text: "3"),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: GridContainer(color: Colors.pinkAccent, text: "4"),
        ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 2,
        //   mainAxisCellCount: 1,
        //   child: Tile(index: 1),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 1,
        //   mainAxisCellCount: 1,
        //   child: Tile(index: 2),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 1,
        //   mainAxisCellCount: 1,
        //   child: Tile(index: 3),
        // ),
        // StaggeredGridTile.count(
        //   crossAxisCellCount: 4,
        //   mainAxisCellCount: 2,
        //   child: Tile(index: 4),
        // ),
      ],
    );
  }
}
