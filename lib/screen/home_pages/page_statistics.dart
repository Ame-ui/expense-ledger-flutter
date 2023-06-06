import 'package:expense_ledger/provider/provider_page_balance.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> viewByList = ['Daily', 'Weekly', 'Monthly', 'Yearly', 'All'];
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(0, 0),
            child: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.dark),
            )),
        body: Center(
          child: Image.asset(
            'assets/images/coming_soon.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
          ),
        )
        // body: Consumer<BalancePageProvider>(builder: (context, provider, child) {
        //   return DefaultTabController(
        //     length: 2,
        //     child: Column(
        //       children: [
        //         Container(
        //           padding: const EdgeInsets.all(10),
        //           decoration: const BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.only(
        //                   bottomLeft: Radius.circular(10),
        //                   bottomRight: Radius.circular(10))),
        //           child: Column(
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   /* Date */
        //                   Container(
        //                     decoration: BoxDecoration(
        //                       color: MyColors.textFieldColor,
        //                       borderRadius: BorderRadius.circular(30),
        //                     ),
        //                     child: provider.viewBy == 'All'
        //                         ? Container(
        //                             margin: const EdgeInsets.symmetric(
        //                                 vertical: 10, horizontal: 20),
        //                             child: Text(
        //                               'All Expense',
        //                               style: Theme.of(context)
        //                                   .textTheme
        //                                   .bodyLarge
        //                                   ?.copyWith(
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                             ),
        //                           )
        //                         : Row(
        //                             children: [
        //                               IconButton(
        //                                 onPressed: () {
        //                                   provider.setDate(false);
        //                                 },
        //                                 icon: const Icon(
        //                                   Icons.keyboard_arrow_left_rounded,
        //                                   color: MyColors.secondaryTxtColor,
        //                                 ),
        //                               ),
        //                               provider.viewBy == 'Weekly'
        //                                   ? Row(
        //                                       children: [
        //                                         Text(
        //                                           MyFormatters.dateFormatterMD
        //                                               .format(
        //                                                   provider.weekStartDate),
        //                                           style: Theme.of(context)
        //                                               .textTheme
        //                                               .bodyLarge
        //                                               ?.copyWith(
        //                                                   fontSize: 16,
        //                                                   fontWeight:
        //                                                       FontWeight.w400),
        //                                         ),
        //                                         Text(
        //                                           ' - ',
        //                                           style: Theme.of(context)
        //                                               .textTheme
        //                                               .bodyLarge
        //                                               ?.copyWith(
        //                                                   fontSize: 16,
        //                                                   fontWeight:
        //                                                       FontWeight.w400),
        //                                         ),
        //                                         Text(
        //                                           MyFormatters.dateFormatterMD
        //                                               .format(
        //                                                   provider.weekEndDate),
        //                                           style: Theme.of(context)
        //                                               .textTheme
        //                                               .bodyLarge
        //                                               ?.copyWith(
        //                                                   fontSize: 16,
        //                                                   fontWeight:
        //                                                       FontWeight.w400),
        //                                         ),
        //                                       ],
        //                                     )
        //                                   : Text(
        //                                       provider.viewBy == 'Daily'
        //                                           ? MyFormatters.dateFormatterMDY
        //                                               .format(provider
        //                                                   .selectedDatetTime)
        //                                           : provider.viewBy == 'Monthly'
        //                                               ? MyFormatters
        //                                                   .dateFormatterMY
        //                                                   .format(provider
        //                                                       .selectedDatetTime)
        //                                               : MyFormatters
        //                                                   .dateFormatterY
        //                                                   .format(provider
        //                                                       .selectedDatetTime),
        //                                       style: Theme.of(context)
        //                                           .textTheme
        //                                           .bodyLarge
        //                                           ?.copyWith(
        //                                               fontSize: 16,
        //                                               fontWeight:
        //                                                   FontWeight.w400),
        //                                     ),
        //                               IconButton(
        //                                 onPressed: () {
        //                                   provider.setDate(true);
        //                                 },
        //                                 icon: const Icon(
        //                                   Icons.keyboard_arrow_right_rounded,
        //                                   color: MyColors.secondaryTxtColor,
        //                                 ),
        //                               )
        //                             ],
        //                           ),
        //                   ),
        //                   /* Type */

        //                   Container(
        //                     padding: const EdgeInsets.only(right: 10, left: 15),
        //                     decoration: BoxDecoration(
        //                       color: MyColors.textFieldColor,
        //                       borderRadius: BorderRadius.circular(25),
        //                     ),
        //                     child: DropdownButtonHideUnderline(
        //                       child: DropdownButton(
        //                           icon: const Icon(
        //                             Icons.keyboard_arrow_down_rounded,
        //                             color: MyColors.secondaryTxtColor,
        //                           ),
        //                           items: viewByList
        //                               .map((e) => DropdownMenuItem(
        //                                     value: e,
        //                                     child: Text(
        //                                       e,
        //                                       style: Theme.of(context)
        //                                           .textTheme
        //                                           .bodyLarge
        //                                           ?.copyWith(
        //                                               fontSize: 14,
        //                                               fontWeight:
        //                                                   FontWeight.w400),
        //                                     ),
        //                                   ))
        //                               .toList(),
        //                           value: provider.viewBy,
        //                           dropdownColor: MyColors.textFieldColor,
        //                           onChanged: ((value) {
        //                             provider.setViewBy(value.toString());
        //                           })),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //               const SizedBox(height: 20),
        //               /* Income Expense tabbar */
        //               TabBar(
        //                 indicatorWeight: 2,
        //                 indicatorColor: MyColors.primaryColor,
        //                 unselectedLabelColor: MyColors.greyColor,
        //                 labelColor: MyColors.primaryColor,
        //                 unselectedLabelStyle:
        //                     Theme.of(context).textTheme.bodySmall,
        //                 labelStyle: Theme.of(context)
        //                     .textTheme
        //                     .titleMedium
        //                     ?.copyWith(fontWeight: FontWeight.w600),
        //                 tabs: const [
        //                   Tab(
        //                     text: 'Income',
        //                   ),
        //                   Tab(
        //                     text: 'Expense',
        //                   ),
        //                 ],
        //               )
        //             ],
        //           ),
        //         ),
        //         Expanded(
        //             child: TabBarView(children: [
        //           Column(children: [
        //             SizedBox(
        //                 height: MediaQuery.of(context).size.height * 0.5,
        //                 child: SfCartesianChart()),
        //             const SizedBox(
        //               height: 10,
        //             ),
        //             // SfCircularChart()
        //           ]),
        //           Text('expense')
        //         ]))
        //       ],
        //     ),
        //   );
        // }),
        );
  }
}
