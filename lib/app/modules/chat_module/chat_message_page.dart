import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/data/models/chat_model.dart';
import 'package:famooshed_vendor/app/modules/chat_module/chat_controller.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/values/app_colors.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_text_field.dart';
import 'firebase_chat_serivice/firebase_database_service.dart';

class ChatMessagePage extends GetView<ChatController> {
  ChatMessagePage();

  ChatUser chatUser = ChatUser();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder(
      initState: (state) {
        dprint("Init Called");
        chatUser = Get.arguments as ChatUser;

        print("CHATUSER:" + chatUser.id.toString());
        print("CHATUSER:" + chatUser.name.toString());

        controller.listScrollController = ScrollController();
        controller.listScrollController.addListener(controller.scrollListener);

        controller.initMethod(chatUser);
        controller.markAllMessageToSeen();
      },
      dispose: (state) {
        controller.listScrollController.dispose();
        FirebaseFirestore.instance
            .collection(USER_COLLECTION)
            .doc(controller.uId)
            .update({'chattingWith': ""});
      },
      builder: (ChatController chatController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppbarWidget(
            title: chatUser.name?.capitalize,
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(MESSAGE_COLLECTION)
                      .doc(controller.groupChatId)
                      .collection(controller.groupChatId)
                      .orderBy('timestamp', descending: true)
                      .limit(chatController.limit)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          Widget dateTitle = const SizedBox();
                          if (index < snapshot.data!.docs.length - 1) {
                            DateTime dateAfter =
                                DateTime.fromMillisecondsSinceEpoch(snapshot
                                    .data!.docs[index + 1]['timestamp']);
                            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                                snapshot.data!.docs[index]['timestamp']);

                            if (dateAfter.day != date.day) {
                              dateTitle = Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(10)),
                                child: Text(
                                  DateFormat("dd/MM/yyyy").format(date),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: getProportionalFontSize(12),
                                  ),
                                ),
                              );
                            }
                          } else {
                            dateTitle = Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(10)),
                              child: Text(
                                DateFormat('dd/MM/yyyy').format(
                                    DateTime.fromMillisecondsSinceEpoch(snapshot
                                        .data!.docs[index]['timestamp'])),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionalFontSize(12),
                                ),
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment:
                                snapshot.data?.docs[index].get('idFrom') ==
                                        chatController.uId
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Center(child: dateTitle),
                              snapshot.data?.docs[index].get('idFrom') ==
                                      chatController.uId
                                  ? SenderChatTile(
                                      doc: snapshot.data?.docs[index],
                                    )
                                  : ReceiverChatTile(
                                      doc: snapshot.data?.docs[index],
                                    )
                            ],
                          );
                          Column(
                            crossAxisAlignment:
                                snapshot.data?.docs[index].get('idFrom') ==
                                        chatController.uId
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Center(child: dateTitle),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(16),
                                  vertical: getProportionateScreenHeight(5),
                                ),
                                padding: EdgeInsets.all(8),
                                width: SizeConfig.deviceWidth! * .65,
                                decoration: BoxDecoration(
                                  // color: Color(0xff02A83D),
                                  color: snapshot.data?.docs[index]
                                              .get('idFrom') ==
                                          chatController.uId
                                      ? Color(0xFFEBF9DC)
                                      : Color(0xFFF4F4F4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data?.docs[index].get("content"),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(5),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${DateFormat("h:mm aa").format(DateTime.fromMillisecondsSinceEpoch(snapshot.data?.docs[index].get('timestamp'))).toString()}",
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionalFontSize(11)),
                                        ),
                                        // SizedBox(
                                        //   width: getProportionateScreenWidth(7),
                                        // ),
                                        snapshot.data?.docs[index]
                                                    .get('idFrom') ==
                                                chatController.uId
                                            ? snapshot.data?.docs[index]
                                                        .get("idToStatus") ==
                                                    Constants.seen
                                                ? Icon(
                                                    Icons.done_all,
                                                    color: Colors.blue,
                                                    size: 16,
                                                  )
                                                : Icon(
                                                    Icons.done_all,
                                                    color: Colors.grey,
                                                    size: 16,
                                                  )
                                            : SizedBox()
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: snapshot.data?.docs.length,
                        reverse: true,
                        controller: chatController.listScrollController,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(16),
                    0,
                    getProportionateScreenWidth(16),
                    getProportionateScreenHeight(15)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "",
                        hintText: "Start typing here",
                        textEditingController:
                            chatController.textEditingController,
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    InkWell(
                      onTap: () {
                        chatController.sendMessage(chatUser);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.send, color: AppColors.appTheme),
                      ),
                    ),
                  ],
                ),
              )
              // ElevatedButton(
              //     onPressed: () {
              //       // chatController.sendMessage();
              //     },
              //     child: Text("Send text"))
            ],
          ),
        );
      },
    );
  }
}

class SenderChatTile extends StatelessWidget {
  SenderChatTile({
    this.doc,
  });
  QueryDocumentSnapshot<Object?>? doc;
  @override
  Widget build(BuildContext context) {
    return doc != null
        ? Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16),
              vertical: getProportionateScreenHeight(5),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(8),
            ),
            width: SizeConfig.deviceWidth! * .65,
            decoration: BoxDecoration(
              color: Color(0xFFEBF9DC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc!.get("content"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${DateFormat("h:mm aa").format(DateTime.fromMillisecondsSinceEpoch(doc!.get('timestamp'))).toString()}",
                      style: TextStyle(fontSize: getProportionalFontSize(11)),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(7),
                    ),
                    doc!.get("idToStatus") == Constants.seen
                        ? Icon(
                            Icons.done_all,
                            color: Colors.blue,
                            size: 16,
                          )
                        : Icon(
                            Icons.done_all,
                            color: Colors.grey,
                            size: 16,
                          )
                  ],
                )
              ],
            ),
          )
        : SizedBox();
  }
}

class ReceiverChatTile extends StatelessWidget {
  ReceiverChatTile({this.doc});
  QueryDocumentSnapshot<Object?>? doc;
  @override
  Widget build(BuildContext context) {
    return doc != null
        ? Container(
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(16),
              vertical: getProportionateScreenHeight(5),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(8),
              vertical: getProportionateScreenHeight(8),
            ),
            width: SizeConfig.deviceWidth! * .65,
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc!.get("content"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${DateFormat("h:mm aa").format(DateTime.fromMillisecondsSinceEpoch(doc!.get('timestamp'))).toString()}",
                      style: TextStyle(fontSize: getProportionalFontSize(11)),
                    ),
                  ],
                )
              ],
            ),
          )
        : SizedBox();
  }
}
