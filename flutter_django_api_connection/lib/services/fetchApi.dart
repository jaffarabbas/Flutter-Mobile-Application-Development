import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_django_api_connection/models/Students.dart';
import 'package:flutter_django_api_connection/utils/contant_link.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Students>> fetchData() async {
    final response = await http
        .get(Uri.parse("https://jzstudentinfo.herokuapp.com/getstudent/"));
    if (response.statusCode == 200) {
      return Students.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Student');
    }
  }

  Future<bool> postStudent(String name, int roll, String city) async {
    final response = await http.post(
      Uri.parse('https://jzstudentinfo.herokuapp.com/poststudent/'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode(
          <String, dynamic>{'name': name, 'roll': roll, 'city': city}),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
