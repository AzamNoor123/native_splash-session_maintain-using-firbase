import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';

extension stringvalidation on String {
  bool isValidEmail() {
    if (isEmpty) return false;
    final regex = StringResources.regex;
    return regex.hasMatch(this);
  }

  String get captilize {
    return this[0].toUpperCase() + substring(1);
  }
}

extension widgets on Widget {
  Widget get centerwidget {
    return Center(
      child: this,
    );
  }

  Widget cornerRadius(BorderRadiusGeometry radius) {
    return ClipRRect(
      borderRadius: radius,
      child: this,
    );
  }

  Widget padding(
      [EdgeInsetsGeometry value = const EdgeInsets.all(DimenResource.D_16)]) {
    return Padding(
      padding: value,
      child: this,
    );
  }
}

extension SnakeBar on ScaffoldMessengerState {
  void showSnakeBar(String message) {
    showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
