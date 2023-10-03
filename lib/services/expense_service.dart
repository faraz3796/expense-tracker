import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ExpenseService {
  final db = FirebaseFirestore.instance.collection("expenses");
  final auth = FirebaseAuth.instance;

  Future addExpense(String title, String category, double amount, DateTime date,
      File? receipt) async {
    String id = db.doc().id;
    String url = "";
    if (receipt != null) {
      url = await uploadFile(receipt, id);
    }
    ExpenseModel expense = ExpenseModel(
        uid: auth.currentUser!.uid,
        id: id,
        title: title,
        category: category,
        amount: amount,
        date: date,
        receipt: url);
    try {
      await db.doc(id).set(expense.toJson());
      return 200;
    } catch (e) {
      debugPrint(e.toString());
      return 300;
    }
  }

  Future uploadFile(File photo, String id) async {
    String url = "";
    try {
      Reference ref = FirebaseStorage.instance
          .ref("receipts")
          .child("${auth.currentUser!.uid}/$id");
      TaskSnapshot task = await ref.putFile(photo);
      url = await task.ref.getDownloadURL();
      return url;
    } catch (e) {
      debugPrint(e.toString());
      return "";
    }
  }

  Future deleteExpense(String id) async {
    try {
      await db.doc(id).delete();
      return 200;
    } catch (e) {
      return 300;
    }
  }

  Future editExpense(ExpenseModel expense) async {
    try {
      await db.doc(expense.id).update(expense.toJson());
      return 200;
    } catch (e) {
      return 300;
    }
  }
}
