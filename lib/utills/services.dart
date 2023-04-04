import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/home.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/login.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/CommonKeys.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';

import '../provider/signup_provider.dart';

final storage = FlutterSecureStorage();

class services {
  static showdialog(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(StringResources.logout_btn.captilize),
              content: Text(StringResources.dialog_content.captilize),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      signout(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(StringResources.yes.captilize)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(StringResources.no.captilize))
              ],
            ));
  }

  static signout(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    storage.write(key: CommonKeys.Session_key, value: CommonKeys.String_false);
    storage.write(key: CommonKeys.Session_userid, value: null);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (Route<dynamic> route) => false);
    ScaffoldMessenger.of(context)
        .showSnakeBar(StringResources.signout_success.captilize);
  }

  static keepsession() async {
    await storage.write(
        key: CommonKeys.Session_key, value: CommonKeys.String_true);
    await storage.write(key: CommonKeys.Session_userid, value: userid);
  }

  static readSession(context) async {
    var sval;
    await storage
        .read(key: CommonKeys.Session_userid)
        .then((uvalue) => userid = uvalue);
    await storage
        .read(key: CommonKeys.Session_key)
        .then((value) => sval = value);

    if (sval == CommonKeys.String_true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }
}
