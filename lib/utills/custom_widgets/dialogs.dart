import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/strings_extension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/services.dart';

import '../../Views/login.dart';

class dialogUtils extends StatelessWidget {
  const dialogUtils({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(StringResources.logout_btn.captilize),
      content: Text(StringResources.dialog_content.captilize),
      actions: [
        ElevatedButton(
            onPressed: () {
              services.signout(context);
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
    );
  }
}
