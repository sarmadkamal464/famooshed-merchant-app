import 'dart:developer';

import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/get_my_driver_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/values/app_url.dart';

class MyDriversController extends GetxController {
  @override
  void onReady() {
    getMyDrivers(true);
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;
  final RxList<Driver> _driverList = RxList();
  List<Driver> get driverList => _driverList;
  set driverList(List<Driver> driverList) => _driverList.addAll(driverList);

  final RxList<Areawork> _areaWorkList = RxList();
  List<Areawork> get areaWorkList => _areaWorkList;
  set areaWorkList(List<Areawork> areaList) => _areaWorkList.addAll(areaList);

  RxBool isLoading = true.obs;

  TextEditingController searchController = TextEditingController();
  RxBool sortOnline = RxBool(true);
  RxBool sortOffline = RxBool(true);
  getMyDrivers(bool showLoader) async {
    if (showLoader) {
      LoadingDialog.showLoadingDialog();
    }
    try {
      Response value = await _apiHelper.postApi(AppUrl.driversList, {
        "driver_type": 'merchant',
        "search": searchController.text,
        "sortOnline": sortOnline.value ? 1 : 0,
        "sortOffline": sortOffline.value ? 1 : 0,
      });
      if (value.statusCode == 200) {
        var response = GetMyDriverResponse.fromJson(value.body);
        driverList.clear();

        if (response.driversAll != null && response.driversAll!.isNotEmpty) {
          driverList = response.driversAll ?? [];
        }
        if (response.areawork != null && response.areawork!.isNotEmpty) {
          areaWorkList = response.areawork ?? [];
        }
        // if (driverList.isNotEmpty) {
        //   driverList.clear();
        //   driverList = response.driversAll ?? [];
        // } else {
        //   driverList = response.driversAll ?? [];
        // }
      }
    } catch (e, trace) {
      if (showLoader) {
        LoadingDialog.closeLoadingDialog();
      }
      log(e.toString(), stackTrace: trace);
    }
    if (showLoader) {
      LoadingDialog.closeLoadingDialog();
    }
    isLoading.value = false;
    update();
  }

  RxList<int> selectedCategory = <int>[].obs;
  deleteNotification() {
    if (selectedCategory.isNotEmpty) {
      var list = selectedCategory.join(",");
      _apiHelper.postApi("${""}?id=$list", {}).futureValue(
        (value) {
          selectedCategory.value = [];
          update();
        },
        retryFunction: deleteNotification,
      );
    } else {}
  }
}
