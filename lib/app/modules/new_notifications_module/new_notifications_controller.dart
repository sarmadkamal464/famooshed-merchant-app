import 'dart:convert';
import 'dart:io';

import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/get_notification_response.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import '../../common/constants.dart';
import '../../common/util/loading_dialog.dart';
import '../../data/models/upload_image_response.dart';
import '../my_new_promotions_module/my_notifications_controller.dart';

class NewNotificationsController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    var args = Get.arguments;
    edit = args['edit'];
    editId = args['editId'];

    // if (edit == '1') {
    //   notificationDataItem = args['notification'];
    //   if (notificationDataItem.id != null) {
    //     titleController.text = notificationDataItem.title ?? '';
    //     scheduleController.text = DateTime.parse(
    //             notificationDataItem.scheduleTime ?? DateTime.now().toString())
    //         .formatedDate(dateFormat: "yyyy-MM-ddThh:mm")
    //         .toString();
    //     descriptionContoller.text = notificationDataItem.text ?? '';
    //   }
    // }
    MyNotificationsController myNewPromotionsController =
        Get.find<MyNotificationsController>();
    usersList.clear();
    if (edit != '1') {
      usersList.add(NotificationDriverUser(id: -1, name: "Send To All Users"));
    }
    usersList.addAll(myNewPromotionsController.userList);
    print(usersList.length);
    selectedUser = usersList[0];

    if (edit == '1') {
      notificationDataItem = args['notification'];
      if (notificationDataItem.id != null) {
        titleController.text = notificationDataItem.title ?? '';
        descriptionContoller.text = notificationDataItem.text ?? '';
        scheduleController.text = DateTime.parse(
                notificationDataItem.scheduleTime ?? DateTime.now().toString())
            .formatedDate(dateFormat: "yyyy-MM-ddThh:mm")
            .toString();
        editImageId = notificationDataItem.image ?? '';
        editImageUrl = notificationDataItem.imageName ?? '';
        usersList.forEach((element) {
          if (element.id == notificationDataItem.user) {
            selectedUser = element;
          }
        });
      }
    } else {
      scheduleController.text = DateTime.parse(
              notificationDataItem.scheduleTime ?? DateTime.now().toString())
          .formatedDate(dateFormat: "yyyy-MM-ddThh:mm")
          .toString();
    }
    update();
    super.onInit();
  }

  final _apiHelper = ApiHelper.to;

  File? addNewFile;

  List<NotificationDriverUser> usersList = [];
  // List<String> usersListString = ['Send To All Users'];
  NotificationDriverUser selectedUser = NotificationDriverUser();
  String selectedUserId = '';

  String edit = '';
  String editId = '';
  NotoficationDataItem notificationDataItem = NotoficationDataItem();
  DateTime selectedDateTime = DateTime.now();
  String editImageId = '';
  String editImageUrl = '';

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionContoller = TextEditingController();
  TextEditingController scheduleController = TextEditingController();

  sendNotification() async {
    if (titleController.text.isEmpty) {
      Utils.showSnackbar("Notification title can't be empty");
      return;
    }
    if (descriptionContoller.text.isEmpty) {
      Utils.showSnackbar("Description Can't be empty");
      return;
    }
    if (scheduleController.text.isEmpty) {
      Utils.showSnackbar("Schedule Can't be empty");
      return;
    }
    if (editImageId.isEmpty) {
      Utils.showSnackbar("Image Can't be empty");
      return;
    }
    LoadingDialog.showLoadingDialog();

    try {
      // String uploadedImageId = '';
      // img.Image? image =
      //     img.decodeImage(File(addNewFile!.path).readAsBytesSync());
      // img.Image thumbnail = img.copyResize(image!, width: 1000);
      // File(addNewFile!.path).writeAsBytesSync(img.encodeJpg(thumbnail));
      // var formData = FormData({
      //   "file": MultipartFile(
      //     addNewFile!.path,
      //     filename: addNewFile!.path,
      //   ),
      // });
      // Response imageResponse =
      //     await _apiHelper.postApi(AppUrl.uploadImage, formData);
      // if (imageResponse.statusCode == 200) {
      //   var response = UploadImageResponse.fromJson(imageResponse.body);
      //   uploadedImageId = response.id.toString();
      // }
      var body = {
        'edit': edit,
        'editId': editId,
        'user': selectedUser.id.toString(),
        'title': titleController.text,
        'text': descriptionContoller.text,
        'schedule_time': scheduleController.text,
        'imageid': editImageId
      };
      Response response =
          await _apiHelper.postApi(AppUrl.sendNotifications, body);

      if (response.statusCode == 200) {
        // MyNewPromotionsController().getAllNotification();
        // MyNewPromotionsController().update();
        MyNotificationsController newPromotionsController =
            Get.find<MyNotificationsController>();

        newPromotionsController.currentPageNo = 1;
        newPromotionsController.update();
        newPromotionsController.getAllNotification(true);
        newPromotionsController.update();

        // if (selectedUser.fcbToken != null &&
        //     selectedUser.fcbToken!.isNotEmpty) {
        //   String merchantName = Storage.getValue(Constants.name) ?? 'Merchant';
        //   var mapNotification = <String, dynamic>{};
        //   mapNotification['data'] = {
        //     'title': merchantName,
        //     'body': titleController.text,
        //   };
        //   mapNotification["notification"] = {
        //     "title": merchantName,
        //     "body": titleController.text,
        //     // "android": {
        //     //   "notification": {
        //     //     "imageUrl":
        //     //         "https://upload.wikimedia.org/wikipedia/commons/f/f9/Phoenicopterus_ruber_in_S%C3%A3o_Paulo_Zoo.jpg"
        //     //   }
        //     // }
        //   };
        //   mapNotification["priority"] = "high";
        //   mapNotification['to'] = selectedUser.fcbToken;
        //   // mapNotification['to'] =
        //   //     "cm7h_xhsRcCqeGrSgxAoaa:APA91bEYdu5muOK0ZPPCMyYr6w2pTwWco-oAAd6Uk1atqTr5FBuQx5YjqOWSQ9zCHNFRnDlekEJiBWi9dQUw7vpQN4BK9daPf66P47BONC1wgEpC7mCQsdBol7p01HpPBuLb3U1Jo33Y";
        //
        //   sendPushNotification(mapNotification);
        // }

        LoadingDialog.closeLoadingDialog();

        Get.back();

        Utils.showSnackbar("Notification created successfully");
      }
    } catch (e) {
      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
  }

  //Send fcm notification
  Future<bool> sendPushNotification(Map data) async {
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

  String productImageUrl = "";
  int productImageId = 0;
  uploadProductImage(
    imagePath,
  ) async {
    LoadingDialog.showLoadingDialog();

    try {
      img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());
      img.Image thumbnail = img.copyResize(image!, width: 1000);
      File(imagePath).writeAsBytesSync(img.encodeJpg(thumbnail));
      var formData = FormData({
        "file": MultipartFile(
          imagePath,
          filename: imagePath,
        ),
      });

      Response response =
          await _apiHelper.postApi(AppUrl.uploadImage, formData);
      if (response.statusCode == 200) {
        if (response.body['error'] == '0') {
          var uResponse = UploadImageResponse.fromJson(response.body);
          productImageId = uResponse.id;
          productImageUrl = Constants.imgUrl + uResponse.filename;

          editImageId = uResponse.id.toString();
          editImageUrl = uResponse.filename;
          // getFoodDetailResponse.image = uResponse.filename;
        }
      }
    } catch (e) {
      dprint(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }
}
