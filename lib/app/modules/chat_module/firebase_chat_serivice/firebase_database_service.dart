import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_helper.dart';

const String USER_COLLECTION = 'Users';
const String CHAT_COLLECTION = 'Chats';
const String MESSAGE_COLLECTION = 'Messages';

class DatabaseService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  DatabaseService() {}

  createUser(
    String uid,
    String name,
    String imgUrl,
    String deviceToken,
    String chattingWith,
  ) async {
    try {
      await firebaseFirestore.collection(USER_COLLECTION).doc(uid).set({
        'name': name,
        'imgUrl': imgUrl,
        'lastActiveTime': DateTime.now().toUtc(),
        'deviceToken': deviceToken,
        'chattingWith': chattingWith,
        'count': 0
      });
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) {
    return firebaseFirestore.collection(USER_COLLECTION).doc(uid).get();
  }

  Stream<QuerySnapshot> getChatsForUser(String uid) {
    return firebaseFirestore
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForUser(String chatId) async {
    return firebaseFirestore
        .collection(CHAT_COLLECTION)
        .doc(chatId)
        .collection(MESSAGE_COLLECTION)
        .orderBy('sentTime', descending: true)
        .limit(1)
        .get();
  }

  Stream<QuerySnapshot> streamMessageForUser(chatId) {
    return firebaseFirestore
        .collection(CHAT_COLLECTION)
        .doc(chatId)
        .collection(MESSAGE_COLLECTION)
        .orderBy('sentTime', descending: false)
        .snapshots();
  }

  Future<void> updateUserLastSeen(String uid) async {
    await firebaseFirestore
        .collection(USER_COLLECTION)
        .doc(uid)
        .update({'lastActiveTime': DateTime.now().toUtc()});
  }

  Future<void> updateDeviceToken(String uid) async {
    await firebaseFirestore
        .collection(USER_COLLECTION)
        .doc(uid)
        .update({'deviceToken': FirebaseMessages().fcmToken});
  }

  // Future<void> addMessageToChat(String chatId, ChatMessage message) async {
  //   try {
  //     await firebaseFirestore
  //         .collection(CHAT_COLLECTION)
  //         .doc(chatId)
  //         .collection(MESSAGE_COLLECTION)
  //         .add(message.toJson());
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> updateChatData(String chatId, Map<String, dynamic> data) async {
    try {
      await firebaseFirestore
          .collection(CHAT_COLLECTION)
          .doc(chatId)
          .update(data);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteChat(chatId) async {
    try {
      await firebaseFirestore.collection(CHAT_COLLECTION).doc(chatId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<QuerySnapshot> getUsers(String? name, String uid) {
    Query query = firebaseFirestore.collection(USER_COLLECTION);

    if (name != null) {
      query = query
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThanOrEqualTo: name + 'z');
    }
    return query.get();
    // return query.snapshots();
  }

  Future<DocumentReference?> createChat(Map<String, dynamic> _data) async {
    try {
      DocumentReference _chat =
          await firebaseFirestore.collection(CHAT_COLLECTION).add(_data);
      return _chat;
    } catch (e) {
      print(e);
    }
  }
}
