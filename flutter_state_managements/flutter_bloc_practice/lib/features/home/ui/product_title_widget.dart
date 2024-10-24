import 'package:flutter/material.dart';
import 'package:flutter_bloc_practice/features/home/models/home_product_data_model.dart';

class ProductTitleWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductTitleWidget({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15), // Optional: for rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 8, // How soft the shadow looks
            offset: Offset(0, 0), // Changes position of shadow (x, y)
          ),
        ],
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag))
            ],
          ),
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(productDataModel.imageUrl))),
          ),
          Text(
            "${productDataModel.id} - ${productDataModel.name}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rs. ${productDataModel.price}",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                productDataModel.category,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(productDataModel.description),
          Text(productDataModel.inStock),
        ],
      ),
    );
  }
}
