import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/provider/home_provider.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/strings_extension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/helper/widgets_extensions.dart';
import '../utills/constants_resource.dart';
import '../utills/custom_widgets/custom_text_field.dart';
import '../utills/custom_widgets/menuButtonWidget.dart';

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
        actions: [menuButton()],
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
                          CustomTextField(
                            controller: firstctr,
                            fieldenable: provider2.isenable,
                            hint: StringResources.hint_first,
                            name: StringResources.l_first,
                            validator: (p0) {
                              if (p0 == 0 || p0!.isEmpty) {
                                return StringResources.hint_first;
                              }
                            },
                          )
                              .cornerRadius(
                                  BorderRadius.circular(DimenResource.D_10))
                              .padding(),
                          CustomTextField(
                            controller: lastctr,
                            fieldenable: provider2.isenable,
                            hint: StringResources.hint_last,
                            name: StringResources.l_last,
                            validator: (p0) {
                              if (p0 == 0 || p0!.isEmpty) {
                                return StringResources.hint_last;
                              }
                            },
                          )
                              .cornerRadius(
                                  BorderRadius.circular(DimenResource.D_10))
                              .padding(),
                          CustomTextField(
                                  controller: emailctr,
                                  hint: StringResources.hint_email,
                                  name: StringResources.l_email,
                                  fieldenable: provider2.isenable,
                                  validator: (value) {
                                    if (value == 0 || value!.isEmpty) {
                                      return StringResources
                                          .hint_email.captilize;
                                    } else if (!value.isValidEmail()) {
                                      return StringResources.enter_valid_email;
                                    }
                                  })
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
                                    if (formkey2.currentState?.validate() ??
                                        false) {
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
