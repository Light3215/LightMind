import 'package:flutter/material.dart';
import 'package:iiest_app/components/extraSub/extraSubject.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class PYQs extends StatefulWidget {
  const PYQs({Key? key}) : super(key: key);

  @override
  State<PYQs> createState() => _PYQsState();
}

class _PYQsState extends State<PYQs> {
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
          appBar: appbarName("Previous year question", context),
          body: Container(
            padding: const EdgeInsets.all(2),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              for (var item in lists)
                subparts(item, context,
                    extraSubject(type: "PYQs", subjectName: item)),
            ]),
          )),
    );
  }
}
