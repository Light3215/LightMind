import 'package:flutter/material.dart';
import 'package:iiest_app/components/homepageComp.dart';
import 'package:iiest_app/pages/subjects/Mechanics/Mechanics.dart';
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
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02,
          top: MediaQuery.of(context).size.width * 0.07,
          bottom: MediaQuery.of(context).size.width * 0.03),
      child: GridView(
        physics: const BouncingScrollPhysics(),
        controller: widget.controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          Cards("BEE", "assets/SubjectImages/BEE.jpeg", context, Mechanics()),
          // Cards("Chemistry", "assets/SubjectImages/Chemistry.jpeg", context,
          //     Mechanics()),
          // Cards("Computer Science", "assets/SubjectImages/Computer.jpeg",
          //     context, Mechanics()),
          // Cards("English", "assets/SubjectImages/English.jpg", context,
          //     Mechanics()),
          // Cards("EVS and Ecology ", "assets/SubjectImages/Environment.jpeg",
          //     context, Mechanics()),
          // Cards("Mathematics I", "assets/SubjectImages/maths1.jpg", context,
          //     Mechanics()),
          // Cards("Mathematics II", "assets/SubjectImages/maths2.jpg", context,
          //     Mechanics()),
          // Cards("Mechanics", "assets/SubjectImages/Mechanics.jpeg", context,
          //     Mechanics()),
          // Cards("Physics", "assets/SubjectImages/PhysicsImage.jpg", context,
          //     Mechanics()),
          // Cards("Sociology and Ethics", "assets/SubjectImages/Sociology.jpeg",
          //     context, Mechanics()),
        ],
      ),
    );
  }
}
