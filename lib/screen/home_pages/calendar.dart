import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_balance.dart';
import 'package:expense_ledger/provider/provider_calendar.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/widget/balance_listtile.dart';
import 'package:expense_ledger/widget/calendar_balance_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    var balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Consumer<CalendarProvider>(builder: (context, provider, child) {
          return Scaffold(
            body: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TableCalendar(
                  focusedDay: provider.focusedDay,
                  firstDay: DateTime(2000),
                  lastDay: DateTime.now(),
                  headerStyle: HeaderStyle(
                    titleTextStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold) as TextStyle,
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  daysOfWeekHeight: 30,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600) as TextStyle,
                      weekdayStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600) as TextStyle),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                        color: MyColors.primaryColor, shape: BoxShape.circle),
                    defaultTextStyle:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                            ) as TextStyle,
                    isTodayHighlighted: false,
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    provider.changeFocusedDay(selectedDay);
                  },
                  selectedDayPredicate: (day) {
                    return provider.focusedDay ==
                        DateTime(day.year, day.month, day.day);
                  },
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                  child: CalandarCard(
                      dateTime: provider.focusedDay,
                      expenseList: balanceProvider
                              .expenseListByDate[provider.focusedDay] ??
                          []))
            ]),
          );
        }),
      ),
    );
  }
}
