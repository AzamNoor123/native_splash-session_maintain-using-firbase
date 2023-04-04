import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/CommonKeys.dart';

class HomePageProvider with ChangeNotifier {
  bool isenable = false;
  String? userid;

  fieldEnabled() {
    isenable = true;
    notifyListeners();
  }

  fieldDisabled() {
    isenable = false;
    notifyListeners();
  }

  Future<void> fatchingdata(TextEditingController firstctr,
      TextEditingController lastctr, TextEditingController emailctr) async {
    bool loading = true;
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String userid = auth.currentUser!.uid;

    await firestore
        .collection(CommonKeys.Key_db)
        .doc(userid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        firstctr.text = documentSnapshot[CommonKeys.Key_Field_first];
        lastctr.text = documentSnapshot[CommonKeys.Key_Field_last];
        emailctr.text = documentSnapshot[CommonKeys.Key_Field_email];
        loading = false;
      } else {
        loading = false;
      }
    });
  }

  update(first, last, email) {
    userid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection(CommonKeys.Key_db)
        .doc(userid)
        .update({
      CommonKeys.Key_Field_first: first,
      CommonKeys.Key_Field_last: last,
      CommonKeys.Key_Field_email: email
    });
  }
}
