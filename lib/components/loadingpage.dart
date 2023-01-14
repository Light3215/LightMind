// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/pages/homepage/homepagePart/homepage.dart';
import 'package:iiest_app/pages/loginpage/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loadingpage extends StatefulWidget {
  const loadingpage({Key? key}) : super(key: key);

  @override
  State<loadingpage> createState() => _loadingpageState();
}

class _loadingpageState extends State<loadingpage> {
  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    rememberMeLogic();
  }

  void rememberMeLogic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var prefs = sharedPreferences;
    setState(() {
      pref = prefs;
    });

    if (pref.getBool("Remember me") == true) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: pref.getString("email").toString().trim(),
        password: pref.getString("password").toString().trim(),
      );
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const homepage()),
      );
    } else {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const loginpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Center(child: CircularProgressIndicator())),
    );
  }
}
