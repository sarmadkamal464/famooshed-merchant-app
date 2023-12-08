import 'dart:developer';

import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../data/models/my_stall_response.dart';

class MyStallController extends GetxController {
  RxBool isLoading = true.obs;
  dynamic args = Get.arguments;

  GetMyStallResponse? getMyStallResponse;

  @override
  void onReady() {
    getMyStall();
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;

  getMyStall() async {
    // LoadingDialog.showLoadingDialog();
    try {
      Response response = await _apiHelper.postApi(AppUrl.restaurantsList, {});
      if (response.statusCode == 200) {
        getMyStallResponse = GetMyStallResponse.fromJson(response.body);
        isLoading.value = false;
        update();
      }
    } catch (e, trace) {
      isLoading.value = false;
      update();
      // LoadingDialog.closeLoadingDialog();
      log(e.toString(), stackTrace: trace);
    }
    isLoading.value = false;
    update();
    // LoadingDialog.closeLoadingDialog();

    // _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
    //   (value) {
    //     try {
    //       getMyStallResponse = GetMyStallResponse.fromJson(value);
    //       isLoading.value = false;
    //       update();
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //   },
    //   retryFunction: getMyStall,
    // );
  }

  void goToSettings() {
    _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
      (value) {
        try {
          GetMyStallResponse getMyStallResponse =
              GetMyStallResponse.fromJson(value);
          if (getMyStallResponse.restaurants.isNotEmpty) {
            Get.toNamed(Routes.EDIT_INFORMATION,
                arguments: getMyStallResponse.restaurants[0].id);
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        isLoading.value = false;
        update();
      },
      retryFunction: getMyStall,
    );
  }
}
