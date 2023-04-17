import 'package:expense_ledger/provider/provider_create_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({super.key});

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    var createExpenseProvider =
        Provider.of<CreateExpenseProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        if (createExpenseProvider.isCustomKeyboardOpen) {
          createExpenseProvider.changeKeyboardState(false);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            /* if it is create=>New or edit=>Edit */
            title: Text(
              'New',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            /* Save button */
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Save",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /* expense info input */
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /* Category */
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    children: [
                                      /* Expense Tabbar */
                                      TabBar(
                                        indicatorWeight: 2,
                                        indicatorColor: MyColors.primaryColor,
                                        unselectedLabelColor:
                                            MyColors.greyColor,
                                        labelColor: MyColors.primaryColor,
                                        unselectedLabelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                        tabs: const [
                                          Tab(
                                            text: 'Income',
                                          ),
                                          Tab(
                                            text: 'Expense',
                                          ),
                                        ],
                                      ),
                                      /* Category List */
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 250,
                                        child: TabBarView(children: [
                                          /* Income Category List */
                                          ListView.builder(
                                              itemBuilder: ((context, index) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      color: index == 1
                                                          ? MyColors
                                                              .primaryColor
                                                              .withOpacity(0.2)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    'ahaha $index',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 16),
                                                  ),
                                                );
                                              }),
                                              itemCount: 5),
                                          /* Expense Category List */
                                          ListView.builder(
                                              itemBuilder: ((context, index) {
                                                return Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      color: index == 3
                                                          ? MyColors
                                                              .primaryColor
                                                              .withOpacity(0.2)
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text(
                                                    'ahaha $index',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            fontSize: 16),
                                                  ),
                                                );
                                              }),
                                              itemCount: 5),
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(height: 0),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('Add New Category')),
                                const SizedBox(height: 5)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          /* Amount */
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      createExpenseProvider
                                          .changeKeyboardState(true);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: MyColors.textFieldColor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '100,00',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          Text(
                                            'MMK',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 15,
                                                ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  // TextField(
                                  //   decoration: InputDecoration(
                                  //       fillColor: MyColors.textFieldColor,
                                  //       filled: true,
                                  //       border: InputBorder.none),
                                  // )
                                ],
                              )),
                          const SizedBox(height: 10),
                          /* Date */
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Feb 20, 2023',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: MyColors.secondaryTxtColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

                /* Custom Keyboard */
                Consumer<CreateExpenseProvider>(
                    builder: ((context, provider, child) {
                  return Visibility(
                    visible: provider.isCustomKeyboardOpen,
                    child: Container(
                      color: Colors.white,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 12,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 4.5 / 2,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: ((context, index) {
                            /* Backspace */
                            if (index == 9) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.1),
                                        border: const Border.symmetric(
                                          vertical: BorderSide(
                                              color: MyColors.greyColor,
                                              width: 0.5),
                                          horizontal: BorderSide(
                                              color: MyColors.greyColor,
                                              width: 0.5),
                                        )),
                                    child: const Center(
                                        child: Icon(
                                      Icons.backspace,
                                      color: MyColors.primaryColor,
                                    ))),
                              );
                            }
                            /* Number Zero */
                            if (index == 10) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border.symmetric(
                                          vertical: BorderSide(
                                              color: MyColors.greyColor,
                                              width: 0.5),
                                          horizontal: BorderSide(
                                              color: MyColors.greyColor,
                                              width: 0.5),
                                        )),
                                    child: Center(
                                        child: Text(
                                      '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 26),
                                    ))),
                              );
                            }
                            /* Done */
                            if (index == 11) {
                              return InkWell(
                                onTap: () {
                                  provider.changeKeyboardState(false);
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.1),
                                        border: const Border.symmetric(
                                          vertical: BorderSide(
                                              color: MyColors.greyColor,
                                              width: 0.5),
                                          horizontal: BorderSide(
                                              color: MyColors.greyColor,
                                              width: 0.5),
                                        )),
                                    child: const Center(
                                        child: Icon(
                                      Icons.done,
                                      size: 30,
                                      color: MyColors.primaryColor,
                                    ))),
                              );
                            }
                            /* Normal Number (1-9)*/
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      border: Border.symmetric(
                                        vertical: BorderSide(
                                            color: MyColors.greyColor,
                                            width: 0.5),
                                        horizontal: BorderSide(
                                            color: MyColors.greyColor,
                                            width: 0.5),
                                      )),
                                  child: Center(
                                      child: Text(
                                    (index + 1).toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 26),
                                  ))),
                            );
                          })),
                    ),
                  );
                }))
              ],
            ),
          )),
    );
  }
}
