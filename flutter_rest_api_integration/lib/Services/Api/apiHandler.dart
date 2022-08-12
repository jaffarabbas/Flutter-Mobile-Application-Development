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

  static Future<Map> fetchRegister(String url, String email, String password) async {
    final response =
        await http.post(Uri.parse(url), body: {
      'email': email,
      'password': password,
    });
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return data;
    }
    return data;
  }

}