import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/home.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/strings_extension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/services.dart';

class LoginPageProvider with ChangeNotifier {
  bool loading = false;

  signinOnFirebase(email, passwd, context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      loading = true;
      notifyListeners();
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: passwd);
      loading = false;
      notifyListeners();

      services.keepsession();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
      return StringResources.login_success.captilize;
    } on FirebaseAuthException catch (e) {
      loading = false;
      notifyListeners();
      return e.code;
    } catch (e) {
      loading = false;
      notifyListeners();
      return e;
    }
  }
}
