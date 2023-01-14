import 'package:flutter/material.dart';
import 'package:iiest_app/components/extraSub/extraSubject.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class book extends StatefulWidget {
  const book({Key? key}) : super(key: key);

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  var lists = [
    "Mechanics",
    "Basic Electrical Engineering",
    "Chemistry",
    "Mathematics I",
    "Mathematics II",
    "English",
    "Computer Science",
    "Environment and Ecology",
    "Sociology and Professional Ethics",
    "Physics"
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbarName("Books", context),
          body: Container(
            padding: const EdgeInsets.all(2),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              for (var item in lists)
                subparts(item, context,
                    extraSubject(type: "Books", subjectName: item)),
            ]),
          )),
    );
  }
}
