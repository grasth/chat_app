import 'package:chat_app/src/screens/dialog/dialog.dart';
import 'package:chat_app/src/services/auth/constants.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearch createState() => _UserSearch();
}

class _UserSearch extends State<UserSearch> {
  FirestoreFunctions _firestoreFunctions = FirestoreFunctions();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await _firestoreFunctions
          .searchByName(searchEditingController.text.trim())
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.docs[index].get("userName"),
                searchResultSnapshot.docs[index].get("userEmail"),
              );
            })
        : Container();
  }

  sendMessage(String userName) async {
    var uid = await AccountPrefs.getUserIdSharedPreference();
    await FirestoreFunctions().setNameById(uid);

    Variables.chatRoomId = "";

    await FirestoreFunctions().chatExist(Constants.myName, userName);

    if (Variables.chatCreate) {
      List<String> users = [Constants.myName, userName];

      Variables.chatRoomTimeStamp = Timestamp.now().seconds.toString();

      Map<String, dynamic> chatRoom = {
        "chats": [],
        "lastMessage": "Chat created!",
        "createdAt": Variables.chatRoomTimeStamp,
        "users": users,
      };

      FirestoreFunctions().addChatRoom(chatRoom);
      await FirestoreFunctions()
          .getChatId(Variables.chatRoomTimeStamp, Constants.myName);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: Variables.chatRoomId,
                  friendName: userName,
                )));
  }

  Widget userTile(String userName, String userEmail) {
    print(userName);
    if (userName == Constants.myName) return null;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Поиск",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Color(0x54FFFFFF),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchEditingController,
                            decoration: InputDecoration(
                              hintText: "search username ...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              initiateSearch();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: EdgeInsets.all(12),
                              child: Icon(Icons.search),
                            ))
                      ],
                    ),
                  ),
                  userList()
                ],
              ),
            ),
    );
  }
}
