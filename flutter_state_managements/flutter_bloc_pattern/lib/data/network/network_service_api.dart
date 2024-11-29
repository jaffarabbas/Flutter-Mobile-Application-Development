import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_pattern/data/exceptions/app_exceptions.dart';
import 'package:flutter_bloc_pattern/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkServiceApi implements BaseApiService {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 50));
      jsonResponse = returnResponce(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out Try again');
    }
  }

  @override
  Future<dynamic> postApi(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 50));
      jsonResponse = returnResponce(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out Try again');
    }
    return jsonResponse;
  }

  dynamic returnResponce(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
        throw UnAuthorizedException();
      case 500:
        throw FetchDataException(
            "Error in connection " + response.statusCode.toString());
      default:
        throw UnAuthorizedException();
    }
  }
}
