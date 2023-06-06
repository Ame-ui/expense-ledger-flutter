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
              return provider.bookmarkedList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/empty_bookmark.png',
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                          ),
                          Text(
                            'Empty List',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'There is no bookmarked record',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
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
