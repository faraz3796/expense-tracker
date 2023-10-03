import 'package:expense_tracker/helpers/helpers.ui.dart';
import 'package:expense_tracker/providers/add_expense_provider.dart';
import 'package:expense_tracker/widgets/signin_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../widgets/purple_button.dart';
import 'components/category_picker.dart';
import 'components/date_fied.dart';

class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddExpenseProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: provider.load,
      blur: 1,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            title: Text("Add Expense"),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  provider.clear();
                  Get.close(1);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          body: Container(
            width: Get.width,
            height: Get.height,
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    verticalRSpace(0.04),
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
                        child: Text("Select Receipt Image (Optional)")),
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
                        : verticalSpace(0),
                    verticalSpace(20),
                    PurpleButton(
                      height: 45,
                      width: Get.width * 0.9,
                      title: "Add",
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          await provider.addExpense(context, title.text.trim(),
                              double.parse(amount.text.trim()));
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
    );
  }
}
