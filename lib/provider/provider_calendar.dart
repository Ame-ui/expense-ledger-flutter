import 'package:flutter/cupertino.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  void changeFocusedDay(DateTime newDate) {
    focusedDay = DateTime(newDate.year, newDate.month, newDate.day);
    notifyListeners();
  }
}
