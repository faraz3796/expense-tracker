import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/helpers/helpers.ui.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../providers/add_expense_provider.dart';
import '../add_expense/add_expense.dart';
import 'components/expense_balance.dart';
import 'components/expense_history.dart';
import 'components/home_shimmer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddExpenseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Expenses"),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddExpense());
              },
              icon: Icon(Icons.add_circle_outline_outlined))
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: provider.load,
        blur: 1,
        child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('expenses').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ExpenseModel> expenses = [];
                double balance = 0.0;
                snapshot.data!.docs.forEach((element) {
                  ExpenseModel expense = ExpenseModel.fromJson(
                      element.data() as Map<String, dynamic>);
                  if (expense.uid == auth.currentUser!.uid) {
                    expenses.add(expense);
                    balance = balance + expense.amount;
                  }
                });
                return Container(
                  height: Get.height,
                  width: Get.width,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      ExpenseBalance(
                        balance: balance,
                      ),
                      verticalSpace(10),
                      SizedBox(
                        width: Get.width * 0.9,
                        child: const Text(
                          "Expense History",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      verticalSpace(10),
                      ExpenseHistory(
                        expenses: expenses,
                      ),
                      verticalSpace(10),
                    ],
                  ),
                );
              }
              return const HomeShimmer();
            }),
      ),
    );
  }
}
