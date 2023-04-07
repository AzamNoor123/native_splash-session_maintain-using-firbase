import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/Views/signup.dart';
import 'package:task_2_ui_ui_firebase_firestore/provider/login_provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/context_extensions.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/strings_extension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/widgets_extensions.dart';

import '../utills/constants_resource.dart';
import '../utills/custom_widgets/custom_text_field.dart';

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
                    CustomTextField(
                            controller: emailController,
                            hint: StringResources.hint_email,
                            name: StringResources.l_email,
                            fieldenable: true,
                            validator: (value) {
                              if (value == 0 || value!.isEmpty) {
                                return StringResources.hint_email.captilize;
                              } else if (!value.isValidEmail()) {
                                return StringResources.enter_valid_email;
                              }
                            })
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    CustomTextField(
                      controller: passwordController,
                      fieldenable: true,
                      textObscure: true,
                      hint: StringResources.hint_passwd,
                      name: StringResources.l_passwd,
                      validator: (p0) {
                        if (p0 == 0 || p0!.isEmpty) {
                          return StringResources.hint_passwd;
                        } else if (p0.length <= 5) {
                          return StringResources.passwdValid;
                        }
                      },
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
