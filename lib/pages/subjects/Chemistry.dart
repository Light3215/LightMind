// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/subjects/Chapter/chapter.dart';

class Chemistry extends StatefulWidget {
  const Chemistry({Key? key}) : super(key: key);

  @override
  State<Chemistry> createState() => _ChemistryState();
}

class _ChemistryState extends State<Chemistry> {
  List lists = [
    "Structure and Reactivity of \nOrganic Molecules",
    "Polymeric Materials",
    "Spectroscopic Techniques in \nChemistry",
    "Chemical Bonding",
    "Coordination and Bioinorganic \nChemistry",
    "Electrochemistry",
    "The Phase Rule",
    "Rate Theory and Chemical \nDynamics"
  ];
  String type = "Chemistry";
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
