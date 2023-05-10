import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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

  bool isAmountEmpty = false;
  void checkAmount() {
    if (amount.isEmpty || int.parse(amount) == 0) {
      isAmountEmpty = true;
      notifyListeners();
    } else {
      isAmountEmpty = false;
    }
  }

  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  void setSelectedDate(DateTime newDate) {
    selectedDate = newDate;
    notifyListeners();
  }

  void resetValues(BuildContext context) {
    isCustomKeyboardOpen = false;
    isNoteOpen = false;
    amount = '';
    var categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    for (var element in categoryProvider.categoryList) {
      element.isSelected = false;
    }
    setSelectedDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));

    isAmountEmpty = false;
    notifyListeners();
  }
}
