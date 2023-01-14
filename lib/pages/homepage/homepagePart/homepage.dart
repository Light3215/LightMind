// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/bookmark.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/labwork.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/settings.dart';
import 'package:iiest_app/components/homepageComp.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/syllabus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'panelwidget.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).orientation == Orientation.landscape;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // sliding section
        body: SafeArea(
          child: SlidingUpPanel(
            color: Colors.blue,
            minHeight: MediaQuery.of(context).size.height * 0.5,
            maxHeight: MediaQuery.of(context).size.height * 0.88,
            header: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.47,
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            panelBuilder: (controller) => panelwidget(controller: controller),
            //not sliding section
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/studingkid.jpg"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: const Text(
                                "IIEST App",
                                style: TextStyle(
                                  fontSize: 30,
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
                                  size: 27,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black38,
                  thickness: 1,
                  indent: 18,
                  endIndent: 18,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomepageIcons("Syllabus", Icons.notes_outlined,
                          Colors.blue, context, syllabus()),
                      HomepageIcons("Lab Work", CupertinoIcons.book_solid,
                          Colors.red, context, labWork()),
                      HomepageIcons("Bookmark", Icons.bookmark_add_outlined,
                          Colors.green, context, const bookmark()),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.53,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
