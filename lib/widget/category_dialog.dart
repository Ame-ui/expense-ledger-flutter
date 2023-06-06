import 'package:expense_ledger/model/category.dart';
import 'package:expense_ledger/provider/provider_category.dart';
import 'package:expense_ledger/provider/provider_expense.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedType = 'Income';
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
          Form(
            key: _formKey,
            child: TextFormField(
              // onTap: () {},
              autofocus: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name can\'t be empty';
                } else {
                  var categoryProvider =
                      Provider.of<CategoryProvider>(context, listen: false);
                  bool isAlreadyExist = false;
                  for (var element in categoryProvider.categoryList) {
                    if (element.name == _nameTextController.text &&
                        element.type == selectedType) {
                      isAlreadyExist = true;
                      break;
                    }
                  }
                  if (isAlreadyExist) {
                    return 'Category already exist';
                  } else {
                    return null;
                  }
                }
              },
              controller: _nameTextController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                fillColor: MyColors.textFieldColor,
                filled: true,
                errorStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.red, fontSize: 14),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                      value: 'Income',
                      groupValue: selectedType,
                      onChanged: ((value) => setState(() {
                            selectedType = value as String;
                          }))),
                  TextButton(
                      onPressed: (() {
                        setState(() {
                          selectedType = 'Income';
                        });
                      }),
                      child: Text('Income',
                          style: Theme.of(context).textTheme.bodyLarge))
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 'Expense',
                      groupValue: selectedType,
                      onChanged: ((value) => setState(() {
                            selectedType = value as String;
                          }))),
                  TextButton(
                      onPressed: (() {
                        setState(() {
                          selectedType = 'Expense';
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
            if (_formKey.currentState!.validate()) {
              if (isNew) {
                categoryProvider.addToCategoryList(Category(
                    name: _nameTextController.text, type: selectedType));
              } else {
                var editedCategory = Category(
                    name: _nameTextController.text, type: selectedType);
                categoryProvider.editCategoryList(
                    editedCategory, widget.category);
                //to update all expense with old category
                var expenseProvider =
                    Provider.of<ExpenseProvider>(context, listen: false);
                for (var element in expenseProvider.allExpenseList) {
                  print(widget.category.name);
                  print(widget.category.type);
                  print(element.category.name);
                  print(element.category.type);
                  if (element.category == widget.category) {
                    print('true');
                    expenseProvider
                        .allExpenseList[
                            expenseProvider.allExpenseList.indexOf(element)]
                        .category = editedCategory;
                  }
                }
                expenseProvider.checkAndStoreToDb(context);
                // print(editedCategory.name);
                // print(editedCategory.type);
                // print(expenseProvider.allExpenseList[0].category.name);
                // print(expenseProvider.allExpenseList[0].category.type);
              }
              Navigator.of(context).pop();
            }
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
