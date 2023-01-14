import 'package:flutter/material.dart';
import 'package:iiest_app/components/PDFsCard/assignmentCard.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class theory extends StatefulWidget {
  final lists;

  const theory({Key? key, required this.lists}) : super(key: key);

  @override
  State<theory> createState() => _theoryState();
}

class _theoryState extends State<theory> {
  get lists => widget.lists;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: appbarName("Theory", context),
          body: Container(
            child: ListView(
              shrinkWrap: true,
              children: lists,
            ),
          )),
    );
  }
}
