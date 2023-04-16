import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/utils/constants.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: appbarName("About us", context),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextCage(
                      context,
                      "From the Founders Desk",
                      "Hi, I'm Kumar Abhigyandeep, from the Department of Electronics and Telecommunication Engineering. Even though our seniors had made all of the study material available, the idea occurred to me that a well-organized, methodical order was still needed. Despite the amount of material accessible, it was so poorly organised. Seniors have kept up with their drive was really effective, but there were no other alternatives accessible to us. We were forced to utilise whatever was on the drive and were never able to choose which senior maintains the most up-to-date notes on the subject that we may have discovered. Faced with all of this, I made the decision to take the initiative and release an app so that they will not face the problem we faced in first year.",
                      Colors.white,
                      Colors.blue,
                      Colors.black),
                  TextCage(
                      context,
                      "Why LightMind",
                      "Lightmind makes available an ecosystem of notes, lab experiments, assignments, questions from prior years, class quizzes, and books, for first year and of all deptartments, belonging to many seniors, that were previously available but disorganised. We tried to provide study materials in the best way possible, subject-wise and chapter-wise. Each card has many features, such as star, bookmark, and report, to make it easy to find the best material and eliminate the bad ones all, and that control has been given to the students to choose the best material out of all. We brought all the study materials in an organisedand systematic manner so that it will be convenient enough for the students to get whatever they are finding.",
                      Colors.blue,
                      Colors.amber,
                      Colors.white),
                  TextCage(
                      context,
                      "Our mission",
                      "Lightmind desires to continue on serving first-year students from all departments by providing this service and keeping it up-to-date so that they experience no issues by using app. There is no intention of making a profit from this application neither now nor in future, everything provided here is free. We also intend to expand to second-year students in the near future. Until then, stay updated and strive effectively in your academics.",
                      Colors.black87,
                      Colors.blue,
                      Colors.amber),
                  TextCage(
                      context,
                      "Contributer",
                      "Aadipto basak - Data manager - VIIT Velore",
                      Colors.white,
                      Colors.amber,
                      Colors.black)
                ],
              ),
            ),
          )),
    );
  }
}

Container TextCage(context, title, body, colorCode, colorTitle, colorBody) {
  return Container(
    padding: EdgeInsets.all(10),
    color: colorCode, //
    child: Row(
      children: [
        Container(
          width: screenwidth(context) * 0.3,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              color: colorTitle,
            ),
          ),
        ),
        Container(
          width: screenwidth(context) * 0.63,
          child: Text(
            body,
            style: TextStyle(
              fontSize: 18,
              color: colorBody,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
  );
}
