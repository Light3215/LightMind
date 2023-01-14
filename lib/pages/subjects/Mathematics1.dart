// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class Mathematics1 extends StatefulWidget {
  const Mathematics1({Key? key}) : super(key: key);

  @override
  State<Mathematics1> createState() => _Mathematics1State();
}

class _Mathematics1State extends State<Mathematics1> {
  List lists = [
    "Functions of Single Real Variable",
    "Functions of Several Real \nVariables",
    "Infinite Series",
    "Multiple Integrals",
    "Improper Integrals",
    "Ordinary Differential Equations"
  ];
  String type = "Mathematics I";
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
