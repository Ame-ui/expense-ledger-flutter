import 'package:expense_ledger/model/expense.dart';
import 'package:flutter/material.dart';

class DateDetailsProvider extends ChangeNotifier {
  late MapEntry<DateTime, List<Expense>> selectedDateDetails;

  void setSelectedDateDetails(MapEntry<DateTime, List<Expense>> mapEntry) {
    selectedDateDetails = mapEntry;
    notifyListeners();
  }

  void deleteExpenseInExpenseList(String id) {
    selectedDateDetails.value.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
