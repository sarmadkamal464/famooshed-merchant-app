import 'dart:developer';

import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:get/get.dart';

import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../data/models/wallet_response.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class WalletController extends GetxController {
  RxBool isLoading = true.obs;

  // GetFoodListResponse? getFoodListResponse;

  @override
  void onReady() {
    getOwnerWallet();
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;
  RxString totalEarning = "".obs;
  RxString lastWeek = "".obs;
  RxString thisWeek = "".obs;
  RxString todayEarning = "".obs;
  RxString currency = "".obs;
  final RxList<Iorder> _orderList = RxList();
  List<Iorder> get orderList => _orderList;
  set orderList(List<Iorder> orderList) => _orderList.addAll(orderList);

  getOwnerWallet() {
    _apiHelper.getApi(AppUrl.ownerWallet).futureValue(
      (value) {
        try {
          var getOwnerWalletResponse = GetOwnerWalletResponse.fromJson(value);
          totalEarning.value =
              getOwnerWalletResponse.earning.toStringAsFixed(2).toString();
          todayEarning.value = getOwnerWalletResponse.currentdayearning
              .toStringAsFixed(2)
              .toString();
          lastWeek.value = getOwnerWalletResponse.lastweekearning
              .toStringAsFixed(2)
              .toString();
          thisWeek.value = getOwnerWalletResponse.currentweekearning
              .toStringAsFixed(2)
              .toString();
          if (orderList.isNotEmpty) {
            orderList.clear();
            orderList = getOwnerWalletResponse.iorders;
          } else {
            orderList = getOwnerWalletResponse.iorders;
          }

          dprint(totalEarning.value);
          dprint(todayEarning.value);
          dprint(lastWeek.value);
          dprint(thisWeek.value);
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        isLoading.value = false;
        update();
      },
      retryFunction: getOwnerWallet,
    );
  }

  withdrawalRequest() async {
    LoadingDialog.showLoadingDialog();

    try {
      Response response = await _apiHelper
          .postApi(AppUrl.withdrawalRequest, {'balance': lastWeek.value});

      if (response.statusCode == 200) {
        if (response.body['error'] == '0') {
          LoadingDialog.closeLoadingDialog();
          Utils.showSnackbar(
              response.body['message'] ?? "Something went wrong!!!");
          getOwnerWallet();
        } else {
          LoadingDialog.closeLoadingDialog();
          Utils.showSnackbar(
              response.body['message'] ?? "Something went wrong!!!");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  getWallet() async {
    LoadingDialog.showLoadingDialog();

    try {
      Response response = await _apiHelper.postApi(AppUrl.walletgb, {});

      if (response.statusCode == 200) {
        if (response.body['error'] == 0) {
          Utils.showSnackbar(
              response.body['message'] ?? "Something went wrong!!!");
          LoadingDialog.closeLoadingDialog();
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }
}
