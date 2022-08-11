import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rest_api_integration/Models/ProductModel.dart';
import 'package:flutter_rest_api_integration/Models/UserModel.dart';

class ProductCard extends StatelessWidget {
  Data product;
  ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF626365),
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 3.0,
              spreadRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: product.products!.length,
          itemBuilder: (context, index) {
            return Container(
              child: Image.network(
                product.products![index].images![index].url.toString(),
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
