import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/welcome/welcome.dart';
import 'package:chat_app/src/services/auth/auth.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    AuthFb authFb = new AuthFb();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.verified_user_rounded,
          color: Colors.black,
        ),
        title: Text(
          'Сообщения',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Raleway",
              fontSize: 22.0,
              decoration: TextDecoration.none),
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
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        margin: EdgeInsets.only(left: 15, top: 30, right: 15),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
