import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../trail.dart';

Subparts<Widget>(title, titlecontext, titlepages) {
  return InkWell(
    child: Container(
      height: MediaQuery.of(titlecontext).size.height * 0.12,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(titlecontext).size.height * 0.010),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 45, 185, 250),
          boxShadow: const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 1,
                spreadRadius: 3,
                offset: Offset(2, 3))
          ],
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(titlecontext).size.width * 0.03,
          vertical: MediaQuery.of(titlecontext).size.height * 0.012),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(titlecontext).size.width * 0.04),
          child: Text(
            "$title",
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    ),
    onTap: () {
      Navigator.push(
        titlecontext,
        MaterialPageRoute(builder: (context) => titlepages),
      );
    },
  );
}

AppBar appbarName(appbarName, AppBarcontext) {
  return AppBar(
    // elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    centerTitle: true,
    toolbarHeight: MediaQuery.of(AppBarcontext).size.height * 0.06,
    title: Container(
      child: Text(
        '$appbarName',
        style: const TextStyle(color: Colors.black, fontSize: 25),
      ),
    ),
    backgroundColor: Colors.amber,
  );
}

functionbox(context, functionIcon) {
  return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => trial()),
        );
      },
      icon: Icon(functionIcon));
}

openPDF(pdf) {
  final Uri launchUri = Uri(
    scheme: 'https',
    path: "$pdf",
  );
  try {
    launchUrl(launchUri, mode: LaunchMode.externalNonBrowserApplication);
  } catch (e) {
    throw 'Could not launch $launchUri , $e ';
  }
}
