// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/utils/constants.dart';
import '../reportComp.dart';
import '../subjectcomp.dart';

class doubleSetCard extends StatefulWidget {
  final snap;

  const doubleSetCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<doubleSetCard> createState() => _doubleSetCardState();
}

class _doubleSetCardState extends State<doubleSetCard> {
  var likes = Icons.favorite_border;
  var bookmarks = Icons.bookmark_border;

  get snap => widget.snap;
  var username = FirebaseAuth.instance.currentUser?.uid;

  likeSystem() {
    if (snap["liked user"].contains(username)) {
      likes = Icons.favorite_border;
    } else {
      likes = Icons.favorite;
    }
    PdfData.updateLikes(username!, snap);
    PdfData.updateBookmarkedLike(username!, snap);
  }

  bookmarkSystem() {
    if (snap["bookmarked user"].contains(username)) {
      bookmarks = Icons.bookmark_border;
    } else {
      bookmarks = Icons.bookmark;
    }
    PdfData.updateBookmark(snap, username!);
  }

  @override
  void initState() {
    setState(() {
      if (snap["liked user"].contains(username)) {
        likes = Icons.favorite;
      } else {
        likes = Icons.favorite_border;
      }
      if (snap["bookmarked user"].contains(username)) {
        bookmarks = Icons.bookmark;
      } else {
        bookmarks = Icons.bookmark_border;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: screenwidth(context) * 0.02,
            right: screenwidth(context) * 0.02,
            bottom: screenheight(context) * 0.01),
        margin: EdgeInsets.symmetric(
            horizontal: screenwidth(context) * 0.04,
            vertical: screenheight(context) * 0.02),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 3,
                offset: Offset(2, 3))
          ],
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.amber,
              Colors.yellowAccent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            likeSystem();
                          });
                        },
                        icon: Icon(likes, color: Colors.red)),
                    Text(
                      (snap["liked user"].length).toString() + " likes",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          bookmarkSystem();
                        });
                      },
                      icon: Icon(
                        bookmarks,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        report(context, snap, username);
                      },
                      icon: Icon(
                        Icons.report,
                        color: Colors.amber[800],
                      ))
                ]),
              ],
            ),
            Container(
              height: screenheight(context) * 0.16,
              width: screenwidth(context) * 0.90,
              decoration: BoxDecoration(
                  // boxShadow: const [
                  //   BoxShadow(
                  //       color: Colors.grey,
                  //       blurRadius: 1,
                  //       spreadRadius: 3,
                  //       offset: Offset(2, 3))
                  // ],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.purpleAccent,
                      Colors.lightBlue,
                    ],
                  )),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        child: Container(
                          width: screenwidth(context) * 0.43,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                            // color: Colors.lightBlue[400]
                          ),
                          child: Center(
                              child: Text(
                            snap["question desc"],
                            textAlign: TextAlign.center,
                          )),
                        ),
                        onTap: () {
                          openPDF(snap['question link']);
                        }),
                    GestureDetector(
                        child: Container(
                          width: screenwidth(context) * 0.43,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            // color: Colors.lightGreen[400]
                          ),
                          child: Center(
                              child: Text(
                            snap["answer desc"],
                            // style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          )),
                        ),
                        onTap: () {
                          openPDF(snap['answer link']);
                        })
                  ]),
            )
          ],
        ));
  }
}
