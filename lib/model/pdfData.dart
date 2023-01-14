// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PdfData {
  final String Pid;
  final String quesLink;
  final String ansLink;
  final String quesDesc;
  final String ansDesc;
  final List Buser;
  final List Luser;
  final String subject;
  final String chapter;
  final String type;
  final Map report;

  PdfData(
      {required this.Buser,
      required this.Luser,
      required this.Pid,
      required this.ansDesc,
      required this.ansLink,
      required this.quesDesc,
      required this.quesLink,
      required this.chapter,
      required this.subject,
      required this.report,
      required this.type});

  Map<String, dynamic> toJson() => {
        'Pid': Pid,
        'answer desc': ansDesc,
        'answer link': ansLink,
        'bookmarked user': Buser,
        'liked user': Luser,
        'question desc': quesDesc,
        'question link': quesLink,
        'type': type,
        'report': report
      };

  static PdfData fromSnap(DocumentSnapshot snap) {
    var json = snap.data() as Map<String, dynamic>;
    return PdfData(
        Pid: json['Pid'],
        Buser: json['bookmarked user'],
        Luser: json['liked user'],
        ansDesc: json['answer desc'],
        ansLink: json['answer link'],
        quesDesc: json['question desc'],
        quesLink: json['question link'],
        chapter: json['chapter'],
        subject: json['subject'],
        type: json['type'],
        report: json['report']);
  }

  static var currUser = FirebaseAuth.instance.currentUser?.uid;
  static var currEmail = FirebaseAuth.instance.currentUser?.email;
  static var con;
  static docExist(snap, username) async {
    try {
      await FirebaseFirestore.instance
          .collection("report")
          .doc(snap["Pid"])
          .get()
          .then((doc) {
        con = doc.exists;
      });
      await FirebaseFirestore.instance
          .collection("user")
          .doc(username)
          .collection("report")
          .doc(snap["Pid"])
          .get()
          .then((doc) {
        con = doc.exists;
      });

      return con;
    } catch (e) {
      return false;
    }
  }

// control likes
  static updateLikes(String username, snap) async {
    if (snap["type"].toString() == "Assignment" ||
        snap["type"].toString() == "Theory") {
      if (snap["liked user"].contains(username)) {
        await FirebaseFirestore.instance
            .collection(snap["type"])
            .doc(snap["subject"])
            .collection(snap["chapter"])
            .doc(snap["Pid"])
            .update({
          "liked user": FieldValue.arrayRemove([username])
        });
      } else {
        await FirebaseFirestore.instance
            .collection(snap["type"])
            .doc(snap["subject"])
            .collection(snap["chapter"])
            .doc(snap["Pid"])
            .update({
          "liked user": FieldValue.arrayUnion([username])
        });
      }
    } else {
      if (snap["liked user"].contains(username)) {
        await FirebaseFirestore.instance
            .collection("Extra")
            .doc(snap["type"])
            .collection(snap["subject"])
            .doc(snap["Pid"])
            .update({
          "liked user": FieldValue.arrayRemove([username])
        });
      } else {
        await FirebaseFirestore.instance
            .collection("Extra")
            .doc(snap["type"])
            .collection(snap["subject"])
            .doc(snap["Pid"])
            .update({
          "liked user": FieldValue.arrayUnion([username])
        });
      }
    }
  }

// control bookmarked list
  static updateBookmark(snap, String username) async {
    //Assignment
    if (snap["type"].toString() == "Assignment") {
      if (snap["bookmarked user"].contains(username)) {
        await FirebaseFirestore.instance
            .collection(snap["type"])
            .doc(snap["subject"])
            .collection(snap["chapter"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayRemove([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection(snap["type"])
            .doc(snap["subject"])
            .collection(snap["chapter"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayUnion([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .set({
          'Pid': snap["Pid"],
          'answer desc': snap["answer desc"],
          'answer link': snap["answer link"],
          "bookmarked user": FieldValue.arrayUnion([username]),
          'chapter': snap["chapter"],
          'liked user': snap["liked user"],
          'question desc': snap["question desc"],
          'question link': snap["question link"],
          'subject': snap["subject"],
          'type': snap["type"],
        });
      }
      // Theory
    } else if (snap["type"].toString() == "Theory") {
      if (snap["bookmarked user"].contains(username)) {
        await FirebaseFirestore.instance
            .collection(snap["type"])
            .doc(snap["subject"])
            .collection(snap["chapter"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayRemove([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection(snap["type"])
            .doc(snap["subject"])
            .collection(snap["chapter"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayUnion([username])
        });

        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .set({
          'Pid': snap["Pid"],
          "bookmarked user": FieldValue.arrayUnion([username]),
          'liked user': snap["liked user"],
          'subject': snap["subject"],
          'chapter': snap["chapter"],
          'desc': snap["desc"],
          'link': snap["link"],
          'type': snap["type"],
        });
      }
    } else if (snap["type"].toString() == "Lab work") {
      if (snap["bookmarked user"].contains(username)) {
        await FirebaseFirestore.instance
            .collection("Extra")
            .doc(snap["type"])
            .collection(snap["subject"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayRemove([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .delete();
      } else {
        await FirebaseFirestore.instance
            .collection("Extra")
            .doc(snap["type"])
            .collection(snap["subject"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayUnion([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .set({
          'Pid': snap["Pid"],
          'answer desc': snap["answer desc"],
          'answer link': snap["answer link"],
          "bookmarked user": FieldValue.arrayUnion([username]),
          'liked user': snap["liked user"],
          'question desc': snap["question desc"],
          'question link': snap["question link"],
          'subject': snap["subject"],
          'type': snap["type"],
        });
      }
    } else {
      if (snap["bookmarked user"].contains(username)) {
        await FirebaseFirestore.instance
            .collection("Extra")
            .doc(snap["type"])
            .collection(snap["subject"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayRemove([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .delete();
      } else {
        // add user to  "bookmarked user" list
        await FirebaseFirestore.instance
            .collection("Extra")
            .doc(snap["type"])
            .collection(snap["subject"])
            .doc(snap["Pid"])
            .update({
          "bookmarked user": FieldValue.arrayUnion([username])
        });
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currUser)
            .collection("bookmarked")
            .doc(snap["Pid"])
            .set({
          'Pid': snap["Pid"],
          "bookmarked user": FieldValue.arrayUnion([username]),
          'liked user': snap["liked user"],
          'subject': snap["subject"],
          'desc': snap["desc"],
          'link': snap["link"],
          'type': snap["type"],
        });
      }
    }
  }

// updating the like for bookmarked collection list
  static updateBookmarkedLike(username, snap) async {
    // for un-like
    if (snap['liked user'].contains(username)) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(currUser)
          .collection("bookmarked")
          .doc(snap["Pid"])
          .update({
        "liked user": FieldValue.arrayRemove([username])
      });
      //for like
    } else {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(currUser)
          .collection("bookmarked")
          .doc(snap["Pid"])
          .update({
        "liked user": FieldValue.arrayUnion([username])
      });
    }
  }

  // to get the report from the user regarding any pdf
  static reportPDF(snap, username, rep) async {
    final Map reportMap = snap["report"];
    reportMap[username] = rep;
    if (snap["type"] == "Theory" || snap["type"] == "Assignment") {
      await FirebaseFirestore.instance
          .collection(snap["type"])
          .doc(snap["subject"])
          .collection(snap["chapter"])
          .doc(snap["Pid"])
          .update({'report': reportMap});
    } else {
      await FirebaseFirestore.instance
          .collection("Extra")
          .doc(snap["type"])
          .collection(snap["subject"])
          .doc(snap["Pid"])
          .update({'report': reportMap});
    }

    if (await docExist(snap, username)) {
      await FirebaseFirestore.instance
          .collection("report")
          .doc(snap["Pid"])
          .update({"report": reportMap});
      await FirebaseFirestore.instance
          .collection("user")
          .doc(username)
          .collection("report")
          .doc(snap["Pid"])
          .update({
        "report": FieldValue.arrayUnion([rep])
      });
    } else {
      await FirebaseFirestore.instance
          .collection("report")
          .doc(snap["Pid"])
          .set({
        'Pid': snap["Pid"],
        'subject': snap["subject"],
        'type': snap["type"],
        'report': reportMap,
      });
      await FirebaseFirestore.instance
          .collection("user")
          .doc(username)
          .collection("report")
          .doc(snap["Pid"])
          .set({
        'Pid': snap["Pid"],
        'subject': snap["subject"],
        'type': snap["type"],
        "report": [rep]
      });
    }
  }

  static appReport(rep) async {
    await FirebaseFirestore.instance.collection("AppReport").doc().set({
      "Uid": currUser,
      "Email": currEmail,
      "report": rep,
    });
  }

  static appfeedback(rep) async {
    await FirebaseFirestore.instance.collection("AppReport").doc().set({
      "Uid": currUser,
      "Email": currEmail,
      "report": rep,
    });
  }
}
