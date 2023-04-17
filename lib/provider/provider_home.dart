import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  int homePagesIndex = 0;

  void changeIndex(int newValue) {
    homePagesIndex = newValue;
    notifyListeners();
  }
}
