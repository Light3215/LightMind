// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class EVS extends StatefulWidget {
  const EVS({Key? key}) : super(key: key);

  @override
  State<EVS> createState() => _EVSState();
}

class _EVSState extends State<EVS> {
  List lists = [
    "Introduction",
    "Ecology",
    "Water Pollution",
    "Air Pollution",
    "Solid Waste Management",
    "Noise Pollution",
    "Environmental Issues"
  ];
  String type = "Environment and Ecology";
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
