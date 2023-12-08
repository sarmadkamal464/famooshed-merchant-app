import 'dart:developer';

import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/util/exports.dart';
import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../data/models/get_profile_response.dart';
import '../../routes/app_pages.dart';
import '../../utils/dprint.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyProfileController extends GetxController {
  GetProfileResponse? getProfileResponse;
  @override
  void onReady() {
    getProfile();
    super.onReady();
  }

  @override
  void onClose() {
    dprint('Profile Controller Closed');
    super.onClose();
  }

  dynamic showAppBar = Get.arguments ?? false;

  RxBool isLoading = true.obs;
  final ApiHelper _apiHelper = ApiHelper.to;

  getProfile() async {
    var userId = await Storage.getValue(Constants.uID);

    _apiHelper.postApi("${AppUrl.getProfile}$userId", {}).futureValue(
      (value) {
        try {
          getProfileResponse = GetProfileResponse.fromJson(value);
          isLoading.value = false;

          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: getProfile,
    );
  }

  deleteProfile() async {
    LoadingDialog.showLoadingDialog();
    try {
      var userId = await Storage.getValue(Constants.uID);

      Response response =
          await _apiHelper.postApi("${AppUrl.customerDelete}", {"id", userId});
      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        await Storage.clearStorage();
        Get.offAllNamed(Routes.SIGN_IN);
      }
    } catch (e) {
      print(e);
      LoadingDialog.closeLoadingDialog();
    }
    // _apiHelper
    //     .postApi(
    //   "${AppUrl.customerDelete}",{"id",userId}
    // )
    //     .futureValue(
    //   (value) {
    //     try {
    //       getProfileResponse = GetProfileResponse.fromJson(value);
    //       isLoading.value = false;
    //
    //       update();
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //   },
    //   retryFunction: deleteProfile,
    // );
  }

  changeProfile() async {
    LoadingDialog.showLoadingDialog();

    try {
      var body = {
        "is_stripe_connected": 1,
      };

      Response response = await _apiHelper.postApi(AppUrl.changeProfile, body);

      if (response.statusCode == 200) {
        dprint(response.body);
        getProfile();
        update();
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }
}
