import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_date_details.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({super.key, required this.expense});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    List<String> popupMenuItems = ['Bookmark', 'Edit', 'Delete'];
    return Padding(
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
                Text(
                  overflow: TextOverflow.ellipsis,
                  expense.category.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: MyColors.secondaryTxtColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 12, color: MyColors.secondaryTxtColor),
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
                /* More Button */
                PopupMenuButton(
                  color: MyColors.backgroundColor,
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: MyColors.greyColor,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 3),
                  itemBuilder: ((context) => popupMenuItems
                      .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )))
                      .toList()),
                  onSelected: ((value) {
                    var expenseProvider =
                        Provider.of<ExpenseProvider>(context, listen: false);
                    var dateDetailsProvider = Provider.of<DateDetailsProvider>(
                        context,
                        listen: false);
                    switch (value) {
                      case 'Bookmark':
                        print(value);
                        break;
                      case 'Edit':
                        print(value);
                        break;
                      case 'Delete':
                        expenseProvider.deleteExpense(expense.id);
                        dateDetailsProvider
                            .deleteExpenseInExpenseList(expense.id);
                        break;
                      default:
                    }
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
