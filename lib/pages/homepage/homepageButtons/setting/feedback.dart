import 'package:flutter/material.dart';
import 'package:iiest_app/model/pdfData.dart';
import 'package:iiest_app/utils/constants.dart';

TextEditingController feedbackController = TextEditingController();

appfeedback(context) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Feedback'),
            content: SizedBox(
              height: screenheight(context) * 0.15,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Please give your feedback or suggestion"),
                    TextFormField(
                      controller: feedbackController,
                    ),
                  ]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  feedbackController.text = "";
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  PdfData.appfeedback(feedbackController.text.trim());
                  feedbackController.text = "";
                  Navigator.pop(context);
                  done(context);
                },
                child: const Text("Submit"),
              )
            ],
          )));
}

done(context) {
  return showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            content: const SizedBox(child: Text("Thank you for your feedback")),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Done"))
            ],
          )));
}
