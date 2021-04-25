import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/dialog/dialog.dart';
import 'package:chat_app/src/screens/search/search.dart';
import 'package:chat_app/src/screens/welcome/welcome.dart';
import 'package:chat_app/src/services/auth/auth.dart';
import 'package:chat_app/src/services/auth/constants.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  Stream chatRooms;
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.size,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (snapshot.data.docs[index].get("lastMessage") !=
                      "Chat created!") {
                    return ChatRoomsTile(
                      userName: snapshot.data.docs[index].get("users")[0] ==
                              Constants.myName
                          ? snapshot.data.docs[index].get("users")[1]
                          : snapshot.data.docs[index].get("users")[0],
                      chatRoomId: snapshot.data.docs[index].id,
                      lastMessage: snapshot.data.docs[index].get("lastMessage"),
                      lastMessageByMe:
                          snapshot.data.docs[index].get("lastMessageBy") ==
                              Constants.myName,
                      lastMessageTime:
                          snapshot.data.docs[index].get("lastMessageDate"),
                    );
                  } else
                    return null;
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    await FirestoreFunctions()
        .setNameById(await AccountPrefs.getUserIdSharedPreference());
    await FirestoreFunctions().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
  }

  AuthFb authFb = new AuthFb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Image.asset('./lib/src/assets/image/addUser.png'),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => UserSearch()));
          },
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
        ],
      ),
      body: Container(
        color: Colors.black,
        margin: EdgeInsets.only(left: 5, top: 10, right: 5),
        child: chatRoomsList(),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  final String lastMessage;
  final bool lastMessageByMe;
  final String lastMessageTime;

  ChatRoomsTile(
      {this.userName,
      @required this.chatRoomId,
      this.lastMessage,
      this.lastMessageByMe,
      this.lastMessageTime});

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(lastMessageTime) * 1000);

    return GestureDetector(
      onTap: () {
        Variables.chatRoomId = chatRoomId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: chatRoomId,
                      friendName: userName,
                    )));
      },
      child: Container(
        color: Colors.white,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
