import 'package:expense_ledger/model/category.dart';
import 'package:flutter/cupertino.dart';

class CreateExpenseProvider extends ChangeNotifier {
  bool isCustomKeyboardOpen = false;
  void changeKeyboardState(bool newValue) {
    isCustomKeyboardOpen = newValue;
    notifyListeners();
  }

  bool isNoteOpen = false;
  void changeNoteBool(bool newValue) {
    isNoteOpen = newValue;
    notifyListeners();
  }

  String amount = '';
  void addToAmount(String newValue) {
    amount += newValue;
    notifyListeners();
  }

  void removeFromAmount() {
    amount = amount.substring(0, amount.length - 1);
    notifyListeners();
  }

  List<Category> categoryList = [
    Category(name: 'Transport', type: 'expense'),
    Category(name: 'Cash', type: 'income'),
    Category(name: 'Commision', type: 'income'),
    Category(name: 'Food', type: 'expense'),
    Category(name: 'Repair', type: 'expense'),
    Category(name: 'Hospital', type: 'expense'),
    Category(name: 'Salary', type: 'income'),
  ];
  int initCategoryList() {
    int selectedIndex = categoryList.indexOf(
        categoryList.firstWhere((element) => element.type == 'income'));
    categoryList[selectedIndex].isSelected = true;
    return selectedIndex;
  }

  void swapSelectedCategory(int oldIndex, int newIndex) {
    categoryList[oldIndex].isSelected = false;
    categoryList[newIndex].isSelected = true;
    notifyListeners();
  }

  void resetValues() {
    isCustomKeyboardOpen = false;
    isNoteOpen = false;
    amount = '';
    for (var element in categoryList) {
      element.isSelected = false;
    }
    notifyListeners();
  }
}
