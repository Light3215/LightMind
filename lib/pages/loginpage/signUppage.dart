// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/model/users.dart';
import 'package:iiest_app/utils/constants.dart';
import 'package:iiest_app/pages/loginpage/emailVerify.dart';
import 'package:iiest_app/pages/loginpage/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/loginComp.dart';

GlobalKey<ScaffoldMessengerState> signUpscaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
var signUpShowSnack = signUpscaffoldMessengerKey.currentState;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class signUpPage extends StatefulWidget {
  const signUpPage({Key? key}) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  @override
  void initState() {
    rememberMeLogic();
    super.initState();
  }

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    UsernameController.dispose();
    super.dispose();
  }

  TextEditingController EmailController = TextEditingController();
  TextEditingController UsernameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool isloading = false;
  bool cond = true;
  var pref;
  void rememberMeLogic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var prefs = sharedPreferences;
    setState(() {
      pref = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        key: signUpscaffoldMessengerKey,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Container(
              // decoration: backgrdImage(),
              decoration: const BoxDecoration(color: Colors.amber),
              child: SafeArea(
                  child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenheight(context) * 0.076,
                  ),
                  Container(
                    height: screenheight(context) * 0.2,
                    width: screenwidth(context) * 0.29,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/person.png"))),
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
                          //email box
                          Column(
                            children: [
                              const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                              //Email
                              Container(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * 0.08,
                                    right: screenwidth(context) * 0.08),
                                child: TextFormField(
                                  controller: UsernameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter Username'),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * 0.08,
                                    right: screenwidth(context) * 0.08),
                                child: TextFormField(
                                    controller: EmailController,
                                    decoration: const InputDecoration(
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
                              //Password
                              Container(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * 0.08,
                                    right: screenwidth(context) * 0.08),
                                child: TextFormField(
                                    controller: PasswordController,
                                    obscureText: cond,
                                    decoration: const InputDecoration(
                                      labelText: 'Create Password',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (pword) {
                                      if (pword != null && (pword.length) < 7) {
                                        return "Enter minimum 8 characters";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: screenwidth(context) * 0.06),
                                    child: TextButton(
                                      onPressed: (() => {
                                            setState(() => {cond = !cond})
                                          }),
                                      child: const Text("Show password"),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(),
                          logInButton("Sign Up", signUp, Icons.person_add,
                              context, isloading),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                  onPressed: (() => {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const loginpage()),
                                        ),
                                      }),
                                  child: const Text(
                                    "Log In",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            )),
      ),
    );
  }

  Future<void> signUp() async {
    setState(() {
      isloading = true;
    });
    try {
      if (EmailController.text.isNotEmpty ||
          PasswordController.text.isNotEmpty) {
        UserCredential cred =
            (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text.trim(),
          password: PasswordController.text.trim(),
        ));
        pref.setString("Username", UsernameController.text);
        users user1 = users(
          Username: UsernameController.text.trim(),
          Email: EmailController.text.trim(),
          Uid: cred.user!.uid,
          isVerified: FirebaseAuth.instance.currentUser!.emailVerified,
        );
        await _firestore
            .collection("user")
            .doc(cred.user!.uid)
            .set(user1.toJson());

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const emailVerify()),
        );
      }
    } on FirebaseAuthException catch (err) {
      showSnack(err.code);
      setState(() {
        isloading = false;
      });
    }
  }
}

void showSnack(String error) {
  if (error == "network-request-failed") {
    signUpShowSnack?.showSnackBar(snackbar("No internet"));
  } else if (error == "email-already-in-use") {
    signUpShowSnack?.showSnackBar(snackbar("Account already created"));
  } else {
    signUpShowSnack?.showSnackBar(snackbar("Enter valid email"));
  }
}
