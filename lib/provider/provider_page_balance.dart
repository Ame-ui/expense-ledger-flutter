import 'package:expense_ledger/model/expense.dart';
import 'package:flutter/cupertino.dart';

class BalancePageProvider extends ChangeNotifier {
  Map<DateTime, List<Expense>> expenseListByAllDate = {};
  String viewBy = 'All';
  DateTime selectedDatetTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime weekStartDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime weekEndDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  Map<DateTime, List<Expense>> expenseListForUi = {};
  double totalBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  int incomeCount = 0;
  int expenseCount = 0;
  void checkListByView() {
    switch (viewBy) {
      case 'Daily':
        expenseListForUi.clear();
        for (var element in expenseListByAllDate.keys) {
          if (element.month == selectedDatetTime.month &&
              element.year == selectedDatetTime.year &&
              element.day == selectedDatetTime.day) {
            expenseListForUi[element] = expenseListByAllDate[element] ?? [];
          }
        }
        break;
      case 'Weekly':
        expenseListForUi.clear();
        for (var element in expenseListByAllDate.keys) {
          if ((element.isAfter(weekStartDate) ||
                  element.isAtSameMomentAs(weekStartDate)) &&
              (element.isBefore(weekEndDate) ||
                  element.isAtSameMomentAs(weekEndDate))) {
            expenseListForUi[element] = expenseListByAllDate[element] ?? [];
          }
        }
        break;
      case 'Monthly':
        expenseListForUi.clear();
        for (var element in expenseListByAllDate.keys) {
          if (element.month == selectedDatetTime.month &&
              element.year == selectedDatetTime.year) {
            expenseListForUi[element] = expenseListByAllDate[element] ?? [];
          }
        }
        break;
      case 'Yearly':
        expenseListForUi.clear();
        for (var element in expenseListByAllDate.keys) {
          if (element.year == selectedDatetTime.year) {
            expenseListForUi[element] = expenseListByAllDate[element] ?? [];
          }
        }
        break;
      case 'All':
        expenseListByAllDate.forEach((key, value) {
          expenseListForUi[key] = value;
        });
        break;
    }
    //to delete if value in key are empty
    Map<DateTime, List<Expense>> removeList = {};
    expenseListForUi.forEach((key, value) {
      if (value.isEmpty) {
        removeList[key] = value;
      }
    });
    expenseListForUi.removeWhere((key, value) => removeList.containsKey(key));
    print(expenseListForUi);
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    incomeCount = 0;
    expenseCount = 0;
    expenseListForUi.forEach((key, value) {
      for (var element in value) {
        if (element.category.type == 'income') {
          totalIncome += element.amount;
          incomeCount++;
        } else {
          totalExpense += element.amount;
          expenseCount++;
        }
      }
    });
    totalBalance = totalIncome - totalExpense;
  }

  void setViewBy(String value) {
    viewBy = value;
    if (viewBy == 'Weekly') {
      weekStartDate = DateTime(selectedDatetTime.year, selectedDatetTime.month,
          selectedDatetTime.day - (selectedDatetTime.weekday - 1));

      weekEndDate = DateTime(selectedDatetTime.year, selectedDatetTime.month,
          selectedDatetTime.day - (selectedDatetTime.weekday - 7));
    }
    checkListByView();
    notifyListeners();
  }

  void setDate(bool increase) {
    var tempDate = selectedDatetTime;
    switch (viewBy) {
      case 'Daily':
        if (increase) {
          selectedDatetTime =
              DateTime(tempDate.year, tempDate.month, tempDate.day + 1);
        } else {
          selectedDatetTime =
              DateTime(tempDate.year, tempDate.month, tempDate.day - 1);
        }
        break;
      case 'Weekly':
        if (increase) {
          weekStartDate = DateTime(
              weekStartDate.year, weekStartDate.month, weekStartDate.day + 7);

          weekEndDate = DateTime(
              weekEndDate.year, weekEndDate.month, weekEndDate.day + 7);
        } else {
          weekStartDate = DateTime(
              weekStartDate.year, weekStartDate.month, weekStartDate.day - 7);

          weekEndDate = DateTime(
              weekEndDate.year, weekEndDate.month, weekEndDate.day - 7);
        }
        break;
      case 'Monthly':
        if (increase) {
          selectedDatetTime =
              DateTime(tempDate.year, tempDate.month + 1, tempDate.day);
        } else {
          selectedDatetTime =
              DateTime(tempDate.year, tempDate.month - 1, tempDate.day);
        }
        break;
      case 'Yearly':
        if (increase) {
          selectedDatetTime =
              DateTime(tempDate.year + 1, tempDate.month, tempDate.day);
        } else {
          selectedDatetTime =
              DateTime(tempDate.year - 1, tempDate.month, tempDate.day);
        }
        break;

      default:
    }
    checkListByView();
    notifyListeners();
  }

  void specifyExpense(List<Expense> expenseList) {
    expenseListByAllDate.clear();
    for (var element in expenseList) {
      if (expenseListByAllDate.containsKey(element.dateTime)) {
        var temp = expenseListByAllDate[element.dateTime] as List<Expense>;
        temp.add(element);
        expenseListByAllDate[element.dateTime] = temp;
      } else {
        expenseListByAllDate[element.dateTime] = [element];
      }
    }
    if (expenseListByAllDate.isNotEmpty) {
      expenseListByAllDate =
          Map.fromEntries(expenseListByAllDate.entries.toList()
            ..sort(
              (a, b) => b.key.compareTo(a.key),
            ));
    }
  }
}
