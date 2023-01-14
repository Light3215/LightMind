import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/theoryLogic.dart';
import 'package:iiest_app/components/PDFsCard/assignmentCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/components/PDFsCard/theoryCard.dart';
// import 'package:iiest_app/components/Theory.dart';
import 'package:iiest_app/components/PDFsCard/assignmentLogic.dart';

import '../../loginpage/components/Theory.dart';

class Equilibrium extends StatefulWidget {
  const Equilibrium({Key? key}) : super(key: key);

  @override
  State<Equilibrium> createState() => _EquilibriumState();
}

class _EquilibriumState extends State<Equilibrium> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appbarName("Equilibrium", context),
          body: Container(
            padding: EdgeInsets.all(2),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              Subparts(
                  "Assignment",
                  context,
                  Assignments(
                    chapter: "EquilibriumA",
                    subject: "Mechanics",
                  )),
              Subparts(
                  "Theory",
                  context,
                  Theory(
                    chapter: "EquilibriumT",
                    subject: "Mechanics",
                  )),
            ]),
          )),
    );
  }
}
