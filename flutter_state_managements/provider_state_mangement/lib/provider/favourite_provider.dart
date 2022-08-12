import 'package:flutter/foundation.dart';

class FavouriteProvider with ChangeNotifier{
  List<int> _seletItem = [];
  List<int> get seletItem => _seletItem;

  void setSelectItem(int index){
    _seletItem.add(index);
    notifyListeners();
  }

  void removeSelectItem(int index){
    _seletItem.remove(index);
    notifyListeners();
  }
}