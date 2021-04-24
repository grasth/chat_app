import 'package:chat_app/src/services/auth/constants.dart';
import 'package:chat_app/src/services/shared_prefs/shared_prefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFunctions {
  Future<void> add(userData, userId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  setNameById(String userId) async {
    await FirebaseFirestore.instance
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

  chatExist(String user1, String user2) async {
    Variables.chatCreate = true;
    await FirebaseFirestore.instance
        .collection("dialogs")
        .where("users", arrayContains: user1)
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        Variables.chatCreate = true;
      } else {
        value.docs.forEach((field) {
          if (field.data()['users'][0] == user2 ||
              field.data()['users'][1] == user2) {
            Variables.chatRoomId = field.id;
            Variables.chatCreate = false;
            print("EndLoop");
            return;
          }
        });
      }
    });
    print("ChatCreate {" + user2 + "}: " + Variables.chatCreate.toString());
    if (!Variables.chatCreate)
      print("ChatId {" + user2 + "}: " + Variables.chatRoomId);
  }

  addChatRoom(chatRoom) {
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
        .orderBy('time', descending: true)
        .snapshots();
  }

  addMessage(String chatRoomId, chatMessageData) {
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
    await FirestoreFunctions()
        .setNameById(await AccountPrefs.getUserIdSharedPreference());
    return await FirebaseFirestore.instance
        .collection("dialogs")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
