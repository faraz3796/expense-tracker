import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../providers/add_expense_provider.dart';

class categoryPicker extends StatelessWidget {
  const categoryPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddExpenseProvider>(context);
    return Container(
      width: Get.width * 0.95,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: Color(0xfff4f4f4), width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: DropdownButtonFormField<String>(
          value: provider.selectedCategory,
          decoration: const InputDecoration(
              border: InputBorder.none, labelText: "Select Category"),
          onChanged: (newValue) {
            provider.setCategory(newValue!);
          },
          items: provider.categories.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          validator: (v) {
            if (v == "Select Category") {
              return "Select the category";
            }
            return null;
          },
        ),
      ),
    );
  }
}
