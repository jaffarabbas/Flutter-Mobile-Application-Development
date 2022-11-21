import 'package:flutter/widgets.dart';

class SoundPlayer extends ChangeNotifier{
  int a = 0;
 
  void set() async {
    // a = num;
    print("sadasdasd");
    notifyListeners();
  }

   SoundPlayer(){
    set();
  }
}