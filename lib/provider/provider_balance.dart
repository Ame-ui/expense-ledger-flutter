import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:flutter/material.dart';

class BalanceProvider extends ChangeNotifier {
  List<Expense> allExpenseList = [
    Expense(
        amount: 10000,
        category: Category(name: 'Transport', type: 'expense'),
        note: 'Total lost man',
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)),
    Expense(
        amount: 100000,
        category: Category(name: 'Salary', type: 'income'),
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)),
    //
    Expense(
        amount: 10000,
        category: Category(name: 'Transport', type: 'expense'),
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    Expense(
        amount: 20000,
        category: Category(name: 'Transport', type: 'expense'),
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    Expense(
        amount: 1000,
        category: Category(name: 'Transport', type: 'income'),
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    Expense(
        amount: 2000,
        category: Category(name: 'Transport', type: 'expense'),
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
    Expense(
        amount: 1000,
        category: Category(name: 'Transport', type: 'expense'),
        dateTime: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
  ];
  final Map<DateTime, List<Expense>> expenseListByDate = {};

  void fetchAllExpense() {
    /* fetch expense from database */
  }

  void specifyExpense() {
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
  }
}
