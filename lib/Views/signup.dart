import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/provider/signup_provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/context_extensions.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/strings_extension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/widgets_extensions.dart';

import '../utills/constants_resource.dart';
import '../utills/custom_widgets/custom_text_field.dart';

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
                    CustomTextField(
                      controller: firstctr,
                      fieldenable: true,
                      hint: StringResources.hint_first,
                      name: StringResources.l_first,
                      validator: (p0) {
                        if (p0 == 0 || p0!.isEmpty) {
                          return StringResources.hint_first;
                        }
                      },
                    )
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    CustomTextField(
                      controller: lastctr,
                      fieldenable: true,
                      hint: StringResources.hint_last,
                      name: StringResources.l_last,
                      validator: (p0) {
                        if (p0 == 0 || p0!.isEmpty) {
                          return StringResources.hint_last;
                        }
                      },
                    )
                        .cornerRadius(BorderRadius.circular(DimenResource.D_10))
                        .padding(),
                    CustomTextField(
                            controller: emailctr,
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
                      controller: passwdctr,
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
