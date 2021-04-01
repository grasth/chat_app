import 'package:chat_app/src/models/usermodel.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFb {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future signIn({email, password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      AccountPrefs.saveUserIdSharedPreference(result.user.uid);
      return _userFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUp({email, password}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
