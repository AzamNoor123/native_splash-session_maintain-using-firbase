import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/detail.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/ConstantStrings.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/services.dart';

class emailTextField extends StatelessWidget {
  emailTextField({this.emaictr, this.fieldenable});

  Text? name = Text(StringResources.l_email.captilize);
  String? hint = StringResources.hint_email.captilize;
  bool? fieldenable;

  TextEditingController? emaictr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emaictr,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringResources.enter_email.captilize;
        }
        if (!value.isValidEmail()) {
          return StringResources.enter_valid_email.captilize;
        }
        return null;
      },
      enabled: fieldenable,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: name,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.blueAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}

class passwdTextField extends StatefulWidget {
  passwdTextField({this.passwdctr, this.enablefield});

  bool? enablefield;

  TextEditingController? passwdctr;

  @override
  State<passwdTextField> createState() => _passwdTextFieldState();
}

class _passwdTextFieldState extends State<passwdTextField> {
  Text? name = Text(StringResources.l_passwd.captilize);

  String? hint = StringResources.hint_passwd.captilize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: widget.passwdctr,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringResources.hint_passwd.captilize;
        } else if (value.length >= ConstatntStrings.Passwd_length) {
          return null;
        } else {
          return StringResources.passwdValid.captilize;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enablefield,
      decoration: InputDecoration(
        label: name,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.blueAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}

class firstTextField extends StatelessWidget {
  firstTextField({super.key, this.firstctr, this.fieldenable});

  Text? name = Text(StringResources.l_first.captilize);
  String? hint = StringResources.hint_first.captilize;
  bool? fieldenable;
  String? error;

  TextEditingController? firstctr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstctr,
      enabled: fieldenable,
      validator: (value) {
        if (value!.isEmpty || value == null) {
          return StringResources.entFnm;
        } else {
          return null;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: name,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.blueAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}

class lastTextField extends StatefulWidget {
  lastTextField({this.lastctr, this.fieldenable});

  bool? fieldenable;

  TextEditingController? lastctr = TextEditingController();

  @override
  State<lastTextField> createState() => _lastTextFieldState();
}

class _lastTextFieldState extends State<lastTextField> {
  Text? name = Text(StringResources.l_last.captilize);

  String? hint = StringResources.hint_last.captilize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.lastctr,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringResources.entLnm.captilize;
        }
      },
      enabled: widget.fieldenable,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: name,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.blueAccent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DimenResource.D_10),
            borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }
}

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
            MaterialPageRoute(builder: (context) => DetailPage()),
          );
        } else {
          services.showdialog(context);
        }
      },
    );
  }
}
