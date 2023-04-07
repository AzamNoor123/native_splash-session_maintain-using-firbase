import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/strings_extension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/services.dart';

import '../../Views/detail.dart';
import '../constants_resource.dart';

class menuButton extends StatelessWidget {
  const menuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: ConstatntStrings.Popup_menu_item_0,
            child: Text(ConstatntStrings.Detail_page.captilize),
          ),
          PopupMenuItem<int>(
            value: ConstatntStrings.Popup_menu_item_1,
            child: Text(StringResources.logout_btn.captilize),
          )
        ];
      },
      onSelected: (value) {
        if (value == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailPage()),
          );
        } else {
          services.showdialog(context);
        }
      },
    );
  }
}
