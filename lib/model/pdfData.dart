// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class PdfData {
  final String Pid;
  final String quesLink;
  final String ansLink;
  final String quesDesc;
  final String ansDesc;
  final List Buser;
  final List Luser;
  final String type;

  // static fred = FirebaseFirestore.instance.collection("Suject");

  PdfData({
    required this.Buser,
    required this.Luser,
    required this.Pid,
    required this.ansDesc,
    required this.ansLink,
    required this.quesDesc,
    required this.quesLink,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'Pid': Pid,
        'answer desc': ansDesc,
        'answer link': ansLink,
        'bookmarked user': Buser,
        'liked user': Luser,
        'question desc': quesDesc,
        'question link': quesLink,
        'type': type,
      };

  static PdfData fromSnap(DocumentSnapshot snap) {
    var json = snap.data() as Map<String, dynamic>;
    return PdfData(
        Pid: json['Pid'],
        Buser: json['bookmarked users'],
        Luser: json['likes users'],
        ansDesc: json['answer desc'],
        ansLink: json['answer link'],
        quesDesc: json['question desc'],
        quesLink: json['question link'],
        type: json['type']);
  }

  static updateLikes(
      String username, String subject, String chapter, String Pid) async {
    await FirebaseFirestore.instance
        .collection("Subject")
        .doc(subject)
        .collection(chapter)
        .doc(Pid)
        .update({
      "liked user": FieldValue.arrayUnion([username])
    });
  }

  static updateUnlikes(
      String username, String subject, String chapter, String Pid) async {
    await FirebaseFirestore.instance
        .collection("Subject")
        .doc(subject)
        .collection(chapter)
        .doc(Pid)
        .update({
      "liked user": FieldValue.arrayRemove([username])
    });
  }

  static updateBookmarks(
      snap, String username, String subject, String chapter) async {
    if (snap["bookmarked user"].contains(username)) {
      await FirebaseFirestore.instance
          .collection("Subject")
          .doc(subject)
          .collection(chapter)
          .doc(snap["Pid"])
          .update({
        "bookmarked user": FieldValue.arrayRemove([username])
      });
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("bookmarked")
          .doc(snap["Pid"])
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection("Subject")
          .doc(subject)
          .collection(chapter)
          .doc(snap["Pid"])
          .update({
        "bookmarked user": FieldValue.arrayUnion([username])
      });
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("bookmarked")
          .doc(snap["Pid"])
          .set({
        'Pid': snap["Pid"],
        'answer desc': snap["answer desc"],
        'answer link': snap["answer link"],
        'bookmarked user': snap["bookmarked user"],
        'liked user': snap["liked user"],
        'question desc': snap["question desc"],
        'question link': snap["question link"],
        'theory link': snap["theory link"],
        'theory desc': snap["theory desc"],
        'type': snap["type"],
      });
    }
  }

  static updateLike(String username, String topic, String Pid) async {
    await FirebaseFirestore.instance.collection(topic).doc(Pid).update({
      "liked user": FieldValue.arrayUnion([username])
    });
  }

  static updateUnlike(String username, String topic, String Pid) async {
    await FirebaseFirestore.instance.collection(topic).doc(Pid).update({
      "liked user": FieldValue.arrayRemove([username])
    });
  }

  static extraUpdateBookmark(snap, String username, String topic) async {
    if (snap["bookmarked user"].contains(username)) {
      await FirebaseFirestore.instance
          .collection(topic)
          .doc(snap["Pid"])
          .update({
        "bookmarked user": FieldValue.arrayRemove([username])
      });
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("bookmarked")
          .doc(snap["Pid"])
          .delete();
    } else {
      await FirebaseFirestore.instance
          .collection(topic)
          .doc(snap["Pid"])
          .update({
        "bookmarked user": FieldValue.arrayUnion([username])
      });
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("bookmarked")
          .doc(snap["Pid"])
          .set({
        'Pid': snap["Pid"],
        'bookmarked user': snap["bookmarked user"],
        'liked user': snap["liked user"],
        'desc': snap["desc"],
        'link': snap["link"],
        'type': snap["type"]
      });
    }
  }
}
