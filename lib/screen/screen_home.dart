import 'package:expense_ledger/provider/provider_home.dart';
import 'package:expense_ledger/screen/home_pages/balance.dart';
import 'package:expense_ledger/screen/home_pages/calendar.dart';
import 'package:expense_ledger/screen/home_pages/setting.dart';
import 'package:expense_ledger/screen/home_pages/statistics.dart';
import 'package:expense_ledger/value/my_icons.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: ((context, provider, child) {
      return Scaffold(
        body: provider.homePagesIndex == 0
            ? const BalancePage()
            : provider.homePagesIndex == 1
                ? const CalendarPage()
                : provider.homePagesIndex == 2
                    ? const StatisticsPage()
                    : const SettingPage(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteName.createExpense);
            },
            child: const Icon(
              Icons.add_rounded,
              size: 30,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.homePagesIndex,
            onTap: (value) {
              provider.changeIndex(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(provider.homePagesIndex == 0
                      ? MyIcons.balance_avtive
                      : MyIcons.balance_inactive),
                  label: 'Balance'),
              BottomNavigationBarItem(
                  icon: Icon(provider.homePagesIndex == 1
                      ? MyIcons.calendar_active
                      : MyIcons.calendar_inactive),
                  label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(provider.homePagesIndex == 2
                      ? MyIcons.statistics_active
                      : MyIcons.statistics_inactive),
                  label: 'Statistics'),
              BottomNavigationBarItem(
                  icon: Icon(provider.homePagesIndex == 3
                      ? MyIcons.setting_active
                      : MyIcons.setting_inactive),
                  label: 'Setting'),
            ]),
      );
    }));
  }
}
