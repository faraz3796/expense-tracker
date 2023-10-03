import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/providers/add_expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'edit_expense.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile({
    super.key,
    required this.expense,
  });

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddExpenseProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dragDismissible: false,
              dismissible:
                  DismissiblePane(closeOnCancel: true, onDismissed: () {}),
              children: [
                SlidableAction(
                  autoClose: true,
                  flex: 5,
                  onPressed: (context) {
                    provider.setCategory(expense.category);
                    provider.setDate(expense.date);

                    Get.to(() => EditExpense(expense: expense));
                  },
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  autoClose: true,
                  flex: 5,
                  onPressed: (context) async {
                    if (!provider.load) {
                      await provider.deleteExpense(context, expense.id);
                    }
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff1C162E),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
              title: Text(
                expense.title,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                DateFormat('MMMM d, y').format(expense.date),
                style: TextStyle(color: Colors.grey.withOpacity(0.5)),
              ),
              trailing: Text(
                "-${expense.amount} AED",
                style: const TextStyle(fontSize: 15, color: Colors.redAccent),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditExpenseSheet(BuildContext context, ExpenseModel expense) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return EditExpense(
          expense: expense,
        );
      },
    );
  }
}
