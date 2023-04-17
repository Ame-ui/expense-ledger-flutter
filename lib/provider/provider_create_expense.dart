import 'package:flutter/cupertino.dart';

class CreateExpenseProvider extends ChangeNotifier {
  bool isCustomKeyboardOpen = false;

  void changeKeyboardState(bool newValue) {
    isCustomKeyboardOpen = newValue;
    notifyListeners();
  }
}
