// ignore_for_file: non_constant_identifier_names, duplicate_ignore, file_names

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
HomepageIcons<Widget>(iconname, icons, iconbkcolor, iconcontexts, iconpages) {
  return Column(
    children: [
      Container(
        width: MediaQuery.of(iconcontexts).size.width * 0.14,
        // height: MediaQuery.of(iconcontexts).size.width * 0.14,
        decoration: BoxDecoration(
          color: iconbkcolor,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            icons,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              iconcontexts,
              MaterialPageRoute(builder: (context) => iconpages),
            );
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: Text(
          "$iconname",
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ],
  );
}

// Subjects
Cards<Widget>(subjectname, subjectimage, subjectcontexts, subjectpage) {
  return Card(
      color: Colors.amber,
      child: Column(
        children: [
          IconButton(
            icon: Image.asset("$subjectimage"),
            iconSize: 120,
            onPressed: () {
              Navigator.push(
                subjectcontexts,
                MaterialPageRoute(builder: (context) => subjectpage),
              );
            },
          ),
          Text("$subjectname", style: const TextStyle(fontSize: 13))
        ],
      ));
}
