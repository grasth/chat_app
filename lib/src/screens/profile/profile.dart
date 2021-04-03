import 'package:chat_app/src/screens/welcome/welcome.dart';
import 'package:chat_app/src/services/auth/auth.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthFb authFb = new AuthFb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, // установка цвета для иконок AppBar - чёрный
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            onPressed: () => {
              authFb.signOut(),
              AccountPrefs.saveUserLoggedInSharedPreference(false),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomePage()))
            },
          ),
        ],
      ),
    );
  }
}
