// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/assignmentCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class Assignments extends StatefulWidget {
  final chapter;
  final subject;

  const Assignments({
    Key? key,
    required this.subject,
    required this.chapter,
  }) : super(key: key);

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  get chapter => widget.chapter;
  get subject => widget.subject;
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection("Subject")
          .doc("$subject")
          .collection("$chapter")
          .snapshots();

  @override
  void initState() {
    var hello = readData();
    setState(() {
      dataLoaded = hello;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: appbarName("Assignment", context),
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
                    itemBuilder: (context, index) => assignmentSet(
                          snap: snapshot.data!.docs[index].data(),
                          subject: subject,
                          chapter: chapter,
                        ));
              }

              //         notesset(title: "title", notesPDF: "jbjhvhvh"));
            },
          ),
        ));
  }
}
