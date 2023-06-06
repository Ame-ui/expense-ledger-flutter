import 'package:expense_ledger/provider/provider_screen_expense_details.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDetailsProvider>(
        builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
          title: Text('Details',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          actions: [
            /* Bookmark  */
            IconButton(
                onPressed: () {
                  provider.toggleBookmarked(context);
                },
                icon: provider.selectedExpense.bookmarked == true
                    ? const Icon(
                        Icons.bookmark_rounded,
                        color: MyColors.primaryColor,
                      )
                    : const Icon(
                        Icons.bookmark_border_rounded,
                        color: MyColors.greyColor,
                      )),
            /* Edit */
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(RouteName.createExpense, arguments: false);
              },
              icon: const Icon(
                Icons.edit_rounded,
                color: MyColors.greyColor,
              ),
            ),
            /* Delete */
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          title: Text(
                            'Are you sure?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Do you want to delete this record?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                                onPressed: (() => Navigator.of(context).pop()),
                                child: const Text('Cancel')),
                            ElevatedButton(
                                onPressed: () {
                                  provider.deleteExpense(context);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Delete',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 16),
                                ))
                          ],
                        )));
              },
              icon: const Icon(Icons.delete_outline_rounded),
              color: MyColors.greyColor,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Date and type */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /* Date */
                  Text(
                      MyFormatters.dateFormatterMDY
                          .format(provider.selectedExpense.dateTime),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  /* Type */
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color:
                            provider.selectedExpense.category.type == 'Income'
                                ? MyColors.greenColor.withOpacity(0.1)
                                : MyColors.redColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(provider.selectedExpense.category.type,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: provider.selectedExpense.category.type ==
                                    'Income'
                                ? MyColors.greenColor
                                : MyColors.redColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Divider(
                height: 40,
              ),
              /* Amout */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          )),
                  Text(
                      '${provider.selectedExpense.category.type == 'Income' ? '+' : '-'}${MyFormatters.numFormatter.format(provider.selectedExpense.amount)} MMk',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color:
                              provider.selectedExpense.category.type == 'Income'
                                  ? MyColors.greenColor
                                  : MyColors.redColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              /* Category */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Category',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          )),
                  Text(provider.selectedExpense.category.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
              const Divider(
                height: 40,
              ),
              Text('Note',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                      )),
              const SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: MyColors.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(provider.selectedExpense.note ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                        )),
              )
            ],
          ),
        ),
      );
    });
  }
}
