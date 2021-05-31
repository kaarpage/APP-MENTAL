import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addRespostaQuestionarioSono(String emailId, respostasMap, String data) {
    FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(emailId)
        .collection("respostas")
        .doc("${data}")
        .set(respostasMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addRespostaPromisn1(String emailId, dominioMap) {
    FirebaseFirestore.instance
        .collection("Quests")
        .doc(emailId)
        .collection("userQuests")
        .doc("promisn1")
        .collection("userPromisn1")
        .add(dominioMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getDataQuestSono(String email) async {
    return FirebaseFirestore.instance
        .collection("questionarioSono")
        .doc(email)
        .collection("respostas")
        .get();
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getValuePromisn1(String userEmail) async {
    return FirebaseFirestore.instance
        .collection("Quests")
        .doc(userEmail)
        .collection("userQuests")
        .doc("promisn1")
        .collection("userPromisn1")
        .limitToLast(1)
        .get();
  }

  getQuests(String userEmail) async {
    return FirebaseFirestore.instance
        .collection('Quests')
        .doc(userEmail)
        .collection("userQuests")
        .get();
  }

  getChatRooms(String userName) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }

  getQuestsRooms(String userEmail) async {
    return FirebaseFirestore.instance
        .collection('Escala')
        .where("userEmail", arrayContains: userEmail)
        .snapshots();
  }
}
