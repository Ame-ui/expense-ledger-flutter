import 'dart:convert';

import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> allExpenseList = [];
  var box = Hive.box<String>(StorageKeys.boxName);
  void fetchAllExpense() async {
    /* fetch expense from database */

    String jsonStr = box.get(StorageKeys.expense) ?? '';
    print('json erroe ' + jsonStr.length.toString());
    allExpenseList = MyFormatters.expenseListFromJson(jsonStr);
    specifyExpense();
  }

  void storeExpenseToDb() async {
    // var sharePrefenence = await SharedPreferences.getInstance();
    // sharePrefenence.setString(
    //     StorageKeys.expense, MyFormatters.expenseListToJson(allExpenseList));
    box.put(
        StorageKeys.expense, MyFormatters.expenseListToJson(allExpenseList));
    print(MyFormatters.expenseListToJson(allExpenseList));
  }

  void addtoExpenseList(Expense newExpense) {
    allExpenseList.insert(0, newExpense);
    specifyExpense();
    notifyListeners();
    storeExpenseToDb();
  }

  void editExpense(String id, Expense expense) {
    allExpenseList[allExpenseList.indexOf(
        allExpenseList.where((element) => element.id == id).first)] = expense;
    specifyExpense();
    notifyListeners();
    storeExpenseToDb();
  }

  void deleteExpense(String id) {
    allExpenseList.removeWhere((element) => element.id == id);
    specifyExpense();
    notifyListeners();
    storeExpenseToDb();
  }

  Map<DateTime, List<Expense>> expenseListByAllDate = {};

  void specifyExpense() {
    expenseListByAllDate.clear();
    for (var element in allExpenseList) {
      if (expenseListByAllDate.containsKey(element.dateTime)) {
        var temp = expenseListByAllDate[element.dateTime] as List<Expense>;
        temp.add(element);
        expenseListByAllDate[element.dateTime] = temp;
      } else {
        expenseListByAllDate[element.dateTime] = [element];
      }
    }
    expenseListByAllDate = Map.fromEntries(expenseListByAllDate.entries.toList()
      ..sort(
        (a, b) => b.key.compareTo(a.key),
      ));
  }
}
