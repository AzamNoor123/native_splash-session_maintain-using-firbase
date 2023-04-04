import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/home.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/CommonKeys.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/services.dart';

String? userid;

class SignupProvider with ChangeNotifier {
  bool? loading = false;

  signupOnFirebase(email, passwd, first, last, context) async {
    try {
      loading = true;
      notifyListeners();
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      final User user = userCredential.user!;
      sendDataOnFirestore(first, last, email, passwd);
      loading = false;
      notifyListeners();
      services.keepsession();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
      return StringResources.signup_success.captilize;
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

  sendDataOnFirestore(
    first,
    last,
    email,
    passwd,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    userid = auth.currentUser!.uid;
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection(CommonKeys.Key_db).doc(userid).set({
      CommonKeys.Key_Field_first: first,
      CommonKeys.Key_Field_last: last,
      CommonKeys.Key_Field_email: email,
      CommonKeys.Key_Field_Passwd: passwd,
      CommonKeys.Key_Field_userid: userid
    });
  }
}
