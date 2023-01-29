// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../pages/homepage/homepagePart/homepage.dart';
import '../pages/loginpage/loginpage.dart';

class loadingpage extends StatefulWidget {
  const loadingpage({Key? key}) : super(key: key);

  @override
  State<loadingpage> createState() => _loadingpageState();
}

class _loadingpageState extends State<loadingpage> {
  late SharedPreferences pref;
  late VideoPlayerController _controller;
  late Future _initializeVideoPlayerFuture;

  @override
  void initState() {
    rememberMeLogic();
    _controller = VideoPlayerController.asset(
        "flutter_assets/assets/video/Lightmind.mp4");
    videoplay();
    // checkConnection();
    super.initState();
  }

  // void checkConnection() async {
  //   var check = await InternetConnectionChecker().hasConnection;
  //   // print(check);
  // }

  void videoplay() async {
    _initializeVideoPlayerFuture = _controller.initialize();
    await _controller.play();
    Future.delayed(const Duration(milliseconds: 1350), () {});
  }

  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  void rememberMeLogic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var prefs = sharedPreferences;
    setState(() {
      pref = prefs;
    });

    try {
      if (pref.getBool("Remember me") == true) {
        print(pref.getString("email"));
        print(pref.getString("password"));
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: pref.getString("email").toString().trim(),
          password: pref.getString("password").toString().trim(),
        );
        print("waiting bro what you are doing");
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
    } on FirebaseAuthException catch (e) {
      Center(
        child: Text(e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            );
          } else {
            return Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                )));
          }
        },
      ),
    );
  }
}
