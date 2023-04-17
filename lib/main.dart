import 'package:expense_ledger/provider/provider_create_expense.dart';
import 'package:expense_ledger/provider/provider_home.dart';
import 'package:expense_ledger/route/routes.dart';
import 'package:expense_ledger/theme/custom_theme.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
            create: ((context) => HomeProvider())),
        ChangeNotifierProvider<CreateExpenseProvider>(
            create: ((context) => CreateExpenseProvider()))
      ],
      child: MaterialApp(
        theme: CustomTheme.lightTheme,
        initialRoute: RouteName.getInitialRoute(),
        onGenerateRoute: Routes.generate,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
