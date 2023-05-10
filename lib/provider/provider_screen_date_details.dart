import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
