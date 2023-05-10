import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_screen_date_details.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/widget/expense_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DateDetailsScreen extends StatelessWidget {
  const DateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateDetailsProvider>(builder: (context, provider, child) {
      double totalBalance = 0;
      double totalIncome = 0;
      double totalExpense = 0;
      int incomeCount = 0;
      int expenseCount = 0;
      /* Calculate totalIncome, totalExpense, and TotalOther */
      for (int i = 0; i < provider.selectedDateDetails.value.length; i++) {
        if (provider.selectedDateDetails.value[i].category.type == 'income') {
          totalIncome += provider.selectedDateDetails.value[i].amount;
          incomeCount++;
        } else {
          totalExpense += provider.selectedDateDetails.value[i].amount;
          expenseCount++;
        }
      }
      totalBalance = totalIncome - totalExpense;
      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
          title: Text(
              MyFormatters.dateFormatterMDY
                  .format(provider.selectedDateDetails.key),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Balance',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14),
                  ),
                  Text(
                    '${MyFormatters.numFormatter.format(totalBalance)} MMK',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  /* Total Income and Expense */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* Total Income */
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.greenColor.withOpacity(0.1)),
                          child: Column(
                            children: [
                              Text(
                                '+${MyFormatters.numFormatter.format(totalIncome)} MMK',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: MyColors.greenColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Count: $incomeCount',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: MyColors.greenColor,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      /* Total Expense amount */
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.redColor.withOpacity(0.1)),
                          child: Column(
                            children: [
                              Text(
                                '-${MyFormatters.numFormatter.format(totalExpense)} MMK',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: MyColors.redColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Count: $expenseCount',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: MyColors.redColor,
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /* Expense List */
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: provider.selectedDateDetails.value.length,
                  itemBuilder: ((context, index) {
                    return ExpenseListTile(
                      expense: provider.selectedDateDetails.value[index],
                      dateInclude: false,
                    );
                  })),
            )),
          ],
        ),
      );
    });
  }
}
