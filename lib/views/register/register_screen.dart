import 'package:expense_tracker/views/signin_screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.ui.dart';
import '../../providers/register_provider.dart';
import '../../widgets/purple_button.dart';
import '../../widgets/signin_field.dart';
import '../constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegisterProvider>(context);
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: registerProvider.load,
        blur: 1,
        child: Scaffold(
            backgroundColor: const Color(0xffffffff),
            bottomNavigationBar: Container(
                width: Get.width,
                height: 50,
                alignment: Alignment.center,
                color: const Color(0xfff4f4f4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    InkWell(
                        onTap: () {
                          Get.offAll(() => SignInScreen());
                        },
                        child: const Text("Login here.",
                            style: TextStyle(
                                color: purpleColor,
                                decoration: TextDecoration.underline)))
                  ],
                )),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                width: Get.width,
                height: Get.height,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      verticalRSpace(0.03),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset("assets/logo.png"),
                      ),
                      const Text(
                        "Expense Tracker",
                        style: TextStyle(
                            color: Color(0xff1AD5AD),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(20),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "We help our users to make the right financial decisions.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      verticalSpace(20),
                      Form(
                        key: _key,
                        child: Column(
                          children: [
                            SigninField(
                                hint: "Name",
                                isPass: false,
                                controller: name,
                                isNumber: false),
                            verticalSpace(10),
                            SigninField(
                                controller: email,
                                hint: "Email",
                                isPass: false,
                                isNumber: false),
                            verticalSpace(10),
                            SigninField(
                                controller: password,
                                hint: "Password",
                                isPass: true,
                                isNumber: false),
                            verticalSpace(10),
                            SigninField(
                                controller: cpassword,
                                hint: "Confirm Password",
                                isPass: true,
                                isNumber: false),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      PurpleButton(
                          height: 50,
                          width: Get.width * 0.9,
                          title: "Register",
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              await registerProvider.registerUser(
                                context,
                                name.text.trim(),
                                email.text.trim(),
                                password.text.trim(),
                                cpassword.text.trim(),
                              );
                            }
                          }),
                      verticalSpace(10),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
