import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_bookmark.dart';
import 'package:expense_ledger/provider/provider_screen_date_details.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/provider/provider_screen_expense_details.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile(
      {super.key, required this.expense, required this.dateInclude});
  final Expense expense;
  final bool dateInclude;
  @override
  Widget build(BuildContext context) {
    List<String> popupMenuItems = ['Bookmark', 'Edit', 'Delete'];
    return InkWell(
      onTap: () {
        Provider.of<ExpenseDetailsProvider>(context, listen: false)
            .setSelectedExpense(expense);
        Navigator.of(context).pushNamed(RouteName.expenseDetails);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Category */
                  Text(
                    overflow: TextOverflow.ellipsis,
                    expense.category.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        color: MyColors.secondaryTxtColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  dateInclude
                      ? Text(
                          MyFormatters.dateFormatterMDY
                              .format(expense.dateTime),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14),
                        )
                      :
                      /* Note */
                      Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.history_edu_rounded,
                              color: MyColors.greyColor,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                textWidthBasis: TextWidthBasis.parent,
                                overflow: TextOverflow.ellipsis,
                                expense.note ?? '. . .',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 12,
                                        color: MyColors.secondaryTxtColor),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            /* Amount and More button */
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /* Amount */
                  Expanded(
                    child: Text(
                      (expense.category.type == 'expense' ? '-' : '+') +
                          (MyFormatters.numFormatter.format(expense.amount)),
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: expense.category.type == 'expense'
                              ? MyColors.redColor
                              : MyColors.greenColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // const SizedBox(width: 5),
                  // Visibility(
                  //     visible: expense.bookmarked,
                  //     child: const Icon(
                  //       Icons.bookmark_rounded,
                  //       color: MyColors.primaryColor,
                  //     ))
                  // /* More Button */
                  // PopupMenuButton(
                  //   color: MyColors.backgroundColor,
                  //   icon: const Icon(
                  //     Icons.more_vert_rounded,
                  //     color: MyColors.greyColor,
                  //   ),
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10)),
                  //   constraints: BoxConstraints(
                  //       maxWidth: MediaQuery.of(context).size.width / 3),
                  //   itemBuilder: ((context) => popupMenuItems
                  //       .map((e) => PopupMenuItem(
                  //           value: e,
                  //           child: Text(
                  //             e,
                  //             style: Theme.of(context).textTheme.bodyLarge,
                  //           )))
                  //       .toList()),
                  //   onSelected: ((value) {
                  //     var expenseProvider =
                  //         Provider.of<ExpenseProvider>(context, listen: false);
                  //     var dateDetailsProvider =
                  //         Provider.of<DateDetailsProvider>(context,
                  //             listen: false);

                  //     switch (value) {
                  //       case 'Bookmark':
                  //         expenseProvider.toggleBookmark(context, expense);
                  //         dateDetailsProvider.toggleBookmark(context, expense);

                  //         break;
                  //       case 'Edit':
                  //         print(value);
                  //         break;
                  //       case 'Delete':
                  //         expenseProvider.deleteExpense(context, expense.id);
                  //         dateDetailsProvider
                  //             .deleteExpenseInExpenseList(expense.id);
                  //         break;
                  //       default:
                  //     }
                  //   }),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
