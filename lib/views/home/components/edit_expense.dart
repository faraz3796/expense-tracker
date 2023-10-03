import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/helpers/helpers.ui.dart';
import 'package:expense_tracker/providers/add_expense_provider.dart';
import 'package:expense_tracker/widgets/signin_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../models/expense_model.dart';
import '../../../widgets/purple_button.dart';
import '../../add_expense/components/category_picker.dart';
import '../../add_expense/components/date_fied.dart';

class EditExpense extends StatelessWidget {
  EditExpense({super.key, required this.expense});

  final ExpenseModel expense;

  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool assign = false;

  @override
  Widget build(BuildContext context) {
    if (!assign) {
      title = TextEditingController(text: expense.title);
      amount = TextEditingController(text: expense.amount.toString());
      date = TextEditingController(
        text: DateFormat('MMMM d, y').format(expense.date),
      );
      assign = true;
      print("Assigned");
    }
    final provider = Provider.of<AddExpenseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Edit Expense"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              provider.clear();
              Get.close(1);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ModalProgressHUD(
        inAsyncCall: provider.load,
        blur: 1,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            width: Get.width,
            height: Get.height,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      verticalRSpace(0.04),
                      const Text(
                        "Edit",
                        style: TextStyle(fontSize: 20),
                      ),
                      verticalSpace(20),
                      SigninField(
                          controller: title,
                          hint: "Title",
                          isPass: false,
                          isNumber: false),
                      verticalSpace(10),
                      categoryPicker(),
                      verticalSpace(10),
                      SigninField(
                          controller: amount,
                          hint: "Amount",
                          isPass: false,
                          isNumber: true),
                      verticalSpace(10),
                      DateField(
                        date: date,
                      ),
                      verticalSpace(10),
                      ElevatedButton(
                          onPressed: () {
                            provider.pickReceipt();
                          },
                          child: const Text("Add Receipt Image (Optional)")),
                      verticalSpace(10),
                      provider.receipt != null
                          ? Container(
                              width: Get.width * 0.6,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Image.file(
                                provider.receipt!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : expense.receipt.isNotEmpty
                              ? Container(
                                  width: Get.width * 0.6,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              expense.receipt))),
                                )
                              : verticalSpace(0),
                      verticalSpace(20),
                      PurpleButton(
                        height: 45,
                        width: Get.width * 0.9,
                        title: "Edit",
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            await provider.editExpense(
                                context,
                                ExpenseModel(
                                    uid: expense.uid,
                                    id: expense.id,
                                    title: title.text.trim(),
                                    category: provider.selectedCategory,
                                    amount: double.parse(amount.text.trim()),
                                    date: provider.selectedDate!,
                                    receipt: expense.receipt));
                            Navigator.pop(context);
                          }
                        },
                      ),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
