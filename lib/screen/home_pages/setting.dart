import 'package:expense_ledger/value/colors.dart';
import 'package:expense_ledger/value/route_names.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          ListTile(
            onTap: () => Navigator.of(context).pushNamed(RouteName.category),
            tileColor: Colors.white,
            leading: const Icon(
              Icons.category_rounded,
              color: Color.fromARGB(255, 7, 7, 7),
            ),
            title: Text(
              'Category',
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
