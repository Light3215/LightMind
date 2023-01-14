import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

subparts(title, titlecontext, titlepages) {
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
            textAlign: TextAlign.center,
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
    toolbarHeight: MediaQuery.of(AppBarcontext).size.height * 0.07,
    title: Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(AppBarcontext);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        Text(
          '$appbarName',
          style: const TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ],
    ),
    backgroundColor: Colors.amber,
  );
}

// open pdf in google drive
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
//eg. of a drive link : drive.google.com/file/d/1umBOrbXi9f0SRh3yzaNOBu9zaPqdanb9