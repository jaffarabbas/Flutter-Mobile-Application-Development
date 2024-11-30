import 'package:flutter_bloc_pattern/models/user/user_model.dart';
import 'package:flutter_bloc_pattern/repository/auth/login_repository.dart';

class LoginMockApiRepository implements LoginRepository {
  @override
  Future<UserModel> loginApi(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));
    final response = {'token': 'asdasdasd'};
    return UserModel.fromJson(response);
  }
}
