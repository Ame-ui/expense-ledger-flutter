import 'package:expense_ledger/screen/screen_catrgory.dart';
import 'package:expense_ledger/screen/screen_create_expense.dart';
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
          builder: (context) => const CreateExpenseScreen(),
        );
      case RouteName.category:
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorRoute(),
        );
    }
  }
}
