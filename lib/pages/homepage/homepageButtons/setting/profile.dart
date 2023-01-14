import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String getProfileData(String d) {
    var value = "";
    var docRef = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser?.uid);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        value = data[d];
      },
      onError: (e) => value = "Error getting document: $e",
    );
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.people,
        size: 29,
        color: Colors.grey,
      ),
      title: Text(
        getProfileData("Username"),
        style: const TextStyle(fontSize: 19),
      ),
      subtitle: Text(
        getProfileData("Email"),
        style: const TextStyle(fontSize: 19),
      ),
    );
  }
}
