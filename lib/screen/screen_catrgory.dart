import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/widget/category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Category',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          bottom: TabBar(
              indicatorWeight: 2,
              indicatorColor: MyColors.primaryColor,
              unselectedLabelColor: MyColors.greyColor,
              labelColor: MyColors.primaryColor,
              unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Income'),
                Tab(text: 'Expense'),
              ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
                  context: context,
                  builder: (context) =>
                      CategoryDialog(category: Category(name: '', type: '')),
                ),
            child: const Icon(Icons.add_rounded)),
        body: Consumer<CategoryProvider>(builder: (context, provider, child) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(children: [
                  /* Income Catetory List */
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: ListView.separated(
                      separatorBuilder: ((context, index) =>
                          provider.categoryList[index].type == 'expense'
                              ? const SizedBox.shrink()
                              : const Divider(
                                  height: 0,
                                )),
                      itemCount: provider.categoryList.length,
                      itemBuilder: ((context, index) {
                        if (provider.categoryList[index].type == 'expense') {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                provider.categoryList[index].name,
                                textAlign: TextAlign.start,
                              )),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: ((context) => CategoryDialog(
                                              category: provider
                                                  .categoryList[index])));
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: MyColors.greyColor,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      provider.removeFromCategoryList(
                                          provider.categoryList[index]);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: MyColors.greyColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  /* Expense Category list */
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: ListView.separated(
                      separatorBuilder: ((context, index) =>
                          provider.categoryList[index].type == 'income'
                              ? const SizedBox.shrink()
                              : const Divider(
                                  height: 0,
                                )),
                      itemCount: provider.categoryList.length,
                      itemBuilder: ((context, index) {
                        if (provider.categoryList[index].type == 'income') {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                provider.categoryList[index].name,
                                textAlign: TextAlign.start,
                              )),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: ((context) => CategoryDialog(
                                              category: provider
                                                  .categoryList[index])));
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: MyColors.greyColor,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      provider.removeFromCategoryList(
                                          provider.categoryList[index]);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: MyColors.greyColor,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
