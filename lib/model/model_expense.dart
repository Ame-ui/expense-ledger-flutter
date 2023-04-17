class Expense {
  String type;
  int amount;
  String category;
  DateTime dateTime;
  String? note;

  Expense(
      {required this.type,
      required this.amount,
      required this.category,
      required this.dateTime});
}
