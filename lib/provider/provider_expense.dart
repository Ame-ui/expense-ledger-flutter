import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> allExpenseList = [
    //   Expense(
    //       amount: 10000,
    //       category: Category(name: 'Transport', type: 'expense'),
    //       note: 'Total lost man',
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day)),
    //   Expense(
    //       amount: 100000,
    //       category: Category(name: 'Salary', type: 'income'),
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day)),
    //   //
    //   Expense(
    //       amount: 10000,
    //       category: Category(name: 'Transport', type: 'expense'),
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    //   Expense(
    //       amount: 20000,
    //       category: Category(name: 'Transport', type: 'expense'),
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    //   Expense(
    //       amount: 1000,
    //       category: Category(name: 'Transport', type: 'income'),
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    //   Expense(
    //       amount: 2000,
    //       category: Category(name: 'Transport', type: 'expense'),
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    //   Expense(
    //       amount: 1000,
    //       category: Category(name: 'Transport', type: 'expense'),
    //       dateTime: DateTime(
    //           DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
  ];
  void storeExpenseToSharedPrefenence() async {
    var sharePrefenence = await SharedPreferences.getInstance();
    sharePrefenence.setString(
        StorageKeys.expense, MyFormatters.expenseListToJson(allExpenseList));
    print('shared ' + MyFormatters.expenseListToJson(allExpenseList));
  }

  void addtoExpenseList(Expense newExpense) {
    allExpenseList.insert(0, newExpense);
    specifyExpense();
    notifyListeners();

    storeExpenseToSharedPrefenence();
  }

  Map<DateTime, List<Expense>> expenseListByDate = {};

  void fetchAllExpense() async {
    /* fetch expense from database */
    var sharePrefenence = await SharedPreferences.getInstance();
    var jsonStr = sharePrefenence.getString(StorageKeys.expense) ?? '';
    allExpenseList = MyFormatters.expenseListFromJson(jsonStr);
    notifyListeners();
  }

  void specifyExpense() {
    expenseListByDate.clear();
    for (var element in allExpenseList) {
      if (expenseListByDate.containsKey(element.dateTime)) {
        var temp = expenseListByDate[element.dateTime] as List<Expense>;
        temp.add(element);
        expenseListByDate[element.dateTime] = temp;
        // temp.clear();
      } else {
        expenseListByDate[element.dateTime] = [element];
      }
    }
    expenseListByDate = Map.fromEntries(expenseListByDate.entries.toList()
      ..sort(
        (a, b) => b.key.compareTo(a.key),
      ));
  }
}
