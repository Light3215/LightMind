// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/components/PDFsCard/singleSetCard.dart';

class Theory extends StatefulWidget {
  final chapter;
  final subject;
  final topic;

  Theory({
    Key? key,
    required this.topic,
    required this.subject,
    required this.chapter,
  }) : super(key: key);

  @override
  State<Theory> createState() => _TheoryState();
}

class _TheoryState extends State<Theory> {
  get chapter => widget.chapter;
  get subject => widget.subject;
  get topic => widget.topic;
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection(topic)
          .doc(subject)
          .collection(chapter)
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
          appBar: appbarName(topic, context),
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
                    itemBuilder: (context, index) => singleSetCard(
                          snap: snapshot.data!.docs[index].data(),
                        ));
              }

              //         notesset(title: "title", notesPDF: "jbjhvhvh"));
            },
          ),
        ));
  }
}
