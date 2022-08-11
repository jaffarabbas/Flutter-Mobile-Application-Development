import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rest_api_integration/Models/ProductModel.dart';
import 'package:flutter_rest_api_integration/Models/UserModel.dart';
import 'package:flutter_rest_api_integration/Services/Api/apiHandler.dart';
import 'package:flutter_rest_api_integration/components/productContainer.dart';
import 'package:flutter_rest_api_integration/components/userContainer.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // List<ProductModel> _products = [];

  Future<ProductModel> getProducts() async {
    // var data = await ApiHandler.fetchApi(
    //     '');
    final response = await http.get(
        Uri.parse('https://webhook.site/29731d2e-b8dd-41d2-88a5-4cc7ae5f012f'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    }
    return ProductModel.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductModel>(
              future: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: ListView.builder(
                              itemCount: snapshot.data!.data![index].products![index].images!.length,
                              itemBuilder: (context, postion) {
                                print(snapshot.data!.data![index].products![index].images![postion].url.toString());
                                return Container(
                                  height:MediaQuery.of(context).size.height * 0.25,
                                  width:MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        snapshot.data!.data![index].products![index].images![postion].url.toString()
                                      ),
                                    ),
                                  ),
                                  child: Text(snapshot.data!.data![index].products![index].images![postion].url.toString()),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
