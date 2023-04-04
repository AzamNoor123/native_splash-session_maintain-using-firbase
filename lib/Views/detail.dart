import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/CommonKeys.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/ConstantStrings.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/Dimension.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/StringResources.dart';
import 'package:task_2_ui_ui_firebase_firestore/utills/custom_Extensions.dart';

class DetailPage extends StatelessWidget {
  const DetailPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ConstatntStrings.Detail_page.captilize),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(CommonKeys.Key_db)
                .where(CommonKeys.Key_Field_userid,
                    isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? 1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(StringResources.error_msg.captilize);
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                          Text(
                            'First Name:${snapshot.data!.docs[index]['First']}',
                            style:
                                const TextStyle(fontSize: DimenResource.D_20),
                          ),
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                          Text(
                            "LAst Name:${snapshot.data!.docs[index]['Last']}",
                            style:
                                const TextStyle(fontSize: DimenResource.D_20),
                          ),
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                          Text(
                            "Email:${snapshot.data!.docs[index]["Email"]}",
                            style:
                                const TextStyle(fontSize: DimenResource.D_20),
                          ),
                          const SizedBox(
                            height: DimenResource.D_20,
                          ),
                        ],
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }
}
