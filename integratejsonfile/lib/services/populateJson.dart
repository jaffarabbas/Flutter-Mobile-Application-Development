import 'dart:convert';
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:integratejsonfile/model/Product.dart';

class PopulateJson {
  static Future<List<Product>> PopulateJsonData() async{
    String jsonPath = '../assets/data/products.json';
    String responce = await rootBundle.loadString(jsonPath);
    //populate json data from json file to product model class
    List<Product> data = Product.fromJsonList(await json.decode(responce));
    return data;
  }

}
