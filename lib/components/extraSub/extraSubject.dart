// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/singleSetCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/utils/constants.dart';
import '../PDFsCard/doubleSetCard.dart';

class extraSubject extends StatefulWidget {
  final String type;
  final String subjectName;

  const extraSubject({Key? key, required this.type, required this.subjectName})
      : super(key: key);

  @override
  State<extraSubject> createState() => _extraSubjectState();
}

class _extraSubjectState extends State<extraSubject> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;

  String? get type => widget.type;

  String get subjectName => widget.subjectName;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection("Extra")
          .doc(type)
          .collection(subjectName)
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
          appBar: appbarName(type, context),
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // print("hello world");
                      // print(snapshot.data?.docs[index].data()["type"]);
                      // print(snapshot.data?.docs[index].data()["subject"]);
                      var value = snapshot.data?.docs[index].data()["type"];
                      if (value == "Lab work") {
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
                      } else if (value == "Tests") {
                        return singleSetCard(
                          snap: snapshot.data?.docs[index].data(),
                        );
                      } else {
                        return Container(
                            height: screenheight(context) * 0.07,
                            child: const Center(
                                child: Text("Error!! Unable to load pdf")));
                      }
                    });
              }
            },
          ),
        ));
  }
}
