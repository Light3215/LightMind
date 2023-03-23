// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class BEE extends StatefulWidget {
  const BEE({Key? key}) : super(key: key);

  @override
  State<BEE> createState() => _BEEState();
}

class _BEEState extends State<BEE> {
  List lists = [
    "D.C. Circuits",
    "Magnetic Circuits",
    "A.C. Fundamentals",
    "A.C. Circuits",
    "Transformers",
    "D.C. Machines",
    "Induction Motor",
    "Measuring Instruments",
    "Distribution of Electricity",
  ];
  String type = "Basic Electrical Engineering";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbarName(type, context),
          body: Container(
            padding: const EdgeInsets.all(2),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              for (var item in lists)
                subparts(
                    item,
                    context,
                    chapter(
                      chapterName: item,
                      subjectName: type,
                    )),
            ]),
          )),
    );
  }
}
