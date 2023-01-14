// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/back.jpeg"),
                        fit: BoxFit.fill)),
                child: SafeArea(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.08,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.4,
                          ),
                          const Text(
                            "Forgot password",
                            style: TextStyle(fontSize: 28.5),
                          ),
                          const Text(
                            "Don't worry we have got your back",
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08,
                          right: MediaQuery.of(context).size.width * 0.08),
                      child: TextFormField(
                          controller: EmailController,
                          decoration: const InputDecoration(
                              // border: InputBorder.none,
                              labelText: 'Enter College Email'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.08),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: screenheight(context) * 0.075,
                              width: screenwidth(context) * 0.55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.amber,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.email),
                                  Center(child: Text("Reset password")),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onTap: resetPassword,
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
      showSnack(e.code);
    }
  }

  void showSnack(String title) {
    final snackbar = SnackBar(
        duration: const Duration(seconds: 4),
        content: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ));
    forgotPasswordScaffoldMessengerKey.currentState?.showSnackBar(snackbar);
  }
}
