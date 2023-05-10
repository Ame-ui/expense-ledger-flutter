import 'package:expense_ledger/model/category.dart';
import 'package:uuid/uuid.dart';

class Expense {
  Expense(
      {required this.id,
      required this.amount,
      required this.category,
      required this.dateTime,
      this.note,
      required this.bookmarked});
  String id;
  int amount;
  Category category;
  DateTime dateTime;
  String? note;
  bool bookmarked;

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
      id: json["id"],
      amount: json["amount"],
      category: Category.fromJson(json["category"]),
      dateTime: DateTime.parse(json["dateTime"]),
      note: json["note"],
      bookmarked: json["bookmarked"] ?? false);

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "category": category.toJson(),
        "dateTime": dateTime.toIso8601String(),
        "note": note,
        "bookmarked": bookmarked
      };
}
