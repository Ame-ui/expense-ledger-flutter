import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_screen_date_details.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/provider/provider_page_balance.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:expense_ledger/value/storage_keys.dart';
import 'package:expense_ledger/widget/date_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> viewByList = ['Daily', 'Weekly', 'Monthly', 'Yearly', 'All'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: MyColors.primaryColor,
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.light)),
      ),
      body: Container(
        color: MyColors.backgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
            Consumer<BalancePageProvider>(builder: (context, provider, child) {
          return Column(
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
                                Container(
                                  // padding: const EdgeInsets.symmetric(
                                  //     horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: MyColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: provider.viewBy == 'All'
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Text(
                                            'All Expense',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                provider.setDate(false);
                                              },
                                              icon: const Icon(
                                                Icons
                                                    .keyboard_arrow_left_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                            provider.viewBy == 'Weekly'
                                                ? Row(
                                                    children: [
                                                      Text(
                                                        MyFormatters
                                                            .dateFormatterMD
                                                            .format(provider
                                                                .weekStartDate),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      Text(
                                                        ' - ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      Text(
                                                        MyFormatters
                                                            .dateFormatterMD
                                                            .format(provider
                                                                .weekEndDate),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ],
                                                  )
                                                : Text(
                                                    provider.viewBy == 'Daily'
                                                        ? MyFormatters
                                                            .dateFormatterMDY
                                                            .format(provider
                                                                .selectedDatetTime)
                                                        : provider.viewBy ==
                                                                'Monthly'
                                                            ? MyFormatters
                                                                .dateFormatterMY
                                                                .format(provider
                                                                    .selectedDatetTime)
                                                            : MyFormatters
                                                                .dateFormatterY
                                                                .format(provider
                                                                    .selectedDatetTime),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                            IconButton(
                                              onPressed: () {
                                                provider.setDate(true);
                                              },
                                              icon: const Icon(
                                                Icons
                                                    .keyboard_arrow_right_rounded,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                                /* Type */

                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 15),
                                  decoration: BoxDecoration(
                                    color: MyColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                        ),
                                        items: viewByList
                                            .map((e) => DropdownMenuItem(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ))
                                            .toList(),
                                        value: provider.viewBy,
                                        dropdownColor: MyColors.secondaryColor,
                                        onChanged: ((value) {
                                          provider.setViewBy(value.toString());
                                        })),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            /* Balance */
                            Text(
                              'Balance',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 14),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                '${MyFormatters.numFormatter.format(provider.totalBalance)} MMK',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                              ),
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
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 10),
                          /* Income */
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Theme.of(context).colorScheme.shadow,
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
                                        ),
                                  ),
                                  Text(
                                    '+${MyFormatters.numFormatter.format(provider.totalIncome)} MMK',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: MyColors.greenColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Count ${provider.incomeCount}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: MyColors.greenColor,
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          /* Espense */
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Theme.of(context).colorScheme.shadow,
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
                                        ),
                                  ),
                                  Text(
                                    '-${MyFormatters.numFormatter.format(provider.totalExpense)} MMK',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: MyColors.redColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Count ${provider.expenseCount}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: MyColors.redColor,
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              /* list of expense with date */
              Expanded(
                  child: provider.expenseListForUi.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/empty_expense.png',
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                              ),
                              Text(
                                'Empty List',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'There is no record of income or expense',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Press + to add',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 30)
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10, right: 10),
                          child: ListView.builder(
                              itemCount: provider.expenseListForUi.length,
                              itemBuilder: ((context, index) {
                                return provider.expenseListForUi.values
                                        .elementAt(index)
                                        .isEmpty
                                    ? const SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          Provider.of<DateDetailsProvider>(
                                                  context,
                                                  listen: false)
                                              .setSelectedDateDetails(provider
                                                  .expenseListForUi.entries
                                                  .elementAt(index));
                                          Navigator.of(context)
                                              .pushNamed(RouteName.dateDetails);
                                        },
                                        child: DateListTile(
                                            dateTime: provider
                                                .expenseListForUi.keys
                                                .elementAt(index),
                                            expenseList: provider
                                                .expenseListForUi.values
                                                .elementAt(index)),
                                      );
                              })),
                        )),
            ],
          );
        }),
      ),
    );
  }
}
