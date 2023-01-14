import 'package:flutter/material.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/utils/constants.dart';

TextEditingController reportController = TextEditingController();

appReport(context) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Report'),
            content: SizedBox(
              height: screenheight(context) * 0.15,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "Please tell us about the problem you faced while using this App."),
                    TextFormField(
                      controller: reportController,
                    ),
                  ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  reportController.text = "";
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  PdfData.appReport(reportController.text.trim());
                  reportController.text = "";
                  Navigator.pop(context);
                  done(context);
                },
                child: const Text("Report"),
              )
            ],
          )));
}

done(context) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text("Thank you"),
            content: const SizedBox(
                child: Text(
                    "Your issue has been registered successfully and will be rectified soon")),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Done"))
            ],
          )));
}
