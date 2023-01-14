import 'package:flutter/material.dart';
import 'package:iiest_app/components/homepageComp.dart';
import 'package:iiest_app/pages/subjects/BEE.dart';
import 'package:iiest_app/pages/subjects/Chemistry.dart';
import 'package:iiest_app/pages/subjects/Computer.dart';
import 'package:iiest_app/pages/subjects/EVS.dart';
import 'package:iiest_app/pages/subjects/Mathematics1.dart';
import 'package:iiest_app/pages/subjects/Mathematics2.dart';
import 'package:iiest_app/pages/subjects/Physics.dart';
import 'package:iiest_app/pages/subjects/Mechanics.dart';
import 'package:iiest_app/utils/constants.dart';
// import 'package:iiest_app/pages/subjects/maths1/maths1.dart';
// import 'package:iiest_app/pages/subjects/Mechanics/Mechanics.dart';

class panelwidget extends StatefulWidget {
  final ScrollController controller;
  const panelwidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<panelwidget> createState() => _panelwidgetState();
}

class _panelwidgetState extends State<panelwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: screenwidth(context) * 0.02,
          right: screenwidth(context) * 0.02,
          top: screenwidth(context) * 0.07,
          bottom: screenwidth(context) * 0.03),
      child: GridView(
        physics: const BouncingScrollPhysics(),
        controller: widget.controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          Cards("Mechanics", "assets/SubjectImages/Mechanics.jpeg", context,
              const Mechanics()),
          Cards("BEE", "assets/SubjectImages/BEE.jpeg", context, const BEE()),
          Cards("Chemistry", "assets/SubjectImages/Chemistry.jpeg", context,
              const Chemistry()),
          Cards("Computer Science", "assets/SubjectImages/Computer.jpeg",
              context, const Computer()),
          //have to find resources of english
          // Cards("English", "assets/SubjectImages/English.jpg", context,
          // Mechanics()),
          Cards("EVS and Ecology ", "assets/SubjectImages/Environment.jpeg",
              context, const EVS()),
          Cards("Mathematics I", "assets/SubjectImages/maths1.jpg", context,
              const Mathematics1()),
          Cards("Mathematics II", "assets/SubjectImages/maths2.jpg", context,
              const Mathematics2()),
          Cards("Physics", "assets/SubjectImages/PhysicsImage.jpg", context,
              const Physics()),
          //have to find resources of sociology and ethics
          // Cards("Sociology and Ethics", "assets/SubjectImages/Sociology.jpeg",
          //     context, Mechanics()),
        ],
      ),
    );
  }
}
