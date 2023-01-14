// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class Mathematics2 extends StatefulWidget {
  const Mathematics2({Key? key}) : super(key: key);

  @override
  State<Mathematics2> createState() => _Mathematics2State();
}

class _Mathematics2State extends State<Mathematics2> {
  List lists = [
    "Vector Spaces and Linear \nTransformation",
    "Matrices",
    "Vector",
    "Fourier Series",
    "Complex Variables"
  ];
  String type = "Mathematics II";
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
