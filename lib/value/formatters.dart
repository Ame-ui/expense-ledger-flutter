import 'dart:convert';
import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:intl/intl.dart';

class MyFormatters {
  static DateFormat dateFormatterMDY = DateFormat('MMM d, y');
  static DateFormat dateFormatterMY = DateFormat('MMM y');
  static DateFormat dateFormatterMD = DateFormat('MMM d');
  static DateFormat dateFormatterY = DateFormat('y');
  static DateFormat dateFormatterWeek = DateFormat('EEEE');
  static NumberFormat numFormatter = NumberFormat('#,##0');

  //expense list json formatter
  static List<Expense> expenseListFromJson(String str) =>
      List<Expense>.from(json.decode(str).map((x) => Expense.fromJson(x)));
  static String expenseListToJson(List<Expense> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  //category list json formatter
  static List<Category> categoryListFromJson(String str) =>
      List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));
  static String categoryListToJson(List<Category> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
