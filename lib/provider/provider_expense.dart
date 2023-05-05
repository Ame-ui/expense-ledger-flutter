import 'dart:convert';

import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_page_balance.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

//this class may be work without changenotifier
class ExpenseProvider extends ChangeNotifier {
  List<Expense> allExpenseList = [];
  var box = Hive.box<String>(StorageKeys.boxName);
  void fetchAllExpense(
    BuildContext context,
  ) async {
    /* fetch expense from database */
    String jsonStr = box.get(StorageKeys.expense) ?? '';
    allExpenseList = MyFormatters.expenseListFromJson(jsonStr);
    Provider.of<BalancePageProvider>(context, listen: false)
        .specifyExpense(allExpenseList);
  }

  void storeExpenseToDb() async {
    box.put(
        StorageKeys.expense, MyFormatters.expenseListToJson(allExpenseList));
  }

  void addtoExpenseList(BuildContext context, Expense newExpense) {
    allExpenseList.insert(0, newExpense);
    var balanceProvider =
        Provider.of<BalancePageProvider>(context, listen: false);

    balanceProvider.specifyExpense(allExpenseList);
    balanceProvider.checkListByView();
    balanceProvider.notifyListeners();
    storeExpenseToDb();
  }

  void editExpense(BuildContext context, String id, Expense expense) {
    allExpenseList[allExpenseList.indexOf(
        allExpenseList.where((element) => element.id == id).first)] = expense;
    var balanceProvider =
        Provider.of<BalancePageProvider>(context, listen: false);
    balanceProvider.specifyExpense(allExpenseList);
    balanceProvider.notifyListeners();
    balanceProvider.checkListByView();
    storeExpenseToDb();
  }

  void deleteExpense(BuildContext context, String id) {
    allExpenseList.removeWhere((element) => element.id == id);
    var balanceProvider =
        Provider.of<BalancePageProvider>(context, listen: false);
    balanceProvider.specifyExpense(allExpenseList);
    balanceProvider.checkListByView();
    balanceProvider.notifyListeners();
    storeExpenseToDb();
  }
}
