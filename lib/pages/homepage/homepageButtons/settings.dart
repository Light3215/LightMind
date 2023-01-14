import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/main.dart';
import 'package:iiest_app/model/users.dart';
import 'package:iiest_app/pages/homepage/homepagePart/homepage.dart';
import 'package:iiest_app/pages/loginpage/loginpage.dart';
import 'package:iiest_app/trail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 27,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.amber,
            title: const Text(
              "Settings",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.help,
                    size: 29,
                    color: Colors.grey,
                  ),
                  title: const Text(
                    "Help",
                    style: TextStyle(fontSize: 21),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const trial()),
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
                    style: TextStyle(fontSize: 21),
                  ),
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    var pref = sharedPreferences;
                    pref.setBool("Remember me", false);
                    setState(() {
                      FirebaseAuth.instance.signOut();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => loginpage()),
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
    thickness: 2,
    indent: MediaQuery.of(context).size.width * 0.18,
  );
}

// Tile(icons, titles, work) {
//   return ListTile(
//     leading: Icon(
//       icons,
//       size: 29,
//       color: Colors.grey,
//     ),
//     title: Text(
//       "$titles",
//       style: TextStyle(fontSize: 21),
//     ),
//     onTap: () => work,
//   );
// }
