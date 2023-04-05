import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/provider/home_provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/ConstantStrings.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';

import '../utills/custom_Widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController firstctr = TextEditingController();

  TextEditingController lastctr = TextEditingController();

  TextEditingController emailctr = TextEditingController();

  GlobalKey<FormState> formkey2 = GlobalKey();
  bool loading = false;

  @override
  void initState() {
    super.initState();
    HomePageProvider().fatchingdata(firstctr, lastctr, emailctr);
  }

  @override
  void dispose() {
    firstctr.dispose();
    lastctr.dispose();
    emailctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ConstatntStrings.Main_page.captilize),
        automaticallyImplyLeading: false,
        actions: const [menuButton()],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ChangeNotifierProvider<HomePageProvider>(
          create: (context) => HomePageProvider(),
          child: Consumer<HomePageProvider>(
            builder: (context, provider2, child) => Form(
                key: formkey2,
                child: provider2.loading == true
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height *
                                DimenResource.D_0_2,
                          ),
                          firstTextField(
                                  fieldenable: provider2.isenable,
                                  firstctr: firstctr)
                              .cornerRadius(
                                  BorderRadius.circular(DimenResource.D_10))
                              .padding(),
                          lastTextField(
                                  fieldenable: provider2.isenable,
                                  lastctr: lastctr)
                              .cornerRadius(
                                  BorderRadius.circular(DimenResource.D_10))
                              .padding(),
                          emailTextField(
                            fieldenable: provider2.isenable,
                            emaictr: emailctr,
                          )
                              .cornerRadius(
                                  BorderRadius.circular(DimenResource.D_10))
                              .padding(),
                          provider2.isenable == false
                              ? ElevatedButton(
                                  onPressed: () async {
                                    provider2.fieldEnabled();
                                  },
                                  child:
                                      Text(StringResources.edit_btn.captilize))
                              : ElevatedButton(
                                  onPressed: () {
                                    if (formkey2.currentState!.validate()) {
                                      provider2.fieldDisabled();
                                      provider2.update(firstctr.text,
                                          lastctr.text, emailctr.text);
                                    }
                                  },
                                  child:
                                      Text(StringResources.done_btn.captilize)),
                        ],
                      )),
          ),
        ),
      )),
    );
  }
}
