import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/signup.dart';
import 'package:task_2_ui_ui_firebase_firestore/provider/login_provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/ConstantStrings.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Widgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var result;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstatntStrings.Login_page),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider<LoginPageProvider>(
            create: (context) => LoginPageProvider(),
            child: Consumer<LoginPageProvider>(
              builder: (context, provider, child) => Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          DimenResource.D_0_2,
                    ),
                    emailTextField(
                      emaictr: emailController,
                      fieldenable: true,
                    )
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    passwdTextField(
                      enablefield: true,
                      passwdctr: passwordController,
                    )
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          result = await provider.signinOnFirebase(
                              emailController.text,
                              passwordController.text,
                              context);
                          ScaffoldMessenger.of(context).showSnakeBar(result);
                        } else {
                          return null;
                        }
                      },
                      child: Text(StringResources.login_btn.captilize),
                    ),
                    provider.loading == true
                        ? CircularProgressIndicator()
                        : Text(result ?? ''),
                    Text(StringResources.newuser),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignupSreen()))),
                      child: Text(
                        StringResources.signup_btn,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
