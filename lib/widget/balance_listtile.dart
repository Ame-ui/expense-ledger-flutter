import 'package:expense_ledger/model/model_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceListTile extends StatelessWidget {
  BalanceListTile(
      {super.key, required this.dateTime, required this.expenseList});
  /* required to show */
  final DateTime dateTime;
  final List<Expense> expenseList;

  /* required to calculate */
  int totalIncome = 0;
  int totalExpense = 0;
  int totalBalance = 0;
  DateFormat formatter = DateFormat('MMM d, y');
  bool isNegative = false;
  @override
  Widget build(BuildContext context) {
    for (var expense in expenseList) {
      if (expense.type == 'income') {
        totalIncome += expense.amount;
      } else {
        totalExpense += expense.amount;
      }
    }
    if (totalIncome < totalExpense) {
      isNegative = true;
    } else {
      isNegative = false;
    }
    totalBalance = totalIncome - totalExpense;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatter.format(dateTime),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.primaryColor.withOpacity(0.1)),
                child: Text(
                  isNegative
                      ? '-'
                      : '+'
                          ' {$totalBalance} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            height: 300,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expenseList[index].category,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        expenseList[index].type == 'expense'
                            ? '-'
                            : '+'
                                ' {$totalBalance} MMK',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: expenseList[index].type == 'expense'
                                ? MyColors.redColor
                                : MyColors.greenColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                })),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.greenColor.withOpacity(0.1)),
                child: Text(
                  '+ {$totalIncome} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.greenColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.redColor.withOpacity(0.1)),
                child: Text(
                  '- {$totalExpense} MMK',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: MyColors.redColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
