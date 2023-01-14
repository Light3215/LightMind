import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/syllabusCard.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/components/PDFsCard/assignmentCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/components/PDFsCard/TheoryCard.dart';

class syllabus extends StatefulWidget {
  syllabus({
    Key? key,
  }) : super(key: key);

  @override
  State<syllabus> createState() => _syllabusState();
}

class _syllabusState extends State<syllabus> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance.collection("Syllabus").snapshots();

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
          appBar: appbarName("Syllabus", context),
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
                    itemBuilder: (context, index) => syllabusSet(
                          snap: snapshot.data!.docs[index].data(),
                        ));
              }

              //         notesset(title: "title", notesPDF: "jbjhvhvh"));
            },
          ),
        ));
  }
}
