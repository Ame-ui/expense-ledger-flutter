import 'dart:convert';

import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categoryList = [
    Category(name: 'Cash', type: 'Income'),
    Category(name: 'Salary', type: 'Income'),
    Category(name: 'Comission', type: 'Income'),
    Category(name: 'Breakfast', type: 'Expense'),
    Category(name: 'Lunch', type: 'Expense'),
    Category(name: 'Dinner', type: 'Expense'),
    Category(name: 'Transportation', type: 'Expense'),
    Category(name: 'Medication', type: 'Expense'),
    Category(name: 'Repair', type: 'Expense')
  ];
  var box = Hive.box<String>(StorageKeys.boxName);
  void fetchCategoryList() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String jsonStr = sharedPreferences.getString(StorageKeys.category) ?? '';

    String jsonStr = box.get(StorageKeys.category) ?? '';
    if (jsonStr.isNotEmpty) {
      categoryList = MyFormatters.categoryListFromJson(jsonStr);
    }
  }

  void storeInDb() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString(
    //     StorageKeys.category, MyFormatters.categoryListToJson(categoryList));
    box.put(
        StorageKeys.category, MyFormatters.categoryListToJson(categoryList));
  }

  void addToCategoryList(Category newCategory) {
    categoryList.insert(0, newCategory);
    notifyListeners();
    storeInDb();
  }

  void editCategoryList(Category newCategory, Category oldCategory) {
    categoryList.insert(categoryList.indexOf(oldCategory), newCategory);
    categoryList.remove(oldCategory);
    notifyListeners();
    storeInDb();
  }

  void removeFromCategoryList(Category category) {
    categoryList.remove(category);
    notifyListeners();
    storeInDb();
  }

  // following methods are for create expense screen
  int setInitSelectedValue() {
    if (categoryList.isNotEmpty) {
      categoryList.forEach((element) {
        element.isSelected = false;
      });
      int selectedIndex = categoryList.indexOf(categoryList.firstWhere(
          (element) => element.type == 'Income' || element.type == 'Expense'));
      categoryList[selectedIndex].isSelected = true;
      return selectedIndex;
    } else {
      return 0;
    }
  }

  void swapSelectedCategory(int oldIndex, int newIndex) {
    categoryList[oldIndex].isSelected = false;
    categoryList[newIndex].isSelected = true;
    notifyListeners();
  }
}
