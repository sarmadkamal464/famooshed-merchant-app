import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/data/models/chat_model.dart';
import 'package:famooshed_vendor/app/modules/chat_module/chat_controller.dart';
import 'package:famooshed_vendor/app/utils/common_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/values/app_icons.dart';
import '../../routes/app_pages.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_text_field_widget.dart';
import 'firebase_chat_serivice/firebase_database_service.dart';

class ChatPage extends GetView<ChatController> {
  ChatPage({required this.isHideAppBar});

  bool isHideAppBar;
  String uID = '';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder(
      initState: (state) {
        uID = Storage.getValue(Constants.uID);
        print(uID);
      },
      builder: (ChatController chatController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: isHideAppBar ? null : CustomAppbarWidget(title: "Chat"),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(12),
                    vertical: getProportionateScreenHeight(12)),
                child: CustomTextFieldWidget(
                  controller: chatController.searchController,
                  prefixIconPadding: const EdgeInsets.only(left: 15, right: 10),
                  prefixIcon: SvgPicture.asset(AppIcons.search),
                  obscureText: false,
                  onChanged: (value) {
                    if (value == null || value.isEmpty) {
                      chatController.isSearch.value = false;
                    } else {
                      chatController.isSearch.value = true;
                    }
                    chatController.update();
                    chatController.getResultList(value);
                  },
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(color: AppColors.appTheme)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chatController.isSearch.value
                      ? chatController.searchUsersList.length
                      : chatController.usersList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ChatUser user = chatController.isSearch.value
                        ? chatController.searchUsersList[index]
                        : chatController.usersList[index];

                    String groupChatId = '';
                    String uID = Storage.getValue(Constants.uID);

                    // groupChatId = '$uID-${user.id.toString()}';
                    //
                    if (uID.hashCode <= user.id.toString().hashCode) {
                      groupChatId = '$uID-${user.id.toString()}';
                    } else {
                      groupChatId = '${user.id.toString()}-$uID';
                    }

                    // FirebaseFirestore.instance
                    //     .collection(MESSAGE_COLLECTION)
                    //     .doc(groupChatId)
                    //     .collection(groupChatId)
                    //     .get()
                    //     .then((value2) {
                    //   if (value2.docs.isNotEmpty) {
                    //     for (var element in value2.docs) {
                    //       if (element.get('idTo') == uID &&
                    //           element.get('idToStatus') ==
                    //               Constants.delivered) {
                    //         chatController.count = chatController.count + 1;
                    //       }
                    //     }
                    //   }
                    // });
                    // dprint("Group" + groupChatId);
                    return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12),
                          vertical: getProportionateScreenHeight(5)),
                      decoration: BoxDecoration(),
                      child: ListTile(
                        onTap: () async {
                          String uID = Storage.getValue(Constants.uID);
                          print(uID);

                          Get.toNamed(Routes.CHAT_MESSAGE_SCREEN,
                              arguments: user);
                        },
                        // tileColor: Colors.lightGreen,
                        style: ListTileStyle.list,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.appTheme),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16),
                            vertical: getProportionateScreenHeight(2)),
                        minLeadingWidth: getProportionateScreenWidth(8),
                        leading: SizedBox(
                          height: getProportionateScreenHeight(50),
                          width: getProportionateScreenWidth(50),
                          child: CachedNetworkImage(
                            imageUrl: getImageUrl(user.image),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: getProportionateScreenHeight(50),
                                width: getProportionateScreenWidth(50),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      image: imageProvider,
                                      fit: BoxFit.fill),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                height: getProportionateScreenHeight(50),
                                width: getProportionateScreenWidth(50),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.error,
                                ),
                              );
                            },
                          ),
                        ),
                        title: Text(
                          (user.name?.capitalize ?? '-'),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionalFontSize(13),
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(MESSAGE_COLLECTION)
                              .doc(groupChatId)
                              .collection(groupChatId)
                              .where("idTo", isEqualTo: uID)
                              .where("idToStatus",
                                  isEqualTo: Constants.delivered)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return snapshot.data!.docs.isNotEmpty
                                  ? Container(
                                      alignment: Alignment.center,
                                      height: getProportionateScreenHeight(20),
                                      width: getProportionateScreenWidth(20),
                                      decoration: BoxDecoration(
                                        color: AppColors.appTheme,
                                        shape: BoxShape.circle,
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          "${snapshot.data!.docs.length.toString()}",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            else {
                              return SizedBox();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Container(
// alignment: Alignment.center,
// height: getProportionateScreenHeight(20),
// width: getProportionateScreenWidth(20),
// decoration: BoxDecoration(
// color: AppColors.appTheme,
// shape: BoxShape.circle,
// ),
// child: FittedBox(
// child: Text(
// "${0}",
// style: TextStyle(
// color: Colors.white,
// ),
// ),
// ),
// )
