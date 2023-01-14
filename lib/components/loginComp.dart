// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils/constants.dart';

logInButton(Text text, login, icon, context, loading) {
  return Material(
    child: Ink(
      height: screenheight(context) * 0.07,
      width: screenwidth(context) * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.amber,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        splashColor: Colors.yellow[800],
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  Center(child: text),
                ],
              ),
        onTap: login,
      ),
    ),
  );
}

backgrdImage() {
  return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/back.jpeg"), fit: BoxFit.fill));
}

SnackBar snackbar(title) {
  return SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ));
}

titleHeader(String text, context) {
  return Container(
    padding: EdgeInsets.only(
      left: screenwidth(context) * 0.08,
    ),
    child: Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 35),
            ),
            // Text("")
          ],
        ),
      ],
    ),
  );
}
