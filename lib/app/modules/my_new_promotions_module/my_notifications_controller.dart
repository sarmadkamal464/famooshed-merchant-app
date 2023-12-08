import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/get_notification_response.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNotificationsController extends GetxController {
  @override
  void onReady() {
    getAllNotification(true);
    super.onReady();
  }

  @override
  void onInit() {
    // listController.dispose();

    // listController ??= ScrollController(
    //   keepScrollOffset: true,
    // )..addListener(() {
    //     if (listController!.position.pixels ==
    //         listController!.position.maxScrollExtent) {
    //       print("Listen");
    //       loadNextPage();
    //     }
    //   });

    super.onInit();
  }

  @override
  void dispose() {
    print("DISPOSE");
    // listController!.dispose();
    super.dispose();
  }

  dynamic args = Get.arguments;

  final _apiHelper = ApiHelper.to;
  final RxList<NotoficationDataItem> _notificationList = RxList();
  List<NotoficationDataItem> get notificationList => _notificationList;
  set notificationList(List<NotoficationDataItem> notificationList) =>
      _notificationList.addAll(notificationList);

  List<NotoficationDataItem> filterNotificationList = [];
  final RxList<NotificationDriverUser> _userList = RxList();
  List<NotificationDriverUser> get userList => _userList;
  set userList(List<NotificationDriverUser> userList) =>
      _userList.addAll(userList);

  RxBool isLoading = true.obs;

  RxList<int> selectedCategory = <int>[].obs;

  int currentPageNo = 1;
  int lastPage = 1;
  // ScrollController listController = ScrollController();
  // ScrollController? listController;

  getAllNotification(bool isShowLoader) async {
    if (isShowLoader) {
      LoadingDialog.showLoadingDialog();
    }
    try {
      Response response = await _apiHelper
          .getApi(AppUrl.notifications + "?page=$currentPageNo");
      if (response.statusCode == 200) {
        GetNotificationResponse res =
            GetNotificationResponse.fromJson(response.body);
        if (currentPageNo == 1) {
          notificationList.clear();
          filterNotificationList.clear();
        }
        userList.clear();

        if (res.idata != null &&
            res.idata!.data != null &&
            res.idata!.data!.isNotEmpty) {
          notificationList.addAll(res.idata!.data!);
        }
        if (res.iusers != null && res.iusers!.isNotEmpty) {
          userList = res.iusers!;
        }
        // = notificationList;
      }
    } catch (e) {
      dprint(e);
      if (isShowLoader) {
        LoadingDialog.closeLoadingDialog();
      }
    }
    update();
    if (isShowLoader) {
      LoadingDialog.closeLoadingDialog();
    }
    //
    // _apiHelper.getApi(AppUrl.notifications).futureValue(
    //   (value) {
    //     try {
    //       GetNotificationResponse res = GetNotificationResponse.fromJson(value);
    //
    //       if (res.idata != null) {
    //         notificationList.clear();
    //         userList.clear();
    //         if (res.idata != null && res.idata!.isNotEmpty) {
    //           notificationList = res.idata!;
    //         }
    //         if (res.iusers != null && res.iusers!.isNotEmpty) {
    //           userList = res.iusers!;
    //         }
    //       }
    //       // if (notificationList.isNotEmpty) {
    //       //   notificationList.clear();
    //       //   notificationList = res.idata.data;
    //       //   res.
    //       // } else {
    //       //   notificationList = res.notoficationData.notoficationDataItem;
    //       // }
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //     isLoading.value = false;
    //     update();
    //   },
    //   retryFunction: getAllNotification,
    // );
  }

  deleteNotification() {
    if (selectedCategory.isNotEmpty) {
      var list = selectedCategory.join(",");
      _apiHelper.postApi(AppUrl.notifydelete, {"ids": list}).futureValue(
        (value) {
          selectedCategory.value = [];
          currentPageNo = 1;
          update();
          getAllNotification(true);
          // update();
        },
        retryFunction: deleteNotification,
      );
    } else {}
  }

  void loadNextPage() {
    currentPageNo = currentPageNo + 1;
    update();
    getAllNotification(false);
  }

  RxBool isSearch = RxBool(false);
  TextEditingController searchController = TextEditingController();
  getFilterNotificationList(String? text) {
    filterNotificationList.clear();
    if (isSearch.value) {
      notificationList.forEach((element) {
        if (element.title != null && element.title!.isNotEmpty) {
          if (element.title != null &&
                  element.title!.toUpperCase().contains(text!) ||
              element.title != null &&
                  element.title!.toLowerCase().contains(text!)) {
            filterNotificationList.add(element);
          }
        }
      });
    }
    update();
  }
}
