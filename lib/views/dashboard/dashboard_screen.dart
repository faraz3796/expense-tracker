import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/providers/dashboard_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/expense_model.dart';

class DashboardScreen extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('expenses').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ExpenseModel> daily = [];
              List<ExpenseModel> weekly = [];
              List<ExpenseModel> monthly = [];
              DateTime now = DateTime.now();
              snapshot.data!.docs.forEach((element) {
                ExpenseModel expense = ExpenseModel.fromJson(
                    element.data() as Map<String, dynamic>);
                if (expense.uid == auth.currentUser!.uid) {
                  if (expense.date.year == now.year && expense.date.month == now.month && expense.date.day == now.day) {
                    daily.add(expense);
                  }
                  if (expense.date
                      .isAfter(now.subtract(Duration(days: 7)))) {
                    // Add to weekly list if within the last 7 days
                    weekly.add(expense);
                  }
                  if (expense.date.year == now.year &&
                      expense.date.month == now.month) {
                    monthly.add(expense);
                  }
                }
              });
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DropdownButton<String>(
                      value: provider.selectedTime,
                      onChanged: (value) {
                        provider.setTime(value!);
                      },
                      items: provider.time.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        BarSeries<ExpenseModel, String>(
                          dataSource: provider.selectedTime == "Daily"
                              ? daily
                              : provider.selectedTime == "Weekly"
                                  ? weekly
                                  : monthly,
                          xValueMapper: (ExpenseModel data, _) => data.category,
                          yValueMapper: (ExpenseModel data, _) => data.amount,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(
                        //labels: ChartDataLabelSettings(isVisible: true),
                        labelPlacement: LabelPlacement.betweenTicks,
                        majorTickLines: MajorTickLines(size: 0),
                        title: AxisTitle(text: 'Time'),
                        axisLine: AxisLine(width: 0),
                        labelStyle: TextStyle(fontSize: 12),
                        majorGridLines: MajorGridLines(width: 0),
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(text: 'Expense'),
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 1),
                        majorTickLines: MajorTickLines(size: 0),
                      ),
                      series: <ChartSeries>[
                        LineSeries<ExpenseModel, String>(
                          dataSource: provider.selectedTime == "Daily"
                              ? daily
                              : provider.selectedTime == "Weekly"
                                  ? weekly
                                  : monthly,
                          xValueMapper: (ExpenseModel data, _) => data.category,
                          yValueMapper: (ExpenseModel data, _) => data.amount,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

// class ExpenseData {
//   final String category;
//   final double amount;
//
//   ExpenseData(this.category, this.amount);
// }
//
// final List<ExpenseData> dailyExpenses = [
//   ExpenseData('Food', 50.0),
//   ExpenseData('Transportation', 30.0),
//   ExpenseData('Entertainment', 20.0),
//   // Add more data for daily expenses
// ];
//
// final List<ExpenseData> monthlyExpenses = [
//   ExpenseData('Food', 800.0),
//   ExpenseData('Transportation', 400.0),
//   ExpenseData('Entertainment', 300.0),
//   ExpenseData('Rent', 400.0),
//   ExpenseData('Bills', 1000.0),
//   // Add more data for monthly expenses
// ];
//
// final List<ExpenseData> weeklyExpenses = [
//   ExpenseData('Food', 150.0),
//   ExpenseData('Transportation', 90.0),
//   ExpenseData('Entertainment', 60.0),
//
//   // Add more data for weekly expenses
// ];
