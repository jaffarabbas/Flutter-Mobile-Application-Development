import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler{

  static Future<List> fetchApi(String url) async {
    final response =
        await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return data;
    }
    return data;
  }

}