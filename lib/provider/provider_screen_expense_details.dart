import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/provider/provider_page_balance.dart';
import 'package:expense_ledger/provider/provider_screen_date_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ExpenseDetailsProvider extends ChangeNotifier {
  Expense selectedExpense = Expense(
      id: '',
      amount: 0,
      category: Category(name: '', type: ''),
      dateTime: DateTime.now(),
      bookmarked: false);

  void setSelectedExpense(Expense expense) {
    selectedExpense = expense;
  }

  void toggleBookmarked(BuildContext context) {
    //for details screen
    selectedExpense.bookmarked = !selectedExpense.bookmarked;
    //for db
    Provider.of<ExpenseProvider>(context, listen: false)
        .toggleBookmark(context, selectedExpense);

    notifyListeners();
  }

  void deleteExpense(BuildContext context) {
    //for date details
    var dateDetailsProvider =
        Provider.of<DateDetailsProvider>(context, listen: false);
    dateDetailsProvider.deleteExpenseInExpenseList(selectedExpense.id);
    dateDetailsProvider.notifyListeners();
    //for db
    Provider.of<ExpenseProvider>(context, listen: false)
        .deleteExpense(context, selectedExpense.id);
    //for balance page
    var balanceProvider =
        Provider.of<BalancePageProvider>(context, listen: false);
    balanceProvider.checkListByView();
    balanceProvider.notifyListeners();
    Navigator.pop(context);
  }
}
