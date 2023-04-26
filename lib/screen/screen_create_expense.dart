import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/provider/provider_create_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/widget/category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({super.key});

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  final TextEditingController _noteTextController = TextEditingController();

  @override
  void dispose() {
    _noteTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var createExpenseProvider =
        Provider.of<CreateExpenseProvider>(context, listen: false);
    // select fist income category
    int previousCategoryIndex = createExpenseProvider.initCategoryList();
    return WillPopScope(
      onWillPop: () async {
        if (createExpenseProvider.isCustomKeyboardOpen) {
          createExpenseProvider.changeKeyboardState(false);
          return false;
        } else {
          createExpenseProvider.resetValues();
          return true;
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                                        child: Consumer<CreateExpenseProvider>(
                                            builder:
                                                (context, provider, child) {
                                          return TabBarView(children: [
                                            /* Income Category List */
                                            ListView.builder(
                                              itemCount:
                                                  provider.categoryList.length,
                                              itemBuilder: ((context, index) {
                                                if (provider.categoryList[index]
                                                        .type ==
                                                    'expense') {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                                return InkWell(
                                                  onTap: () {
                                                    createExpenseProvider
                                                        .swapSelectedCategory(
                                                            previousCategoryIndex,
                                                            index);
                                                    previousCategoryIndex =
                                                        index;
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                        color: provider
                                                                .categoryList[
                                                                    index]
                                                                .isSelected
                                                            ? MyColors
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.2)
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      provider
                                                          .categoryList[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 16),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                            /* Expense Category List */
                                            ListView.builder(
                                              itemCount:
                                                  provider.categoryList.length,
                                              itemBuilder: ((context, index) {
                                                if (provider.categoryList[index]
                                                        .type ==
                                                    'income') {
                                                  return const SizedBox
                                                      .shrink();
                                                }
                                                return InkWell(
                                                  onTap: () {
                                                    createExpenseProvider
                                                        .swapSelectedCategory(
                                                            previousCategoryIndex,
                                                            index);
                                                    previousCategoryIndex =
                                                        index;
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                        color: provider
                                                                .categoryList[
                                                                    index]
                                                                .isSelected
                                                            ? MyColors
                                                                .primaryColor
                                                                .withOpacity(
                                                                    0.2)
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      provider
                                                          .categoryList[index]
                                                          .name,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 16),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ]);
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(height: 0),
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CategoryDialog(
                                              category:
                                                  Category(name: '', type: ''),
                                            );
                                          });
                                    },
                                    child: const Text('Add')),
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
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 5),
                                InkWell(
                                  onTap: () {
                                    //dimiss the keyboard
                                    FocusScopeNode focusScopeNode =
                                        FocusScope.of(context);
                                    focusScopeNode.unfocus();
                                    //if note txtfield is empty change it into txtbutton again
                                    if (_noteTextController.text.isEmpty) {
                                      createExpenseProvider
                                          .changeNoteBool(false);
                                    }
                                    //delay to look better
                                    Future.delayed(
                                        const Duration(milliseconds: 200), (() {
                                      createExpenseProvider
                                          .changeKeyboardState(true);
                                    }));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MyColors.textFieldColor),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: Selector<CreateExpenseProvider,
                                                  String>(
                                              builder:
                                                  ((context, amount, child) {
                                                return Text(
                                                  amount,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                );
                                              }),
                                              selector: ((p0, p1) =>
                                                  p1.amount)),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text(
                                            'MMK',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                /* Add Note */
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.history_edu_rounded,
                                        color: MyColors.primaryColor,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Selector<CreateExpenseProvider,
                                                bool>(
                                            selector: ((p0, p1) =>
                                                p1.isNoteOpen),
                                            builder:
                                                (context, isNoteOpen, child) {
                                              return !isNoteOpen
                                                  ? Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: TextButton(
                                                          onPressed: () {
                                                            createExpenseProvider
                                                                .changeKeyboardState(
                                                                    false);
                                                            createExpenseProvider
                                                                .changeNoteBool(
                                                                    true);
                                                          },
                                                          child: const Text(
                                                              'Add Note (optional)')),
                                                    )
                                                  : TextFormField(
                                                      onTap: () {
                                                        createExpenseProvider
                                                            .changeKeyboardState(
                                                                false);
                                                      },
                                                      controller:
                                                          _noteTextController,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        fillColor: MyColors
                                                            .textFieldColor,
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    );
                                            }),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
                    // selector: ((p0, p1) => p1.isCustomKeyboardOpen),
                    builder: ((context, provider, child) {
                  return Visibility(
                    visible: provider.isCustomKeyboardOpen,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(
                            'Safe Input',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontSize: 14),
                          ),
                          GridView.builder(
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
                                    onTap: () {
                                      if (provider.amount.isNotEmpty) {
                                        provider.removeFromAmount();
                                      }
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                            color: MyColors.primaryColor
                                                .withOpacity(0.1),
                                            border: Border.all(
                                                color: MyColors.greyColor,
                                                width: 0.2)),
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
                                    onTap: () {
                                      provider.addToAmount('0');
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: MyColors.greyColor,
                                                width: 0.2)),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                            color: MyColors.primaryColor
                                                .withOpacity(0.1),
                                            border: Border.all(
                                                color: MyColors.greyColor,
                                                width: 0.2)),
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
                                  onTap: () {
                                    provider
                                        .addToAmount((index + 1).toString());
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: MyColors.greyColor,
                                              width: 0.2)),
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
                        ],
                      ),
                    ),
                  );
                }))
              ],
            ),
          )),
    );
  }
}
