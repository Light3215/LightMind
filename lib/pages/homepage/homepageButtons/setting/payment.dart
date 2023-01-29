import 'package:flutter/material.dart';
import 'package:iiest_app/components/subjectcomp.dart';

class payment extends StatefulWidget {
  const payment({Key? key}) : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appbarName("Thank you", context),
        body: Container(
          margin: const EdgeInsets.all(30),
          child: const Center(
            child: Text(
              "No need to give anything to me.. \nAs a senior its my duty to help and guide you all in the best way possible.. \nSo that in future, you all can become the senior every junior wants 💙",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ),
    );
  }
}
