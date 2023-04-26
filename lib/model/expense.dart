import 'package:expense_ledger/model/category.dart';

class Expense {
  Expense({
    required this.amount,
    required this.category,
    required this.dateTime,
    this.note,
  });

  int amount;
  Category category;
  DateTime dateTime;
  String? note;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        amount: json["amount"],
        category: Category.fromJson(json["category"]),
        dateTime: DateTime.parse(json["dateTime"]),
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "category": category.toJson(),
        "dateTime": dateTime.toIso8601String(),
        "note": note,
      };
}
