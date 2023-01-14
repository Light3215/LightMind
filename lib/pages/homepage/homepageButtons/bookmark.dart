// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/doubleSetCard.dart';
import 'package:iiest_app/components/PDFsCard/singleSetCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class bookmark extends StatefulWidget {
  const bookmark({Key? key}) : super(key: key);

  @override
  State<bookmark> createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("bookmarked")
          .snapshots();

  @override
  void initState() {
    var val1 = readData();

    setState(() {
      dataLoaded = val1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: appbarName("Bookmark", context),
          body: StreamBuilder(
            stream: dataLoaded,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text(" something went wrong"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      // print("hello world");
                      // print(snapshot.data?.docs[index].data()["type"]);
                      // print(snapshot.data?.docs[index].data()["subject"]);
                      var value = snapshot.data?.docs[index].data()["type"];
                      if (value == "Assignment") {
                        return doubleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else if (value == "Theory") {
                        return singleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else if (value == "Lab work") {
                        return doubleSetCard(
                            snap: snapshot.data?.docs[index].data());
                      } else if (value == "Syllabus") {
                        return singleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else if (value == "PYQ") {
                        return singleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else if (value == "Books") {
                        return singleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else if (value == "Extra") {
                        return singleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ),
        ));
  }
}
