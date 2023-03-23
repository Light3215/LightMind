// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/components/loginComp.dart';
import 'package:iiest_app/utils/constants.dart';

final GlobalKey<ScaffoldMessengerState> forgotPasswordScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  TextEditingController EmailController = TextEditingController();
  bool wait = false;
  @override
  void dispose() {
    EmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScaffoldMessenger(
          key: forgotPasswordScaffoldMessengerKey,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Container(
                decoration: const BoxDecoration(color: Colors.amber),
                child: SafeArea(
                    child: Column(
                  children: [
                    SizedBox(
                      height: screenheight(context) * 0.07,
                    ),
                    Container(
                      height: screenheight(context) * 0.2,
                      width: screenwidth(context) * 0.45,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/forgotPassword.jpeg"))),
                    ),
                    Center(
                      child: Container(
                        height: screenheight(context) * 0.55,
                        width: screenwidth(context) * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "Forgot password",
                                  style: TextStyle(fontSize: 28.5),
                                ),
                                Text(
                                  "Don't worry we have got your back",
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.08,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08),
                              child: TextFormField(
                                  controller: EmailController,
                                  decoration: const InputDecoration(
                                      // border: InputBorder.none,
                                      labelText: 'Enter Email'),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) {
                                    if (email != null &&
                                        !EmailValidator.validate(email)) {
                                      return "Enter a valid email";
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                            Container(
                                child: logInButton("Reset Password",
                                    resetPassword, Icons.mail, context, false)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              )),
        ));
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: EmailController.text.trim(),
      );
      forgotPasswordScaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
              content:
                  Text("Password reset email sent (Check spam mail also)")));
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnack(e.code);
    }
  }

  void showSnack(String title) {
    if (title == "network-request-failed") {
      forgotPasswordScaffoldMessengerKey.currentState
          ?.showSnackBar(snackbar("No internet"));
    } else if (title == "user-not-found") {
      forgotPasswordScaffoldMessengerKey.currentState
          ?.showSnackBar(snackbar("Account does not exist"));
    } else {
      forgotPasswordScaffoldMessengerKey.currentState
          ?.showSnackBar(snackbar("Enter valid email"));
    }
  }
}
