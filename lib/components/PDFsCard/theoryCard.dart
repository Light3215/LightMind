// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/utils/constants.dart';
import '../subjectcomp.dart';

class TheorySet extends StatefulWidget {
  final snap;
  final chapter;
  final subject;

  const TheorySet(
      {Key? key,
      required this.snap,
      required this.subject,
      required this.chapter});

  @override
  State<TheorySet> createState() => _TheorySetState();
}

class _TheorySetState extends State<TheorySet> {
  var likes = Icons.favorite_border;
  var bookmarks = Icons.bookmark_border;

  get snap => widget.snap;
  var username = FirebaseAuth.instance.currentUser?.uid;

  String get chapter => widget.chapter;
  String get subject => widget.subject;

  likeSystem() {
    if (snap["liked user"].contains(username)) {
      PdfData.updateUnlikes(username!, subject, chapter, snap["Pid"]);
      likes = Icons.favorite_border;
    } else {
      PdfData.updateLikes(username!, subject, chapter, snap["Pid"]);
      likes = Icons.favorite;
    }
  }

  bookmarkSystem() {
    if (snap["bookmarked user"].contains(username)) {
      bookmarks = Icons.bookmark_border;
    } else {
      bookmarks = Icons.bookmark;
    }
    PdfData.updateBookmarks(snap, username!, subject, chapter);
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
            bottom: screenheight(context) * 0.02),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1,
                  spreadRadius: 3,
                  offset: Offset(2, 3))
            ],
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber),
                child: Row(
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
                      functionbox(context, Icons.help),
                    ]),
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                GestureDetector(
                    child: Container(
                      height: screenheight(context) * 0.15,
                      width: screenwidth(context) * 0.4435 * 2,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                          color: Colors.lightBlue),
                      child: Center(child: Text(snap["theory desc"])),
                    ),
                    onTap: () {
                      openPDF(snap['theory link']);
                    }),
              ]),
            )
          ],
        ));
  }
}
