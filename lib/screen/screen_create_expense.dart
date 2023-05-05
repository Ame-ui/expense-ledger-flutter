import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/model/expense.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:expense_ledger/provider/provider_screen_create_expense.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/formatters.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:expense_ledger/widget/category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateExpenseScreen extends StatefulWidget {
  const CreateExpenseScreen({super.key});

  @override
  State<CreateExpenseScreen> createState() => _CreateExpenseScreenState();
}

class _CreateExpenseScreenState extends State<CreateExpenseScreen> {
  final TextEditingController _noteTextController = TextEditingController();
  int previousCategoryIndex = 0;
  Category selectedCategory = Category(name: '', type: '');

  @override
  void dispose() {
    _noteTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // select fist income category
    previousCategoryIndex =
        Provider.of<CategoryProvider>(context, listen: false)
            .setInitSelectedValue();
    if (Provider.of<CategoryProvider>(context, listen: false)
        .categoryList
        .isNotEmpty) {
      selectedCategory = Provider.of<CategoryProvider>(context, listen: false)
          .categoryList[previousCategoryIndex];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var createExpenseProvider =
        Provider.of<CreateExpenseProvider>(context, listen: false);
    var expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (createExpenseProvider.isCustomKeyboardOpen) {
          createExpenseProvider.changeKeyboardState(false);
          return false;
        } else {
          createExpenseProvider.resetValues(context);
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
                  onPressed: () {
                    //new expense to add
                    var uuid = const Uuid();
                    Expense newExpense = Expense(
                        id: uuid.v1(),
                        amount: int.parse(createExpenseProvider.amount),
                        category: selectedCategory,
                        dateTime: createExpenseProvider.selectedDate,
                        note: _noteTextController.text);
                    //adding new expense
                    expenseProvider.addtoExpenseList(context, newExpense);
                    Navigator.of(context).pop();
                    //reset all value
                    previousCategoryIndex = 0;
                    selectedCategory = Category(name: '', type: '');

                    createExpenseProvider.resetValues(context);
                  },
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
                                      const Divider(height: 0),
                                      /* Category List */
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 250,
                                        child: Consumer<CategoryProvider>(
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
                                                    provider.swapSelectedCategory(
                                                        previousCategoryIndex,
                                                        index);
                                                    selectedCategory = provider
                                                        .categoryList[index];
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
                                                    provider.swapSelectedCategory(
                                                        previousCategoryIndex,
                                                        index);
                                                    selectedCategory = provider
                                                        .categoryList[index];
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
                                      Navigator.of(context)
                                          .pushNamed(RouteName.category);
                                    },
                                    child: const Text('Category Setting')),
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
                            onTap: () {
                              selectDate();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Selector<CreateExpenseProvider, DateTime>(
                                      selector: ((p0, p1) => p1.selectedDate),
                                      builder: (context, date, child) {
                                        return Text(
                                          MyFormatters.dateFormatterMDY
                                              .format(date),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                        );
                                      }),
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

  void selectDate() async {
    var createExpenseProvider =
        Provider.of<CreateExpenseProvider>(context, listen: false);
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: createExpenseProvider.selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
    createExpenseProvider.setSelectedDate(
        DateTime(selectedDate!.year, selectedDate.month, selectedDate.day));
  }
}
