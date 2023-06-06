import 'dart:convert';

import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_bookmark.dart';
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
    if (jsonStr.isNotEmpty) {
      allExpenseList = MyFormatters.expenseListFromJson(jsonStr);
    }
    Provider.of<BalancePageProvider>(context, listen: false)
        .specifyExpense(allExpenseList);
  }

  void addtoExpenseList(BuildContext context, Expense newExpense) {
    allExpenseList.add(newExpense);

    checkAndStoreToDb(context);
  }

  void editExpense(BuildContext context, String id, Expense expense) {
    allExpenseList[allExpenseList.indexOf(
        allExpenseList.firstWhere((element) => element.id == id))] = expense;

    checkAndStoreToDb(context);
  }

  void deleteExpense(BuildContext context, String id) {
    allExpenseList.removeWhere((element) => element.id == id);
    checkAndStoreToDb(context);
  }

  void toggleBookmark(BuildContext context, Expense expense) {
    allExpenseList
        .singleWhere((element) => element.id == expense.id)
        .bookmarked = expense.bookmarked;

    checkAndStoreToDb(context);
    //to update bookmark screen
    Provider.of<BookMarkProvider>(context, listen: false).notifyListeners();
  }

  void checkAndStoreToDb(BuildContext context) async {
    var balanceProvider =
        Provider.of<BalancePageProvider>(context, listen: false);
    balanceProvider.specifyExpense(allExpenseList);
    balanceProvider.checkListByView();
    balanceProvider.notifyListeners();
    Provider.of<BookMarkProvider>(context, listen: false)
        .checkBookmark(allExpenseList);

    box.put(
        StorageKeys.expense, MyFormatters.expenseListToJson(allExpenseList));
  }
}
