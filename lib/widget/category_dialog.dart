import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:expense_ledger/value/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDialog extends StatefulWidget {
  const CategoryDialog({super.key, required this.category});
  final Category category;

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final TextEditingController _nameTextController = TextEditingController();
  String selectedType = 'income';
  bool isNew = false;
  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.category.name.isEmpty) {
      isNew = true;
    } else {
      _nameTextController.text = widget.category.name;
      selectedType = widget.category.type;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '${isNew ? 'New' : 'Edit'} Category',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Name',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 14)),
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
          Text('Type',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 14)),
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
                  TextButton(
                      onPressed: (() {
                        setState(() {
                          selectedType = 'income';
                        });
                      }),
                      child: Text('Income',
                          style: Theme.of(context).textTheme.bodyLarge))
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
                  TextButton(
                      onPressed: (() {
                        setState(() {
                          selectedType = 'expense';
                        });
                      }),
                      child: Text('Expense',
                          style: Theme.of(context).textTheme.bodyLarge))
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
          onPressed: () {
            var categoryProvider =
                Provider.of<CategoryProvider>(context, listen: false);
            if (isNew) {
              categoryProvider.addToCategoryList(
                  Category(name: _nameTextController.text, type: selectedType));
            } else {
              categoryProvider.editCategoryList(
                  Category(name: _nameTextController.text, type: selectedType),
                  widget.category);
            }
            Navigator.of(context).pop();
          },
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
