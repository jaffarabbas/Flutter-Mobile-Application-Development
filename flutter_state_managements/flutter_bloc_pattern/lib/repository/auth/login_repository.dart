import 'package:flutter_bloc_pattern/config/app_url.dart';
import 'package:flutter_bloc_pattern/data/network/base_api_service.dart';
import 'package:flutter_bloc_pattern/data/network/network_service_api.dart';
import 'package:flutter_bloc_pattern/models/user/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> loginApi(dynamic data);
}
