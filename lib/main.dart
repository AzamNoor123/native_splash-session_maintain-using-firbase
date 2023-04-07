import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/home.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/login.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/constants_resource.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/services.dart';

bool? has;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? initial;

  @override
  void initState() {
    super.initState();
    readSession();
  }

  void readSession() async {
    var hasSession = await services.readSession(context);
    setState(() {
      has = hasSession;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: ConstatntStrings.Task_name,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: has == true ? HomeScreen() : LoginScreen());
  }
}
