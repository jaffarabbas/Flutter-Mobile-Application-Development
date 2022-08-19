import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotnet_web_api_integration/utils/routes/routes_names.dart';
import 'package:flutter_dotnet_web_api_integration/utils/utils.dart';

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
      setLoader(false);
      if (kDebugMode) {
        Utils.snackBarGenerater(value, context);
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
      }
    });
  }
}
