// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/assignmentPage.dart';
import 'package:iiest_app/components/PDFsCard/theoryPage.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class chapter extends StatefulWidget {
  final String chapterName;
  final String subjectName;

  chapter({Key? key, required this.chapterName, required this.subjectName})
      : super(key: key);

  @override
  State<chapter> createState() => _chapterState();
}

class _chapterState extends State<chapter> {
  get chapterName => widget.chapterName;

  get subjectName => widget.subjectName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbarName(chapterName, context),
          body: Container(
            padding: const EdgeInsets.all(2),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              subparts(
                  "Assignment",
                  context,
                  Assignments(
                    topic: "Assignment",
                    chapter: chapterName,
                    subject: subjectName,
                  )),
              subparts(
                  "Theory",
                  context,
                  Theory(
                    topic: "Theory",
                    chapter: chapterName,
                    subject: subjectName,
                  )),
            ]),
          )),
    );
  }
}
