import 'package:flutter/material.dart';
import 'package:iiest_app/components/loginComp.dart';
import 'package:iiest_app/components/subjectcomp.dart';
import 'package:iiest_app/utils/constants.dart';
import 'package:flutter/services.dart';

GlobalKey<ScaffoldMessengerState> contactUsScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class contactUs extends StatefulWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        key: contactUsScaffoldMessengerKey,
        child: Scaffold(
            appBar: appbarName("Contact us", context),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Text(
                    "You can contact us via mail.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    height: screenheight(context) * 0.07,
                    width: screenwidth(context) * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "   kumarabhigyandeep@gmail.com",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(const ClipboardData(
                                  text: "kumarabhigyandeep@gmail.com"));
                              contactUsScaffoldMessengerKey.currentState
                                  ?.showSnackBar(
                                      snackbar("Copied Successfully"));
                            },
                            icon: const Icon(Icons.copy))
                      ],
                    ),
                  )
                ]))),
      ),
    );
  }
}
