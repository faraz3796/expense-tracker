import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninField extends StatelessWidget {
  const SigninField({
    super.key,
    required this.controller,
    required this.hint,
    required this.isPass,
    required this.isNumber,
  });

  final hint;
  final bool isPass;
  final TextEditingController controller;
  final bool isNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.95,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color: Color(0xfff4f4f4), width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: TextFormField(
          obscureText: isPass,
          controller: controller,
          keyboardType: isNumber
              ? TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          decoration:
              InputDecoration(border: InputBorder.none, labelText: hint),
          validator: (v) {
            if (v!.isEmpty) {
              return "Enter the $hint";
            } else if (hint == 'Email') {
              if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                  .hasMatch(v)) {
                return "Invalid Email Format";
              }
              return null;
            } else if (hint == "Password") {
              if (v.length < 5) {
                return "Password length must be greater than or equal to 6";
              }
              return null;
            }
            return null;
          },
        ),
      ),
    );
  }
}
