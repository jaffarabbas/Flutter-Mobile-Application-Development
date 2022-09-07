import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotnet_web_api_integration/utils/routes/routes_names.dart';
import 'package:flutter_dotnet_web_api_integration/utils/utils.dart';
import 'package:flutter_dotnet_web_api_integration/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../repository/auth_respository.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _authLoading = false;
  bool get authLoading => _authLoading;

  void setLoader(bool value) {
    _authLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoader(true);
    _authRepo.loginApi(data).then((value) {
      print("value: $value");
      setLoader(false);
      final userPrefrences = Provider.of<UserViewModel>(context, listen: false);
      userPrefrences.saveUser(UserModel(token: value.toString()));
      Utils.snackBarGenerater('Successfully Logged In', context);
      Navigator.pushNamed(context, RoutesName.home);  
      if (kDebugMode) {}
    }).onError((error, stackTrace) {
      setLoader(false);
      if (kDebugMode) {
        print(error);
      }
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setLoader(true);
    _authRepo.registerApi(data).then((value) {
      setLoader(false);
      if (kDebugMode) {
        Utils.snackBarGenerater('Succsessfully Registered', context);
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
      }
    });
  }
}
