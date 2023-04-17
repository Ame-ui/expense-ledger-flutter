import 'package:expense_ledger/model/model_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/widget/balance_listtile.dart';
import 'package:flutter/material.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(35, 113, 229, 1),
      child: SafeArea(
        child: Container(
          color: MyColors.backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              /* Balance card */
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: MyColors.primaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* Date and type */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* Date */
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: MyColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Sep 20, 2023',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                /* Type */
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: MyColors.secondaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Monthly',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            /* Balance */
                            Text(
                              'Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              '10,000 MMK',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                            ),

                            //for empty space
                            const SizedBox(height: 50)
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),

                  /* income and expense */
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /* Income */
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Text(
                                  'Income',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: MyColors.greenColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '+ 10,000 MMK',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: MyColors.greenColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Count: 2',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: MyColors.greenColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          /* Espense */
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                    spreadRadius: 2,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Text(
                                  'Expense',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: MyColors.redColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '+ 10,000 MMK',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: MyColors.redColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Count: 2',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: MyColors.redColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 0,
                      itemBuilder: ((context, index) {
                        return BalanceListTile(
                            dateTime: DateTime.now(),
                            expenseList: [
                              Expense(
                                  type: 'expense',
                                  amount: 10000,
                                  category: 'Transport',
                                  dateTime: DateTime.now()),
                              Expense(
                                  type: 'income',
                                  amount: 10000,
                                  category: 'Cash',
                                  dateTime: DateTime.now()),
                              Expense(
                                  type: 'expense',
                                  amount: 10000,
                                  category: 'Food',
                                  dateTime: DateTime.now()),
                              Expense(
                                  type: 'expense',
                                  amount: 0000,
                                  category: 'Food',
                                  dateTime: DateTime.now())
                            ]);
                      })))
            ],
          ),
        ),
      ),
    );
  }
}