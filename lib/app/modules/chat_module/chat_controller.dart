import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famooshed_vendor/app/data/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import 'firebase_chat_serivice/firebase_database_service.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class ChatController extends GetxController {
  @override
  void onReady() {
    getChats();
    super.onReady();
  }

  TextEditingController searchController = TextEditingController();
  final _apiHelper = ApiHelper.to;

  List<ChatUser> usersList = [];
  List<ChatUser> searchUsersList = [];

  getChats() {
    _apiHelper
        .getApi(
      AppUrl.chatUsers,
    )
        .futureValue(
      (value) async {
        print(value);
        usersList.clear();

        try {
          if (value['error'] == '0') {
            if (value['users'] != null) {
              List data = value['users'];
              data.forEach((element) {
                usersList.add(ChatUser.fromJson(element));
              });
            }
            update();
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: getChats,
    );
  }

  String groupChatId = "";
  String peerToken = "";

  String uId = "";
  String peerId = "";

  int limit = 20;
  final int limitIncrement = 20;

  late ScrollController listScrollController;

  TextEditingController textEditingController = TextEditingController();

  scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      limit += limitIncrement;
      update();
    }
  }

  void initMethod(ChatUser chatUser) {
    String uID = Storage.getValue(Constants.uID);

    // groupChatId = '$uID-${chatUser.id.toString()}';
    if (uID.hashCode <= chatUser.id.toString().hashCode) {
      groupChatId = '$uID-${chatUser.id.toString()}';
    } else {
      groupChatId = '${chatUser.id.toString()}-$uID';
    }

    uId = uID;
    peerId = chatUser.id.toString();

    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(uID)
        .update({'chattingWith': chatUser.id.toString()});
    FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc(chatUser.id.toString())
        .get()
        .then((value) => {
              if (value.data()!.containsKey("deviceToken"))
                {
                  peerToken = value.get("deviceToken"),
                  debugPrint("Token" + peerToken)
                }
            });
  }

  void markAllMessageToSeen() {
    // update all unseen to seen

    FirebaseFirestore.instance.collection(USER_COLLECTION).get().then((value) {
      print(value.docs.length);
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if (element['chattingWith'] != null &&
              element['chattingWith'] == uId) {
            FirebaseFirestore.instance
                .collection(MESSAGE_COLLECTION)
                .doc(groupChatId)
                .collection(groupChatId)
                .get()
                .then((value2) {
              if (value2.docs.isNotEmpty) {
                for (var element in value2.docs) {
                  if (element.get('idTo') == uId) {
                    FirebaseFirestore.instance
                        .collection(MESSAGE_COLLECTION)
                        .doc(groupChatId)
                        .collection(groupChatId)
                        .doc(element.id)
                        .update({'idToStatus': Constants.seen});
                  }
                }
              }
            });
          }
        }
      }
    });
  }

  void sendMessage(ChatUser chatUser) {
    //Send message
    if (textEditingController.text.isNotEmpty) {
      var mapData = <String, Object>{};
      //original
      mapData['idFrom'] = uId;
      mapData['idTo'] = peerId;
      mapData['idFromStatus'] = Constants.seen;
      mapData['idToStatus'] = Constants.delivered;
      mapData['timestamp'] = DateTime.now().millisecondsSinceEpoch;
      mapData['content'] = textEditingController.text;

      var documentReference = FirebaseFirestore.instance
          .collection(MESSAGE_COLLECTION)
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(documentReference, mapData);
      });

      // Update message status

      FirebaseFirestore.instance
          .collection(USER_COLLECTION)
          .get()
          .then((value) {
        print(value.docs.length);
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            if (element['chattingWith'] != null &&
                element['chattingWith'] == uId) {
              FirebaseFirestore.instance
                  .collection(MESSAGE_COLLECTION)
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .get()
                  .then((value2) {
                if (value2.docs.isNotEmpty) {
                  for (var element in value2.docs) {
                    FirebaseFirestore.instance
                        .collection(MESSAGE_COLLECTION)
                        .doc(groupChatId)
                        .collection(groupChatId)
                        .doc(element.id)
                        .update({'idToStatus': Constants.seen});
                  }
                }
              });
            }
          }
        }
      });

      // Notification

      String name = Storage.getValue(Constants.name) ?? '';

      String image = Storage.getValue(Constants.image) ?? '';

      ChatUser user = ChatUser();
      user.id = int.parse(uId);
      user.name = name;
      // user.image = image;

      var mapNotification = <String, dynamic>{};
      mapNotification['data'] = {
        'title': name,
        'body': textEditingController.text,
        'status': 'chat',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'userObject': user.toJson(),
      };
      mapNotification["notification"] = {
        "title": name,
        "body": textEditingController.text,
        // "android": {
        //   "notification": {
        //     "imageUrl":
        //         "https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg"
        //   }
        // }
      };
      mapNotification["priority"] = "high";
      mapNotification['to'] = peerToken;
      // mapNotification['to'] =
      //     "cm7h_xhsRcCqeGrSgxAoaa:APA91bEYdu5muOK0ZPPCMyYr6w2pTwWco-oAAd6Uk1atqTr5FBuQx5YjqOWSQ9zCHNFRnDlekEJiBWi9dQUw7vpQN4BK9daPf66P47BONC1wgEpC7mCQsdBol7p01HpPBuLb3U1Jo33Y";
      textEditingController.clear();

      sendNotification(mapNotification);
    } else {
      textEditingController.clear();
    }
  }

  //Send fcm notification
  Future<bool> sendNotification(Map data) async {
    Uri myUri = Uri.parse("https://fcm.googleapis.com/fcm/send");
    final client = http.Client();
    final response = await client.post(myUri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'key=${Constants.FIREBASE_SERVER_KEY}'
        },
        body: json.encode(data));

    return response.statusCode == 200;
  }

  RxBool isSearch = RxBool(false);
  void getResultList(String? text) {
    searchUsersList.clear();
    if (text != null && text.isNotEmpty) {
      usersList.forEach((element) {
        if (element.name != null && element.name!.isNotEmpty) {
          if (element.name!.toUpperCase().contains(text) ||
              element.name!.toLowerCase().contains(text)) {
            searchUsersList.add(element);
          }
        }
      });
    }
    update();
  }
}
