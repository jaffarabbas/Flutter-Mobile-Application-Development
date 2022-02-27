import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_gridview/widgets/grid_container.dart';

class MasonaryGridView extends StatelessWidget {
  const MasonaryGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 5,
      crossAxisSpacing: 6,
      itemCount: 10,
      itemBuilder: (context, index) {
        return GridContainer(color: Colors.amber, text: index.toString());
      },
    );
  }
}
