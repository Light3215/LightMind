// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/setting/contactUs.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/setting/feedback.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/setting/payment.dart';
import 'package:iiest_app/pages/homepage/homepageButtons/setting/appReport.dart';
import 'package:iiest_app/pages/loginpage/loginpage.dart';
import 'package:iiest_app/utils/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  var pref;

  late Stream<DocumentSnapshot<Map<String, dynamic>>> dataLoaded;
  Stream<DocumentSnapshot<Map<String, dynamic>>> readData() =>
      FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots();

  @override
  void initState() {
    var hello = readData();
    setState(() {
      dataLoaded = hello;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appbarName("Settings", context),
          body: SafeArea(
            child: Column(
              children: [
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: dataLoaded,
                  builder: (_, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error = ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      var output = snapshot.data!.data();
                      return ListTile(
                        leading: Container(
                          margin: EdgeInsets.only(
                              top: screenheight(context) * 0.012),
                          child: const Icon(
                            Icons.person,
                            size: 29,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          output?["Username"],
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(
                          output?["Email"],
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                horizontalLine(context),
                ListTile(
                  leading: const Icon(
                    Icons.people,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Contact us",
                    style: TextStyle(fontSize: 19),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const contactUs()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.feedback_outlined,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Feedback",
                    style: TextStyle(fontSize: 19),
                  ),
                  onTap: () {
                    appfeedback(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.report_problem_outlined,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Report",
                    style: TextStyle(fontSize: 19),
                  ),
                  onTap: () {
                    appReport(context);
                  },
                ),
                horizontalLine(context),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "About us",
                    style: TextStyle(fontSize: 19),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const about()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.coffee,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Buy me a coffee",
                    style: TextStyle(fontSize: 19),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const payment()),
                    );
                  },
                ),
                horizontalLine(context),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Sign out",
                    style: TextStyle(fontSize: 19),
                  ),
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool("Remember me", false);
                    setState(() {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const loginpage()),
                      );
                    });
                  },
                ),
              ],
            ),
          )),
    ));
  }
}

Divider horizontalLine(context) {
  return Divider(
    thickness: 1,
    indent: MediaQuery.of(context).size.width * 0.18,
  );
}
