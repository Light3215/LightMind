import 'package:flutter/material.dart';
import 'package:iiest_app/utils/constants.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: screenheight(context) * 0.4,
                    width: screenwidth(context) * 0.4,
                    child: Image.asset(
                      "assets/studingkid.jpg",
                      fit: BoxFit.contain,
                    )),
                const Text("", textAlign: TextAlign.justify),
              ],
            )
          ],
        ),
      )),
    );
  }
}
