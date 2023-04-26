import 'dart:convert';
import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:intl/intl.dart';

class MyFormatters {
  static DateFormat dateFormatter = DateFormat('MMM d, y');
  static NumberFormat numFormatter = NumberFormat('#,##0');
  //expense list json formatter
  static List<Expense> expenseListFromJson(String str) =>
      List<Expense>.from(json.decode(str).map((x) => Expense.fromJson(x)));
  static String expenseListToJson(List<Expense> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  //category list json formatter
  List<Category> categoryListFromJson(String str) =>
      List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));
  String categoryListToJson(List<Category> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
