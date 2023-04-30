import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/provider/provider_calendar.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:expense_ledger/provider/provider_create_expense.dart';
import 'package:expense_ledger/provider/provider_home.dart';
import 'package:expense_ledger/route/routes.dart';
import 'package:expense_ledger/theme/custom_theme.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<HomeProvider>(create: ((context) => HomeProvider())),
    ChangeNotifierProvider<CreateExpenseProvider>(
        create: ((context) => CreateExpenseProvider())),
    ChangeNotifierProvider<ExpenseProvider>(
        create: ((context) => ExpenseProvider())),
    ChangeNotifierProvider<CalendarProvider>(
        create: ((context) => CalendarProvider())),
    ChangeNotifierProvider<CategoryProvider>(
        create: ((context) => CategoryProvider()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ExpenseProvider>(context, listen: false).fetchAllExpense();
    Provider.of<ExpenseProvider>(context, listen: false).specifyExpense();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategoryList();
    print('rebuild');
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      initialRoute: RouteName.getInitialRoute(),
      onGenerateRoute: Routes.generate,
      debugShowCheckedModeBanner: false,
    );
  }
}
