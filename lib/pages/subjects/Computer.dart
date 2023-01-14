// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class Computer extends StatefulWidget {
  const Computer({Key? key}) : super(key: key);

  @override
  State<Computer> createState() => _ComputerState();
}

class _ComputerState extends State<Computer> {
  List lists = [
    "Introduction",
    "Logic operation and basic gates",
    "Computer Organisation",
    "Problem Solving Steps",
    "Introduction to Programming "
  ];
  String type = "Introduction to Computing";
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
