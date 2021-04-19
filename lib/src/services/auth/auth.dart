import 'package:chat_app/src/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/src/services/auth/firestore.dart';

class AuthFb {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreFunctions _addUser = new FirestoreFunctions();

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future signIn({email, password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUp({username, email, password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Map<String, String> userData = {
        "userName": username,
        "userEmail": email,
        "timeStamp": Timestamp.now().seconds.toString(),
        "userId": result.user.uid
      };

      await _addUser.add(userData);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
