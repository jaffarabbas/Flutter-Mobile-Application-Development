import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_gridview/widgets/grid_container.dart';

class QuiledGridView extends StatelessWidget {
  QuiledGridView({Key? key}) : super(key: key);
  List color = [
    Colors.accents,
    Colors.red,
    Colors.deepOrangeAccent,
    Colors.pink,
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      shrinkWrap: true,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 8,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        repeatPattern: QuiltedGridRepeatPattern.same,
        pattern: [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return Text('34');
        }
      ),
    );
  }
}
