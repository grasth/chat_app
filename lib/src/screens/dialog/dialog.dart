import 'package:chat_app/src/services/auth/constants.dart';
import 'package:chat_app/src/services/auth/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String friendName;

  Chat({this.chatRoomId, this.friendName});

  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70),
                reverse: true,
                itemCount: snapshot.data.size,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.docs[index].get("body"),
                    sendByMe: Constants.myName ==
                        snapshot.data.docs[index].get("sendBy"),
                  );
                })
            : Container();
      },
    );
  }

  addMessage() async {
    if (messageEditingController.text.isNotEmpty) {
      String lastMessageTime = Timestamp.now().seconds.toString();

      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "body": messageEditingController.text,
        'time': lastMessageTime
      };

      await FirestoreFunctions()
          .addMessage(widget.chatRoomId.toString(), chatMessageMap);
      await FirestoreFunctions().updateLastMessage(
          widget.chatRoomId, messageEditingController.text, lastMessageTime);
      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  initState() {
    print(widget.chatRoomId);
    FirestoreFunctions().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.friendName.toString(),
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(top: 110),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      decoration: InputDecoration(
                        hintText: "???????????????? ??????????????????...",
                        hintStyle: TextStyle(
                          color: Color(0xC4C4C4C4C4C4),
                          fontSize: 16,
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.send)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          color: sendByMe ? Color.fromARGB(232, 232, 228, 228) : Colors.white,
          border: sendByMe
              ? Border.all(color: Color.fromARGB(232, 232, 228, 228))
              : Border.all(color: Color.fromARGB(232, 232, 228, 228)),
          borderRadius: sendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
