import 'dart:convert';

import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categoryList = [];

  void fetchCategoryList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String jsonStr = sharedPreferences.getString(StorageKeys.category) ?? '';
    if (jsonStr.isEmpty) {
      print('Json error');
    } else {
      categoryList = MyFormatters.categoryListFromJson(jsonStr);
    }
  }

  void storeInSharePrefenerce() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        StorageKeys.category, MyFormatters.categoryListToJson(categoryList));
  }

  void addToCategoryList(Category newCategory) {
    categoryList.insert(0, newCategory);
    notifyListeners();
    storeInSharePrefenerce();
  }

  void editCategoryList(Category newCategory, Category oldCategory) {
    categoryList.insert(categoryList.indexOf(oldCategory), newCategory);
    categoryList.remove(oldCategory);
    notifyListeners();
    storeInSharePrefenerce();
  }

  void removeFromCategoryList(Category category) {
    categoryList.remove(category);
    notifyListeners();
    storeInSharePrefenerce();
  }

  int setInitSelectedValue() {
    if (categoryList.isNotEmpty) {
      int selectedIndex = categoryList.indexOf(
          categoryList.firstWhere((element) => element.type == 'income'));
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