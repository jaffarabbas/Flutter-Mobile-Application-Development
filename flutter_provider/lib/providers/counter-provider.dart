import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier{
  List<int> numbers = [1,2,3];

  void add(){
    numbers.add(numbers.last+1);
    notifyListeners();
  }
}