import 'package:chat_app/src/helper/timeHelper.dart';
import 'package:chat_app/src/screens/const/color_const.dart';
import 'package:chat_app/src/screens/dialog/dialog.dart';
import 'package:chat_app/src/screens/search/search.dart';
import 'package:chat_app/src/screens/welcome/welcome.dart';
import 'package:chat_app/src/services/auth/auth.dart';
import 'package:chat_app/src/services/auth/constants.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
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

  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    await FirestoreFunctions()
        .setNameById(await AccountPrefs.getUserIdSharedPreference());
    await FirestoreFunctions().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        isLoading = false;
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
          '??????????????????',
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
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 16,
                    child: Container(
                      height: 300.0,
                      width: 360.0,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "?????????????????????????? ????????????",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 60),
                          FlatButton(
                            onPressed: () {
                              setState(() => Navigator.pop(context));
                            },
                            child: Text(
                              '????????????????',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          FlatButton(
                            onPressed: () {
                              authFb.signOut();
                              AccountPrefs.saveUserLoggedInSharedPreference(
                                  false);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomePage()));
                            },
                            child: Text(
                              '??????????',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            },
            // authFb.signOut(),
            // AccountPrefs.saveUserLoggedInSharedPreference(false),
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => WelcomePage()))
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
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
        height: 70,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(userName.substring(0, 1),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
            ),
            Expanded(
              flex: 6, // 60%
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    userName,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.topLeft,
                  child: Text((lastMessageByMe ? "you: " : "he: ") +
                      (lastMessage.length > 10
                          ? (lastMessage.substring(0, 10)) + "..."
                          : lastMessage)),
                ),
              ]),
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Text(getTime(date)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
