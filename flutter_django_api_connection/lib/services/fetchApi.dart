import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_django_api_connection/models/Students.dart';
import 'package:flutter_django_api_connection/utils/contant_link.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Students>> fetchData() async {
    final response = await http
        .get(Uri.parse(Links.get));
    if (response.statusCode == 200) {
      return Students.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Student');
    }
  }

  Future<void> postStudent(String name, int roll, String city) async {
    final response = await http.post(
      Uri.parse(Links.post),
      body: jsonEncode(
          <String, dynamic>{'name': name, 'roll': roll, 'city': city}),
    );
  }
}
