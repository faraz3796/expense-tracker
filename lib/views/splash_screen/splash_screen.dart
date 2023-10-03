import 'package:flutter/material.dart';

import '../../helpers/helpers.ui.dart';
import '../constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            verticalSpace(20),
            const Text(
              "Expense Tracker",
              style: TextStyle(
                  color: greenColor, fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
