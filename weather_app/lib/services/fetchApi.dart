import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/model.dart';

class ApiService{
  Future<List<WeatherModel>> fetchData(String city) async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q='+city+'&appid=b2bcafb95a1516e9a4fc3d7b6314af23'));
    if(response.statusCode == 200){
      return WeatherModel.fromJsonList([jsonDecode(response.body)]);
    }else{
      throw Exception('Failed to load Users');
    }
  }
}