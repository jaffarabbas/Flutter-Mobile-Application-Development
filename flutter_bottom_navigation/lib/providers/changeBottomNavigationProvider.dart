import 'package:flutter/widgets.dart';

class ChnageBottomNavgationProvider with ChangeNotifier{
  var index = 0;
  void setIndex(int num){
    index = num;
    notifyListeners();
  }
}