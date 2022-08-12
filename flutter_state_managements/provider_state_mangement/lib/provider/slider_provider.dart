import 'package:flutter/foundation.dart';

class SliderProvider with ChangeNotifier {
  double _value = 0.1;
  double get value => _value;

  void setValue(double val) {
    _value = val;
    notifyListeners();
  }
}