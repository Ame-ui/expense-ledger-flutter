import 'package:expense_ledger/provider/provider_balance.dart';
import 'package:expense_ledger/provider/provider_calendar.dart';
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
    ChangeNotifierProvider<BalanceProvider>(
        create: ((context) => BalanceProvider())),
    ChangeNotifierProvider<CalendarProvider>(
        create: ((context) => CalendarProvider()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<BalanceProvider>(context, listen: false).specifyExpense();
    print('rebuild');
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      initialRoute: RouteName.getInitialRoute(),
      onGenerateRoute: Routes.generate,
      debugShowCheckedModeBanner: false,
    );
  }
}
