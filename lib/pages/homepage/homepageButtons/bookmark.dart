// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/assignmentCard.dart';
import 'package:iiest_app/components/PDFsCard/labCard.dart';
import 'package:iiest_app/components/PDFsCard/syllabusCard.dart';
import 'package:iiest_app/components/PDFsCard/theoryCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class bookmark extends StatefulWidget {
  const bookmark({Key? key}) : super(key: key);

  @override
  State<bookmark> createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;
  get chapter => null;
  get subject => null;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("bookmarked")
          .snapshots();

  @override
  void initState() {
    var val = readData();
    setState(() {
      dataLoaded = val;
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
                      print("hello world");
                      print(snapshot.data?.docs[index].data()["type"]);
                      print(snapshot.data?.docs[index].data()["subject"]);
                      var value = snapshot.data?.docs[index].data()["type"];
                      if (value == "assignment") {
                        return assignmentSet(
                          snap: snapshot.data?.docs[index].data(),
                          subject: snapshot.data?.docs[index].data()["subject"],
                          chapter: snapshot.data?.docs[index].data()["chapter"],
                        );
                      } else if (value == "theory") {
                        return TheorySet(
                          snap: snapshot.data?.docs[index].data(),
                          subject: snapshot.data?.docs[index].data()["subject"],
                          chapter: snapshot.data?.docs[index].data()['chapter'],
                        );
                      } else if (value == "Lab work") {
                        return labWorkSet(
                            snap: snapshot.data?.docs[index].data());
                      } else {
                        return syllabusSet(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      }
                    });
              }
            },
          ),
        ));
  }
}
