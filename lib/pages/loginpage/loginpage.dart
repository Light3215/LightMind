// // ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:iiest_app/model/users.dart';
// import 'package:iiest_app/utils/constants.dart';
// import 'package:iiest_app/pages/homepage/homepagePart/homepage.dart';
// import 'package:iiest_app/components/loginComp.dart';
// import 'package:iiest_app/pages/loginpage/forgotPassword.dart';
// import 'package:iiest_app/pages/loginpage/signUppage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// GlobalKey<ScaffoldMessengerState> logInscaffoldMessengerKey =
//     GlobalKey<ScaffoldMessengerState>();

// class loginpage extends StatefulWidget {
//   const loginpage({Key? key}) : super(key: key);

//   @override
//   State<loginpage> createState() => _loginpageState();
// }

// class _loginpageState extends State<loginpage> {
//   @override
//   void initState() {
//     rememberMeLogic();
//     super.initState();
//   }

//   void rememberMeLogic() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var prefs = sharedPreferences;
//     setState(() {
//       pref = prefs;
//     });
//   }

//   @override
//   void dispose() {
//     EmailController.dispose();
//     PasswordController.dispose();
//     super.dispose();
//   }

//   TextEditingController EmailController = TextEditingController();
//   TextEditingController PasswordController = TextEditingController();
//   late SharedPreferences pref;
//   bool rememberMe = false;
//   bool isloading = false;
//   bool cond = true;
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: ScaffoldMessenger(
//           key: logInscaffoldMessengerKey,
//           child: Scaffold(
//               resizeToAvoidBottomInset: false,
//               backgroundColor: Colors.white,
//               body: Container(
//                 // decoration: backgrdImage(),
//                 child: SafeArea(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const SizedBox(),
//                     titleHeader("Log in", context),
//                     //email box
//                     Column(
//                       children: [
//                         //Email
//
//                         //Password
//                         Container(
//                           padding: EdgeInsets.only(
//                               left: screenwidth(context) * 0.08,
//                               right: screenwidth(context) * 0.08),
//                           child: TextFormField(
//                               obscureText: cond,
//                               controller: PasswordController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Enter Password',
//                               ),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               validator: (pword) {
//                                 if (pword != null && (pword.length) < 6) {
//                                   return "Enter minimum 6 characters";
//                                 } else {
//                                   return null;
//                                 }
//                               }),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             TextButton(
//                               onPressed: (() => {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const forgotPassword()),
//                                     ),
//                                   }),
//                               child: const Text("Forgot password?"),
//                             ),
//                             TextButton(
//                               onPressed: (() => {
//                                     setState(() => {cond = !cond})
//                                   }),
//                               child: const Text("Show password"),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                     Container(
//                       margin:
//                           EdgeInsets.only(right: screenwidth(context) * 0.08),
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Checkbox(
//                                 value: rememberMe,
//                                 onChanged: ((value) => setState(() {
//                                       rememberMe = !rememberMe;
//                                     }))),
//                             const Text(
//                               "Remember me",
//                               style: TextStyle(fontSize: 16),
//                             )
//                           ]),
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.only(right: screenwidth(context) * 0.08),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           logInButton(const Text("  Log in"), login,
//                               Icons.login, context, isloading),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               const Text("Don't have an account?"),
//                               TextButton(
//                                   onPressed: (() => {
//                                         Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const signUpPage()),
//                                         ),
//                                       }),
//                                   child: const Text(
//                                     "Sign Up",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 )),
//               )),
//         ),
//       );

//   Future login() async {
//     setState(() {
//       isloading = true;
//     });
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: EmailController.text.trim(),
//         password: PasswordController.text.trim(),
//       );
//       if (FirebaseAuth.instance.currentUser!.emailVerified) {
//         users.updateData("Is verified", true);
//         if (rememberMe) {
//           pref.setString("email", EmailController.text);
//           pref.setString("password", PasswordController.text);
//           pref.setBool("Remember me", rememberMe);
//         }
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const homepage()),
//         );
//       } else {
//         await FirebaseAuth.instance.signOut();
//       }
//     } on FirebaseAuthException catch (e) {
//       showSnack(e.code);
//       setState(() {
//         isloading = false;
//       });
//     }
//   }
// }

// void showSnack(String title) {
//   if (title == "network-request-failed") {
//     logInscaffoldMessengerKey.currentState
//         ?.showSnackBar(snackbar("No internet"));
//   } else if (title == "user-not-found") {
//     logInscaffoldMessengerKey.currentState
//         ?.showSnackBar(snackbar("Account does not exist"));
//   } else if (title == "wrong-password") {
//     logInscaffoldMessengerKey.currentState
//         ?.showSnackBar(snackbar("Incorrect password"));
//   } else {
//     logInscaffoldMessengerKey.currentState
//         ?.showSnackBar(snackbar("Enter valid email"));
//   }
// }
// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiest_app/model/users.dart';
import 'package:iiest_app/utils/constants.dart';
import 'package:iiest_app/pages/homepage/homepagePart/homepage.dart';
import 'package:iiest_app/components/loginComp.dart';
import 'package:iiest_app/pages/loginpage/forgotPassword.dart';
import 'package:iiest_app/pages/loginpage/signUppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

GlobalKey<ScaffoldMessengerState> logInscaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  void initState() {
    rememberMeLogic();
    super.initState();
  }

  void rememberMeLogic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var prefs = sharedPreferences;
    setState(() {
      pref = prefs;
    });
  }

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  late SharedPreferences pref;
  bool rememberMe = false;
  bool isloading = false;
  bool cond = true;
//   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        key: logInscaffoldMessengerKey,
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
                    height: screenheight(context) * 0.07,
                  ),
                  Container(
                    height: screenheight(context) * 0.2,
                    width: screenwidth(context) * 0.3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/lock.png"))),
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
                                "Log in",
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
                              // Password
                              Container(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * 0.08,
                                    right: screenwidth(context) * 0.08),
                                child: TextFormField(
                                    obscureText: cond,
                                    controller: PasswordController,
                                    decoration: const InputDecoration(
                                      labelText: 'Enter Password',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (pword) {
                                      if (pword != null && (pword.length) < 6) {
                                        return "Enter minimum 6 characters";
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: screenwidth(context) * 0.06,
                                    right: screenwidth(context) * 0.06),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: (() => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const forgotPassword()),
                                            ),
                                          }),
                                      child: const Text("Forgot password?"),
                                    ),
                                    TextButton(
                                      onPressed: (() => {
                                            setState(() => {cond = !cond})
                                          }),
                                      child: const Text("Show password"),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(),
                          logInButton("Log in", login, Icons.person_add,
                              context, isloading),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                  onPressed: (() => {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const signUpPage()),
                                        ),
                                      }),
                                  child: const Text(
                                    "Sign up",
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

  Future login() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: EmailController.text.trim(),
        password: PasswordController.text.trim(),
      );
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        users.updateData("Is verified", true);
        if (rememberMe) {
          pref.setString("email", EmailController.text);
          pref.setString("password", PasswordController.text);
          pref.setBool("Remember me", rememberMe);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const homepage()),
        );
      } else {
        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (e) {
      showSnack(e.code);
      setState(() {
        isloading = false;
      });
    }
  }
}

void showSnack(String title) {
  if (title == "network-request-failed") {
    logInscaffoldMessengerKey.currentState
        ?.showSnackBar(snackbar("No internet"));
  } else if (title == "user-not-found") {
    logInscaffoldMessengerKey.currentState
        ?.showSnackBar(snackbar("Account does not exist"));
  } else if (title == "wrong-password") {
    logInscaffoldMessengerKey.currentState
        ?.showSnackBar(snackbar("Incorrect password"));
  } else {
    logInscaffoldMessengerKey.currentState
        ?.showSnackBar(snackbar("Enter valid email"));
  }
}
