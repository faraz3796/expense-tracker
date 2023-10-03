import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/helpers.ui.dart';

class ExpenseBalance extends StatelessWidget {
  const ExpenseBalance({
    super.key,
    required this.balance,
  });

  final double balance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.35,
      child: Stack(
        children: [
          Image.asset("assets/components/man_balance.png"),
          Positioned(
            top: Get.height * 0.17,
            left: Get.width * 0.15,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xffE8D73F),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    "Expense",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                verticalSpace(10),
                Text(
                  "${balance} AED",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
