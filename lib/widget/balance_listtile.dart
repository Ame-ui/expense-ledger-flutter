import 'package:expense_ledger/model/model_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceListTile extends StatelessWidget {
  BalanceListTile(
      {super.key, required this.dateTime, required this.expenseList});
  /* required data */
  final DateTime dateTime;
  final List<Expense> expenseList;

  /* required to calculate */
  int totalIncome = 0;
  int totalExpense = 0;
  int totalBalance = 0;
  int otherIncome = 0;
  int otherExpense = 0;
  DateFormat dateFormatter = DateFormat('MMM d, y');
  NumberFormat numFormatter = NumberFormat('#,##0');

  @override
  Widget build(BuildContext context) {
    /* Calculate totalIncome, totalExpense, and TotalOther */
    for (int i = 0; i < expenseList.length; i++) {
      if (expenseList[i].type == 'income') {
        totalIncome += expenseList[i].amount;
        /* if item count >3 then amount of rest expense will also add to totalOther */
        if (i > 2) {
          otherIncome += expenseList[i].amount;
        }
      } else {
        totalExpense += expenseList[i].amount;
        /* if item count >3 then amount of rest expense will also add to totalOther */
        if (i > 2) {
          otherExpense += expenseList[i].amount;
        }
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
              /* date */
              Text(
                dateFormatter.format(dateTime),
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
                    color: MyColors.primaryColor.withOpacity(0.1)),
                child: Text(
                  '${numFormatter.format(totalBalance)} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const Divider(),
          /* list of category and amount */
          SizedBox(
            height: expenseList.length > 3 ? 90 : expenseList.length * 30,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: expenseList.length > 3 ? 3 : expenseList.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /* Category */
                        Text(
                          expenseList[index].category,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        /* Amount */
                        Text(
                          (expenseList[index].type == 'expense' ? '-' : '+') +
                              ('${numFormatter.format(expenseList[index].amount)} MMK'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: expenseList[index].type == 'expense'
                                      ? MyColors.redColor
                                      : MyColors.greenColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                })),
          ),
          Visibility(
              visible: expenseList.length > 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '(${expenseList.length - 3}) Other',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          '${otherIncome.isNegative ? '-' : '+'}${numFormatter.format(otherIncome)} MMK',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: MyColors.greenColor,
                                  // totalOther.isNegative
                                  //     ? MyColors.redColor
                                  //     : MyColors.greenColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' / ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${otherExpense.isNegative ? '-' : '+'}${numFormatter.format(otherExpense)} MMK',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: MyColors.redColor,
                                  // totalOther.isNegative
                                  //     ? MyColors.redColor
                                  //     : MyColors.greenColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          const Divider(),
          /* Total Income amount */
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.greenColor.withOpacity(0.1)),
                child: Text(
                  '+${numFormatter.format(totalIncome)} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.greenColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 10),
              /* Total Expense amount */
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.redColor.withOpacity(0.1)),
                child: Text(
                  '-${numFormatter.format(totalExpense)} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.redColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
