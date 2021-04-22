import 'package:chat_app/src/screens/dialog/dialog.dart';
import 'package:chat_app/src/services/auth/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunctions {
  Future<void> add(userData, userId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  setNameById(String userId) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get()
        .then((snapshot) {
      Constants.myName = snapshot.data()["userName"].toString();
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isGreaterThanOrEqualTo: searchField)
        .where('userName', isLessThan: searchField + "z")
        .get();
  }

  thisChatCreated(String user1, String user2) {
    FirebaseFirestore.instance
        .collection("dialogs")
        .where('users', isEqualTo: [user1, user2])
        .get()
        .then((snapshot) {
          Variables.chatCreated = snapshot.docs.isNotEmpty;
          if (!Variables.chatCreated)
            Variables.chatRoomId = snapshot.docs.last.id;
        });
  }

  Future<bool> addChatRoom(chatRoom) {
    FirebaseFirestore.instance.collection("dialogs").doc().set(chatRoom);
  }

  getChatId(String timeStamp, String userName) {
    FirebaseFirestore.instance
        .collection("dialogs")
        .where('createdAt', isEqualTo: timeStamp)
        .where('users', arrayContains: userName)
        .where('lastMessage', isEqualTo: "Chat created!")
        .limit(1)
        .get()
        .then((snapshot) {
      Variables.chatRoomId = snapshot.docs.first.id;
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("dialogs")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("dialogs")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  updateLastMessage(String chatRoomId, String lastMessage) {
    Map<String, dynamic> messageUpdate = {
      "lastMessage": lastMessage,
    };
    FirebaseFirestore.instance
        .collection('dialogs')
        .doc(chatRoomId)
        .set(messageUpdate, SetOptions(merge: true));
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("dialogs")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
