// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../homepageButtons/PYQs.dart';
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
        // sliding section
        body: SafeArea(
          child: SlidingUpPanel(
            // color: Colors.blue,
            color: Colors.blue,
            minHeight: screenheight(context) * 0.43,
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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                      Padding(
                        padding: EdgeInsets.all(screenwidth(context) * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  // vertical: screenheight(context) * 0.04,
                                  horizontal: screenwidth(context) * 0.03),
                              child: const Text(
                                "LightMind",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "kalam",
                                  //text-color
                                  // color: Colors.amber
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const settings()),
                                  );
                                },
                                icon: const Icon(
                                  Icons.settings,
                                  //setting-icon-color
                                  // color: Colors.amber,
                                  size: 27,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  // color: Colors.black,
                  child: const Divider(
                    // color: Colors.white,
                    thickness: 1,
                    indent: 18,
                    endIndent: 18,
                  ),
                ),
                Container(
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
                          const SizedBox(
                            width: 60,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // homepage-behindPanelwidget-BgColor
                Container(
                  // color: Colors.black,
                  height: screenheight(context) * 0.47,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
