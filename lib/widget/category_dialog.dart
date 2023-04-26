import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:flutter/material.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({super.key, required this.category});
  final Category category;

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final TextEditingController _nameTextController = TextEditingController();
  String selectedType = 'income';
  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${widget.category.name == '' ? 'New' : 'Edit'} Category',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Name', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            onTap: () {},
            controller: _nameTextController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              fillColor: MyColors.textFieldColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text('Type', style: Theme.of(context).textTheme.bodyLarge),
          Column(
            children: [
              Row(
                children: [
                  Radio(
                      value: 'income',
                      groupValue: selectedType,
                      onChanged: ((value) => setState(() {
                            selectedType = value as String;
                          }))),
                  Text('Income',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 14))
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 'expense',
                      groupValue: selectedType,
                      onChanged: ((value) => setState(() {
                            selectedType = value as String;
                          }))),
                  Text('Expense',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 14))
                ],
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            "Save",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
