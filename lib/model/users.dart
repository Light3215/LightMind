import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class users {
  final String Uid;
  final String Username;
  final String Email;
  final bool isVerified;
  static User? cred = FirebaseAuth.instance.currentUser;
  const users(
      {required this.Uid,
      required this.Username,
      required this.Email,
      required this.isVerified});

  static users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return users(
      Username: snapshot["username"],
      Uid: snapshot["uid"],
      Email: snapshot["email"],
      isVerified: snapshot["false"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Username": Username,
        "Uid": Uid,
        "Email": Email,
        "Is verified": isVerified,
      };

  static updateData(String key, var value) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(cred?.uid)
        .update({key: value});
  }

  static getData() async {
    var snap = await FirebaseFirestore.instance
        .collection("user")
        .doc(cred?.uid)
        .get();
    return snap.data();
  }
}
