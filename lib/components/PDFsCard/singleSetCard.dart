// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/reportComp.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/utils/constants.dart';
import '../subjectcomp.dart';

class singleSetCard extends StatefulWidget {
  final snap;

  const singleSetCard({
    Key? key,
    required this.snap,
  });

  @override
  State<singleSetCard> createState() => _singleSetCardState();
}

class _singleSetCardState extends State<singleSetCard> {
  var likes = Icons.star_border;
  var bookmarks = Icons.bookmark_border;

  get snap => widget.snap;
  var username = FirebaseAuth.instance.currentUser?.uid;

  likeSystem() {
    if (snap["liked user"].contains(username)) {
      likes = Icons.star_border;
    } else {
      likes = Icons.star;
    }
    PdfData.updateLikes(username!, snap);
    if (snap["bookmarked user"].contains(username)) {
      PdfData.updateBookmarkedLike(username!, snap);
    }
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
        likes = Icons.star;
      } else {
        likes = Icons.star_border;
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
            vertical: screenheight(context) * 0.013),
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
              Colors.yellow,
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
                      (snap["liked user"].length).toString() + " Stars",
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
              height: screenheight(context) * 0.135,
              width: screenwidth(context) * 0.90,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue,
                      Colors.lightBlue,
                    ],
                  ),
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lightBlue),
              child: GestureDetector(
                  child: Center(
                      child: Text(
                    snap["desc"],
                    textAlign: TextAlign.center,
                  )),
                  onTap: () {
                    openPDF(snap['link']);
                  }),
            )
          ],
        ));
  }
}






























        /*
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber[400]),
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
                )),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                GestureDetector(
                    child: Container(
                      height: screenheight(context) * 0.13,
                      width: screenwidth(context) * 0.85,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.lightBlue[400]),
                      child: Center(child: Text(snap["desc"])),
                    ),
                    onTap: () {
                      openPDF(snap['link']);
                    }),
              ]),
            )
          ],
        )*/ 