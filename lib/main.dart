import 'package:expense_ledger/provider/provider_bookmark.dart';
import 'package:expense_ledger/provider/provider_screen_date_details.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/provider/provider_page_calendar.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:expense_ledger/provider/provider_page_balance.dart';
import 'package:expense_ledger/provider/provider_screen_create_expense.dart';
import 'package:expense_ledger/provider/provider_screen_expense_details.dart';
import 'package:expense_ledger/provider/provider_screen_home.dart';
import 'package:expense_ledger/route/routes.dart';
import 'package:expense_ledger/theme/custom_theme.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>(StorageKeys.boxName);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<HomeProvider>(create: ((context) => HomeProvider())),
    ChangeNotifierProvider<CreateExpenseProvider>(
        create: ((context) => CreateExpenseProvider())),
    ChangeNotifierProvider<BalancePageProvider>(
        create: ((context) => BalancePageProvider())),
    ChangeNotifierProvider<ExpenseProvider>(
        create: ((context) => ExpenseProvider())),
    ChangeNotifierProvider<CalendarProvider>(
        create: ((context) => CalendarProvider())),
    ChangeNotifierProvider<CategoryProvider>(
        create: ((context) => CategoryProvider())),
    ChangeNotifierProvider<DateDetailsProvider>(
        create: ((context) => DateDetailsProvider())),
    ChangeNotifierProvider<ExpenseDetailsProvider>(
        create: ((context) => ExpenseDetailsProvider())),
    ChangeNotifierProvider<BookMarkProvider>(
        create: ((context) => BookMarkProvider())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ExpenseProvider>(context, listen: false)
        .fetchAllExpense(context);
    Provider.of<BalancePageProvider>(context, listen: false).checkListByView();
    Provider.of<CategoryProvider>(context, listen: false).fetchCategoryList();
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      initialRoute: RouteName.getInitialRoute(),
      onGenerateRoute: Routes.generate,
      debugShowCheckedModeBanner: false,
    );
  }
}
