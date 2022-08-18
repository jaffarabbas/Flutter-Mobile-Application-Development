import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm_architecture/res/colors.dart';
import 'package:flutter_mvvm_architecture/view/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices _splashServices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("asd");
    _splashServices.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.architecture_rounded,
              size: 100,
              color: Colors.white,
            ),
            Text('MVVM', style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
