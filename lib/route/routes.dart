import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/screen/screen_bookmark.dart';
import 'package:expense_ledger/screen/screen_catrgory.dart';
import 'package:expense_ledger/screen/screen_create_expense.dart';
import 'package:expense_ledger/screen/screen_details_date.dart';
import 'package:expense_ledger/screen/screen_details_expense.dart';
import 'package:expense_ledger/screen/screen_home.dart';
import 'package:expense_ledger/screen/screen_splash.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:expense_ledger/widget/error_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteName.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case RouteName.createExpense:
        return MaterialPageRoute(
          builder: (context) => CreateExpenseScreen(
            isNew: settings.arguments as bool,
          ),
        );
      case RouteName.category:
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );
      case RouteName.dateDetails:
        return MaterialPageRoute(
          builder: (context) => const DateDetailsScreen(),
        );
      case RouteName.expenseDetails:
        return MaterialPageRoute(
          builder: (context) => const ExpenseDetailsScreen(),
        );
      case RouteName.bookmark:
        return MaterialPageRoute(
          builder: (context) => const BookmarkScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorRoute(),
        );
    }
  }
}
