// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/book.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/bookmark.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/extra.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/labwork.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/setting/settings.dart';
import 'package:iiest_app/components/homepageComp.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/syllabus.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/test.dart';
import 'package:iiest_app/utils/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../homepageButtons/PYQ.dart';
import 'panelwidget.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  /*
  // var names = " ";
  @override
  // void initState() {
  //   // getProfileData();
  //   super.initState();
  //

  // String getusername(String s) {
  //   return names = s;
  // }

  // void getProfileData() {
  //   var value = "";
  //   var docRef = FirebaseFirestore.instance
  //       .collection("user")
  //       .doc(FirebaseAuth.instance.currentUser?.uid);
  //   docRef.get().then(
  //     (DocumentSnapshot doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       print(data["Username"]);
  //       getusername(data["Username"]);
  //     },
  //     onError: (e) => value = "Error getting document: $e",
  //   );
  // }
*/
  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).orientation == Orientation.landscape;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppbarHomeScreen("Lightmind", context),
        // sliding section
        body: SafeArea(
          child: SlidingUpPanel(
            // color: Colors.blue,
            color: Colors.lightBlue.shade600,
            minHeight: screenheight(context) * 0.37,
            maxHeight: screenheight(context) * 0.89,
            header: Padding(
              padding: EdgeInsets.only(
                left: screenwidth(context) * 0.47,
              ),
              child: const Icon(
                Icons.menu,
                // color: Colors.black,
              ),
            ),
            // borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            panelBuilder: (controller) => panelwidget(controller: controller),
            //not sliding section
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          // homepage-image-bg-color
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("assets/studingkid.jpg"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Divider(
                    // color: Colors.white,
                    thickness: 1,
                    indent: 18,
                    endIndent: 18,
                  ),
                ),
                Container(
                  color: Colors.white,
                  //homepage-icon-bgColor
                  // decoration: const BoxDecoration(color: Colors.black),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenwidth(context) * 0.05,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomepageIcons("Syllabus", Icons.book, Colors.blue,
                              context, const Syllabus()),
                          HomepageIcons(
                              "Lab Work",
                              CupertinoIcons.lab_flask_solid,
                              Colors.red,
                              context,
                              const Labwork()),
                          HomepageIcons("PYQs", Icons.note_alt_sharp,
                              Colors.amber, context, const PYQs()),
                          HomepageIcons("Bookmark", Icons.bookmark_add_outlined,
                              Colors.green, context, const bookmark()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomepageIcons("Extra", Icons.notes_outlined,
                              Colors.deepPurple[400], context, const extra()),
                          HomepageIcons("Books", CupertinoIcons.book_solid,
                              Colors.orange[600], context, const book()),
                          HomepageIcons("Tests", Icons.edit_note_sharp,
                              Colors.teal[400], context, const Tests()),
                          SizedBox(
                            width: screenwidth(context) * 0.16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // homepage-behindPanelwidget-BgColor
                Container(
                  // color: Colors.black,
                  height: screenheight(context) * 0.48,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
