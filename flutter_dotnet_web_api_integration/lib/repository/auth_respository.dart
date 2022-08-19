import 'package:flutter_dotnet_web_api_integration/data/network/BaseApiServices.dart';
import 'package:flutter_dotnet_web_api_integration/data/network/NetworkApiServices.dart';
import 'package:flutter_dotnet_web_api_integration/res/appUrls.dart';

class AuthRepository{
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getPostApiResponce(AppUrl.login, data);
      return response;
    }catch(error){
      throw error;
    }
  }

  
  Future<dynamic> registerApi(dynamic data) async {
    try{
      dynamic response = await _apiServices.getPostApiResponce(AppUrl.register, data);
      return response;
    }catch(error){
        print("asdsadasdasdsd$error");
      throw error;
    }
  }
}