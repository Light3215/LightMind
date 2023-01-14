// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class Mechanics extends StatefulWidget {
  const Mechanics({Key? key}) : super(key: key);

  @override
  State<Mechanics> createState() => _MechanicsState();
}

class _MechanicsState extends State<Mechanics> {
  List lists = [
    "Equilibrium",
    "Friction",
    "Structure: Truss And Frames",
    "Distributed Forces System ",
    "Kinematics of Particle",
    "Kinetics of Particle",
  ];
  String type = "Mechanics";
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
