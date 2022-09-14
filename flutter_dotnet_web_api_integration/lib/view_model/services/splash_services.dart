import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotnet_web_api_integration/model/user_model.dart';
import 'package:flutter_dotnet_web_api_integration/utils/routes/routes_names.dart';
import 'package:flutter_dotnet_web_api_integration/utils/utils.dart';
import 'package:flutter_dotnet_web_api_integration/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      // await UserViewModel().removeUser();
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
        Utils.flushBarErrorMessage(error.toString(), context);
      }
    });
  }
}
