import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String hint;
  final bool fieldenable;
  final String? Function(String?)? validator;
  final bool? textObscure;

  const CustomTextField({
    required this.controller,
    required this.name,
    required this.hint,
    required this.fieldenable,
    this.validator,
    this.textObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      enabled: fieldenable,
      obscureText: textObscure ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: name,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimenResource.D_10),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimenResource.D_10),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimenResource.D_10),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
