import 'package:expense_tracker/views/bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../widgets/utils.dart';

class RegisterProvider extends ChangeNotifier {
  bool _load = false;
  bool get load => _load;

  void loading(bool res) {
    _load = res;
    notifyListeners();
  }

  Future registerUser(context, _name, _email, _password, _cpassword) async {
    if (_password == _cpassword) {
      loading(true);
      final res = await AuthService().registerUser(_email, _password, _name);
      if (res == 200) {
        loading(false);
        Get.offAll(() => MyBottomBar());
      } else {
        loading(false);
        Utils().toastMessage(context, "Error Occurred!", Colors.red);
      }
    } else {
      Utils().toastMessage(context, "Both password are not same.", Colors.red);
    }
  }
}
