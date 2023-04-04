import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/provider/signup_provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/ConstantStrings.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';

import '../utills/custom_Widgets.dart';

class SignupSreen extends StatefulWidget {
  const SignupSreen({super.key});

  @override
  State<SignupSreen> createState() => _SignupSreenState();
}

class _SignupSreenState extends State<SignupSreen> {
  TextEditingController firstctr = TextEditingController();
  TextEditingController lastctr = TextEditingController();
  TextEditingController emailctr = TextEditingController();
  TextEditingController passwdctr = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  var result;

  @override
  void dispose() {
    firstctr.dispose();
    lastctr.dispose();
    emailctr.dispose();
    passwdctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstatntStrings.Signup_page.captilize),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ChangeNotifierProvider<SignupProvider>(
          create: (context) => SignupProvider(),
          child: Form(
              key: formkey,
              child: Consumer<SignupProvider>(
                builder: (context, provider, child) => Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          DimenResource.D_0_2,
                    ),
                    firstTextField(fieldenable: true, firstctr: firstctr)
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    lastTextField(fieldenable: true, lastctr: lastctr)
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    emailTextField(
                      fieldenable: true,
                      emaictr: emailctr,
                    )
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    passwdTextField(
                      enablefield: true,
                      passwdctr: passwdctr,
                    )
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            result = await provider.signupOnFirebase(
                                emailctr.text,
                                passwdctr.text,
                                firstctr.text.captilize,
                                lastctr.text.captilize,
                                context);
                            ScaffoldMessenger.of(context).showSnakeBar(result);
                          } else
                            return null;
                        },
                        child: Text(StringResources.signup_btn.captilize)),
                    provider.loading == true
                        ? const CircularProgressIndicator()
                        : Text(result ?? ''),
                  ],
                ),
              )),
        ),
      )),
    );
  }
}
