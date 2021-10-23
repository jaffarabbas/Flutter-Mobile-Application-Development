// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:widgits_practice/models/catalog.dart';

class ItemWidgit extends StatelessWidget {
  final ItemModel itemModel;
  
  ItemWidgit({ Key? key, required this.itemModel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("${itemModel.name} pressed");
        },
        leading: Image.network(itemModel.imageUrl),
        title: Text(itemModel.name),
        subtitle: Text(itemModel.description),
        trailing: Text(
          "\$${itemModel.price}",
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}