import 'dart:io';

import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/services/expense_service.dart';
import 'package:expense_tracker/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddExpenseProvider extends ChangeNotifier {
  String _selectedCategory = 'Select Category';
  String get selectedCategory => _selectedCategory;
  final List _categories = [
    'Select Category',
    'Food',
    'Transportation',
    'Entertainment',
    'Eduction',
    'Rent',
    'Utility Bills',
  ];
  List get categories => _categories;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  File? _receipt;
  File? get receipt => _receipt;
  bool _load = false;
  bool get load => _load;

  Future selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dateController.text = "${_selectedDate!.toLocal()}".split(' ')[0];
      notifyListeners();
    }
  }

  Future pickReceipt() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      _receipt = File(pickedImageFile.path);
    }
    notifyListeners();
  }

  void setCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  Future addExpense(
    context,
    String title,
    double amount,
  ) async {
    loading(true);
    final res = await ExpenseService()
        .addExpense(title, _selectedCategory, amount, _selectedDate!, receipt);
    if (res == 200) {
      loading(false);
      Get.close(1);
      Utils().toastMessage(context, "Expense Added", Colors.green);
    } else {
      loading(false);
      Utils().toastMessage(context, "Error Occurred!", Colors.red);
    }
    notifyListeners();
  }

  Future deleteExpense(context, String id) async {
    loading(true);
    final res = await ExpenseService().deleteExpense(id);
    if (res == 200) {
      loading(false);
    } else {
      loading(false);
      Utils().toastMessage(context, "Error Occurred!", Colors.red);
    }
    notifyListeners();
  }

  Future editExpense(
    context,
    ExpenseModel expense,
  ) async {
    loading(true);
    if (_receipt == null) {
      final res = await ExpenseService().editExpense(expense);
      if (res == 200) {
        loading(false);
      } else {
        loading(false);
        Utils().toastMessage(context, "Error Occurred!", Colors.red);
      }
    } else {
      String url = await ExpenseService().uploadFile(_receipt!, expense.id);
      final res = await ExpenseService().editExpense(ExpenseModel(
          uid: expense.uid,
          id: expense.id,
          title: expense.title,
          category: expense.category,
          amount: expense.amount,
          date: expense.date,
          receipt: url));
      if (res == 200) {
        loading(false);
      } else {
        loading(false);
        Utils().toastMessage(context, "Error Occurred!", Colors.red);
      }
    }
    notifyListeners();
  }

  loading(bool res) {
    _load = res;
    notifyListeners();
  }

  clear() {
    _selectedCategory = "Select Category";
    _receipt = null;
    _selectedDate = null;
    notifyListeners();
  }
}
