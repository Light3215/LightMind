// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/doubleSetCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/utils/constants.dart';

class Assignments extends StatefulWidget {
  final chapter;
  final subject;
  final topic;
  const Assignments({
    Key? key,
    required this.subject,
    required this.topic,
    required this.chapter,
  }) : super(key: key);

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  get chapter => widget.chapter;
  get subject => widget.subject;
  get topic => widget.topic;
  late Stream<QuerySnapshot<Map<String, dynamic>>> dataLoaded;
  Stream<QuerySnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection(topic)
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
          backgroundColor: Colors.white,
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
                  child: Text("Something went wrong"),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: screenheight(context) * 0.5,
                            child: Image.asset("assets/NothingHere.avif")),
                        Container(
                          child: const Text(
                            "Nothing here",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenheight(context) * 0.1,
                    )
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) => doubleSetCard(
                          snap: snapshot.data!.docs[index].data(),
                        ));
              }
            },
          ),
        ));
  }
}
