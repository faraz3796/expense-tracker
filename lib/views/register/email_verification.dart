import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/helpers.ui.dart';
import '../../widgets/purple_button.dart';
import '../signin_screen/signin_screen.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_outlined,
              size: 100,
              color: Colors.green,
            ),
            verticalSpace(30),
            SizedBox(
              width: Get.width * 0.8,
              child: const Text(
                "Thank you for registering into Skillz app. An email with verification link has been sent to you. Kindly verify to login to the app.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            verticalSpace(50),
            PurpleButton(
                height: 50,
                width: Get.width * 0.9,
                title: "Go Back to Sign in",
                onTap: () {
                  Get.offAll(() => SignInScreen());
                }),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
