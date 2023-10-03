import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../helpers/helpers.ui.dart';
import '../../providers/signin_provider.dart';
import '../../widgets/purple_button.dart';
import '../../widgets/signin_field.dart';
import '../constants.dart';
import '../register/register_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: signInProvider.load,
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
                    const Text("Don't have an account? "),
                    InkWell(
                        onTap: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: const Text("Register here.",
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
                      verticalRSpace(0.05),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset(
                          "assets/logo.png",
                        ),
                      ),
                      verticalSpace(10),
                      const Text(
                        "Expense Tracker",
                        style: TextStyle(
                            color: greenColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      verticalSpace(20),
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your goals will help us to formulate the right recommendations for success",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      verticalSpace(20),
                      Form(
                        key: _key,
                        child: Column(
                          children: [
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
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      PurpleButton(
                          height: 50,
                          width: Get.width * 0.9,
                          title: "Sign In",
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              await signInProvider.signIn(context,
                                  email.text.trim(), password.text.trim());
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
