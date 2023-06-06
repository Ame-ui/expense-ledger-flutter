import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(RouteName.category),
            tileColor: Colors.white,
            leading: const Icon(
              Icons.category_rounded,
              color: MyColors.greyColor,
            ),
            title: Text(
              'Category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(RouteName.bookmark),
            tileColor: Colors.white,
            leading: const Icon(
              Icons.bookmark_rounded,
              color: MyColors.greyColor,
            ),
            title: Text(
              'Bookmarks',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          )
        ]),
      ),
    );
  }
}
