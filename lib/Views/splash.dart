import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/ConstantStrings.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';

import '../utills/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: ConstatntStrings.Splash_duration), () {
      services.readSession(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ConstatntStrings.Splash_image,
        height: DimenResource.D_100,
        width: DimenResource.D_100,
      ).centerwidget,
    );
  }
}
