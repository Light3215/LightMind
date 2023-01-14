import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/pages/loginpage/loginpage.dart';
import 'package:iiest_app/model/users.dart';
import 'package:iiest_app/utils/constants.dart';

final GlobalKey<ScaffoldMessengerState> EmailscaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// ignore: camel_case_types
class emailVerify extends StatefulWidget {
  const emailVerify({Key? key}) : super(key: key);

  @override
  State<emailVerify> createState() => _emailVerifyState();
}

// ignore: camel_case_types
class _emailVerifyState extends State<emailVerify> {
  bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  Timer? timer;
  bool canResendEmail = false;
  @override
  void initState() {
    super.initState();
    if (!isEmailVerified) {
      sendVerificationMail();
      timer = Timer.periodic(
          const Duration(seconds: 4), (timer) => {checkEmailVerified()});
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      users.updateData("Is verified", true);
      timer?.cancel();
    }
  }

  Future sendVerificationMail() async {
    try {
      setState(() {
        canResendEmail = false;
      });
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      showSnack("Mail has been send successfully... ");
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } on FirebaseAuthException catch (e) {
      showSnack(e.code);
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const loginpage()
      : MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ScaffoldMessenger(
            key: EmailscaffoldMessengerKey,
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/back.jpeg"),
                        fit: BoxFit.fill)),
                child: SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.all(30),
                      child: const Text(
                        "Verification Mail has been send to your mail.",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: const Text(
                        "After getting verified , Restart the app.",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        height: screenheight(context) * 0.07,
                        width: screenwidth(context) * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.amber,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.mail),
                            Center(child: Text("  Resend Email")),
                          ],
                        ),
                      ),
                      onTap: canResendEmail ? sendVerificationMail : null,
                    ),
                  ],
                )),
              ),
            ),
          ),
        );
}
