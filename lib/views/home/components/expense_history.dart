import 'package:flutter/material.dart';

import '../../../models/expense_model.dart';
import 'expense_tile.dart';

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({
    super.key,
    required this.expenses,
  });

  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return ExpenseTile(
                expense: expenses[index],
              );
            }));
  }
}
