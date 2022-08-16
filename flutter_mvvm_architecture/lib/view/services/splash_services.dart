import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_architecture/model/user_model.dart';
import 'package:flutter_mvvm_architecture/utils/routes/routes_names.dart';
import 'package:flutter_mvvm_architecture/utils/utils.dart';

import '../../view model/user_view_model.dart';

class SplashServices{
  Future<UserModel> getUserData() => UserViewModel().getUser();
  
  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      if(value.token == null || value.token == ''){
        await Future.delayed(Duration(seconds:3));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(Duration(seconds:3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error);
        Utils.flushBarErrorMessage(error.toString(), context);
      }
    });
  }
}