import 'package:flutter/material.dart';
import 'package:flutter_learn_20230831/src/constants/dummy/categories.dart';
import 'package:flutter_learn_20230831/src/models/category.dart';
import 'package:flutter_learn_20230831/src/models/grocery_item.dart';

class NewItemscreen extends StatefulWidget {
  const NewItemscreen({super.key});

  @override
  State<NewItemscreen> createState() => _NewItemscreenState();
}

class _NewItemscreenState extends State<NewItemscreen> {
  final _formKey = GlobalKey<FormState>();

  var _formName = '';
  var _formQuantity = 1;
  var _formCategory = categories[Categories.vegetables]!;

  void _saveItem() {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    Navigator.of(context).pop(
      GroceryItem(
        id: DateTime.now().toString(),
        name: _formName,
        quantity: _formQuantity,
        category: _formCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 to 50 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formName = value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _formQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.parse(value) <= 0) {
                          return 'Must be a valid positive number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      items: categories.entries
                          .map(
                            (category) => DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(category.value.title)
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      value: _formCategory,
                      onChanged: (value) {
                        setState(() {
                          _formCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
