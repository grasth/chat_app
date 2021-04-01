import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  Future<void> add(userData) async {
    FirebaseFirestore.instance
        .collection("users")
        .add(userData)
        .catchError((e) {
      print(e.toString());
    });
  }
}
