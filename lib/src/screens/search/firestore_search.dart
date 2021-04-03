import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearch_fb {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isGreaterThanOrEqualTo: searchField)
        .where('userName', isLessThan: searchField + "z")
        .get();
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
}
