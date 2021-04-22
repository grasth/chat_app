import 'package:chat_app/src/models/usermodel.dart';
import 'package:chat_app/src/services/auth/constants.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:flutter/cupertino.dart';

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

      await FirestoreFunctions().setNameById(result.user.uid);
      Constants.uid = result.user.uid;
      AccountPrefs.saveUserIdSharedPreference(result.user.uid);
      AccountPrefs.saveUserLoggedInSharedPreference(true);

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

      await FirestoreFunctions().setNameById(result.user.uid);
      Constants.uid = result.user.uid;
      AccountPrefs.saveUserIdSharedPreference(result.user.uid);
      AccountPrefs.saveUserLoggedInSharedPreference(true);
      await _addUser.add(userData, result.user.uid);

      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      AccountPrefs.saveUserIdSharedPreference("");
      AccountPrefs.saveUserLoggedInSharedPreference(false);
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
