import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

class BookMarkProvider extends ChangeNotifier {
  List<Expense> bookmarkedList = [];
  var box = Hive.box<String>(StorageKeys.boxName);

  void checkBookmark(List<Expense> allList) {
    bookmarkedList.clear();
    for (var element in allList) {
      if (element.bookmarked) {
        bookmarkedList.add(element);
      }
    }
  }
}
