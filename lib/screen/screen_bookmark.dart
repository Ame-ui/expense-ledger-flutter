import 'package:expense_ledger/provider/provider_bookmark.dart';
import 'package:expense_ledger/widget/expense_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        title: Text(
          'Bookmarks',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: Colors.white,
            child:
                Consumer<BookMarkProvider>(builder: (context, provider, child) {
              return ListView.separated(
                  itemCount: provider.bookmarkedList.length,
                  separatorBuilder: ((context, index) => const Divider()),
                  itemBuilder: ((context, index) {
                    return ExpenseListTile(
                      expense: provider.bookmarkedList[index],
                      dateInclude: true,
                    );
                  }));
            }),
          ))
        ],
      ),
    );
  }
}
