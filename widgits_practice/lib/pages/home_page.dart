// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgits_practice/models/catalog.dart';
import 'package:widgits_practice/widgits/drawer.dart';
import 'package:widgits_practice/widgits/item_widgit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodeData = jsonDecode(catalogJson);
    var productData = decodeData["products"];
   // print(productData);
    CatalogModels.items = List.from(productData)
        .map<ItemModel>((item) => ItemModel.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Catalog App',
        ),
      ),
      body: (CatalogModels.items != null && CatalogModels.items.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: CatalogModels.items.length,
                itemBuilder: (context, index) {
                  return ItemWidgit(
                    itemModel: CatalogModels.items[index],
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      drawer: AppDrawer(),
    );
  }
}
