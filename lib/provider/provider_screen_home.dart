import 'package:expense_ledger/model/expense.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  int homePagesIndex = 0;

  void changeIndex(int newValue) {
    homePagesIndex = newValue;
    notifyListeners();
  }
}
