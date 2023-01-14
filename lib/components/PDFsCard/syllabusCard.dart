// ignore_for_file: file_names, camel_case_types, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/utils/constants.dart';
import '../subjectcomp.dart';

class syllabusSet extends StatefulWidget {
  final snap;

  // ignore: use_key_in_widget_constructors
  const syllabusSet({
    Key? key,
    required this.snap,
  });

  @override
  State<syllabusSet> createState() => _syllabusSetState();
}

class _syllabusSetState extends State<syllabusSet> {
  var likes = Icons.favorite_border;
  var bookmarks = Icons.bookmark_border;

  get snap => widget.snap;
  var username = FirebaseAuth.instance.currentUser?.uid;

  likeSystem() {
    if (snap["liked user"].contains(username)) {
      PdfData.updateUnlike(username!, "Syllabus", snap["Pid"]);
      likes = Icons.favorite_border;
    } else {
      PdfData.updateLike(username!, "Syllabus", snap["Pid"]);
      likes = Icons.favorite;
    }
  }

  bookmarkSystem() {
    if (snap["bookmarked user"].contains(username)) {
      bookmarks = Icons.bookmark_border;
    } else {
      bookmarks = Icons.bookmark;
    }
    PdfData.extraUpdateBookmark(snap, username!, "Syllabus");
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
                            bottomLeft: Radius.circular(10.0),
                          ),
                          color: Colors.lightBlue),
                      child: Center(child: Text(snap["desc"])),
                    ),
                    onTap: () {
                      openPDF(snap['link']);
                    }),
              ]),
            )
          ],
        ));
  }
}
