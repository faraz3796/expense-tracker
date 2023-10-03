import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final db = FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance;

  Future registerUser(
    String email,
    String password,
    String name,
  ) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        if (value.user != null) {
          UserModel userr = UserModel(
            uid: value.user!.uid,
            fullName: name,
            email: email,
          );
          await db.doc(value.user!.uid).set(userr.toJson());
          await value.user!.updateDisplayName(name);
        }
        return 200;
      });
      return 200;
    } catch (e) {
      print(" error:" + e.toString());
      return 300;
    }
  }

  Future userSignIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return 200;
    } catch (e) {
      print("error:" + e.toString());
      return 400;
    }
  }
}
