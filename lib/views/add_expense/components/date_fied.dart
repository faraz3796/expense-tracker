import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../providers/add_expense_provider.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.date,
  });

  final TextEditingController date;

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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          controller: date,
          onTap: () {
            provider.selectDate(context, date);
          },
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Select Date',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.calendar_today),
          ),
          validator: (v) {
            if (v!.isEmpty) {
              return "Select the date";
            }
            return null;
          },
        ),
      ),
    );
  }
}
