import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/widget/expense_listtile.dart';
import 'package:flutter/material.dart';

class CalandarDateCard extends StatelessWidget {
  const CalandarDateCard(
      {super.key, required this.dateTime, required this.expenseList});
  /* required data */
  final DateTime dateTime;
  final List<Expense> expenseList;

  /* required to calculate */

  @override
  Widget build(BuildContext context) {
    int totalIncome = 0;
    int totalExpense = 0;
    int totalBalance = 0;
    int incomeCount = 0;
    int expenseCount = 0;
    /* Calculate totalIncome, totalExpense, and TotalOther */
    for (int i = 0; i < expenseList.length; i++) {
      if (expenseList[i].category.type == 'Income') {
        totalIncome += expenseList[i].amount;
        incomeCount++;
      } else {
        totalExpense += expenseList[i].amount;
        expenseCount++;
      }
    }
    totalBalance = totalIncome - totalExpense;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          /* date and balancce */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* Date */
              Text(
                MyFormatters.dateFormatterMDY.format(dateTime),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              /* total balance */
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.primaryTxtColor.withOpacity(0.1)),
                child: Text(
                  '${MyFormatters.numFormatter.format(totalBalance)} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.primaryTxtColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: MyColors.greenColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Count: $incomeCount',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: MyColors.redColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Count: $expenseCount',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
          const Divider(),
          /* list expense */
          Expanded(
            child: expenseList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'There is no income or expense in this day',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Press + to add',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: expenseList.length,
                    itemBuilder: ((context, index) {
                      return ExpenseListTile(
                        expense: expenseList[index],
                        dateInclude: false,
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
