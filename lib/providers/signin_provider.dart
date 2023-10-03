import 'package:expense_tracker/views/bottom_bar/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../widgets/utils.dart';

class SignInProvider extends ChangeNotifier {
  bool _load = false;
  bool get load => _load;

  final auth = FirebaseAuth.instance;

  loading(bool res) {
    _load = res;
    notifyListeners();
  }

  Future signIn(context, String email, String password) async {
    loading(true);
    final res = await AuthService().userSignIn(email, password);
    if (res == 200) {
      loading(false);
      Get.offAll(() => MyBottomBar());
    } else {
      loading(false);
      await auth.signOut();
      Utils().toastMessage(context, "Error Occurred!", Colors.red);
    }
  }
}
