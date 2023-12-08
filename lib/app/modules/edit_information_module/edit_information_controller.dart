import 'dart:developer';

import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/my_stall_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/loading_dialog.dart';
import '../../data/models/get_food_cat_list.dart';
import '../../utils/dprint.dart';

class EditInformationController extends GetxController {
  RxBool isLoading = true.obs;

  // GetFoodListResponse? getFoodListResponse;
  var restaurantId = Get.arguments;
  // GetMyStallResponse? getMyStallResponse;

  TextEditingController deliverAreaController = TextEditingController();
  TextEditingController minFeeController = TextEditingController();

  RxString userId = "".obs;

  //famooshed Delivery Driver
  RxBool famooshedDeliveryDriver = false.obs;
  RxBool famooshedDeliveryDriverPercentValue = true.obs;
  RxBool famooshedDeliveryDriverPerKmValue = false.obs;
  TextEditingController deliverFeeController = TextEditingController();

  // pickUp
  RxBool pickUpSub1 = false.obs;

  // nextDay
  TextEditingController nextDayFeeController = TextEditingController();
  RxBool nextDaySub1 = false.obs;

  //home delivery
  TextEditingController homeDeliveryFeeController = TextEditingController();
  RxBool homeDeliverySub1 = false.obs;
  RxBool homeDeliveryPercentValue = false.obs;
  RxBool homeDeliveryPerKmValue = false.obs;

  @override
  void onReady() {
    getStallCatList();
    getMyStall();

    super.onReady();
  }

  final _apiHelper = ApiHelper.to;
  String restId = '';
  getMyStall() async {
    LoadingDialog.showLoadingDialog();
    isLoading.value = false;
    update();
    try {
      Response value = await _apiHelper.postApi(AppUrl.restaurantsList, {});
      if (value.statusCode == 200) {
        var response = GetMyStallResponse.fromJson(value.body);
        deliverFeeController.text = response.restaurants[0].fee ?? '0';
        deliverAreaController.text = response.restaurants[0].area.toString();
        minFeeController.text = response.restaurants[0].minAmount ?? '0';
        userId.value = response.restaurants[0].userId.toString();
        restId = response.restaurants[0].id.toString();

        famooshedDeliveryDriverPercentValue.value =
            response.restaurants[0].percent == 1 ? true : false;
        famooshedDeliveryDriverPerKmValue.value =
            response.restaurants[0].perkm == 1 ? true : false;

        pickUpSub1.value = response.restaurants[0].pickUp == 1 ? true : false;
        nextDaySub1.value = response.restaurants[0].nextDay == 1 ? true : false;
        homeDeliverySub1.value =
            response.restaurants[0].homeDeli == 1 ? true : false;

        homeDeliveryPercentValue.value =
            response.restaurants[0].homeDeliPercent == 1 ? true : false;
        homeDeliveryPerKmValue.value =
            response.restaurants[0].homeDeliPerkm == 1 ? true : false;
        homeDeliveryFeeController.text = response.restaurants[0].homeDeliFee;
        nextDayFeeController.text = response.restaurants[0].nextDayFee;

        famooshedDeliveryDriver.value =
            response.restaurants[0].onlyfamooshed == 1 ? true : false;

        if (stallCatList.isNotEmpty &&
            response.restaurants[0].merchantCategories != null &&
            response.restaurants[0].merchantCategories!.isNotEmpty) {
          response.restaurants[0].merchantCategories =
              response.restaurants[0].merchantCategories!.replaceAll(' ', '');
          List<String> merchantCategories =
              response.restaurants[0].merchantCategories!.split(',');
          if (merchantCategories.isNotEmpty) {
            stallCatList.forEach((element) {
              print("ID==" + element.id.toString());
              print("LIST==" + merchantCategories.toString());

              if (merchantCategories.contains(element.id.toString())) {
                selectedStallList.add(element);
              }
            });
          }

          print("LENGTH:::" + selectedStallList.length.toString());
        }
      }
    } catch (e, trace) {
      log(e.toString(), stackTrace: trace);
      LoadingDialog.closeLoadingDialog();
      isLoading.value = false;
      update();
    }
    LoadingDialog.closeLoadingDialog();
    isLoading.value = false;
    update();
    // _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
    //   (value) {
    //     try {
    //       var response = GetMyStallResponse.fromJson(value);
    //       deliverFeeController.text = response.restaurants[0].fee ?? '0';
    //       deliverAreaController.text = response.restaurants[0].area.toString();
    //       minFeeController.text = response.restaurants[0].minAmount ?? '0';
    //       userId.value = response.restaurants[0].userId.toString();
    //       restId = response.restaurants[0].id.toString();
    //
    //       famooshedDeliveryDriverPercentValue.value =
    //           response.restaurants[0].percent == 1 ? true : false;
    //       famooshedDeliveryDriverPerKmValue.value =
    //           response.restaurants[0].perkm == 1 ? true : false;
    //
    //       pickUpSub1.value = response.restaurants[0].pickUp == 1 ? true : false;
    //       nextDaySub1.value =
    //           response.restaurants[0].nextDay == 1 ? true : false;
    //       homeDeliverySub1.value =
    //           response.restaurants[0].homeDeli == 1 ? true : false;
    //
    //       homeDeliveryPercentValue.value =
    //           response.restaurants[0].homeDeliPercent == 1 ? true : false;
    //       homeDeliveryPerKmValue.value =
    //           response.restaurants[0].homeDeliPerkm == 1 ? true : false;
    //       homeDeliveryFeeController.text = response.restaurants[0].homeDeliFee;
    //       nextDayFeeController.text = response.restaurants[0].nextDayFee;
    //
    //       famooshedDeliveryDriver.value =
    //           response.restaurants[0].onlyfamooshed == 1 ? true : false;
    //
    //       if (stallCatList.isNotEmpty &&
    //           response.restaurants[0].merchantCategories != null &&
    //           response.restaurants[0].merchantCategories!.isNotEmpty) {
    //         List<String> merchantCategories =
    //             response.restaurants[0].merchantCategories!.split(',');
    //         if (merchantCategories.isNotEmpty) {
    //           stallCatList.forEach((element) {
    //             if (merchantCategories.contains(element.id)) {
    //               selectedStallList.add(element);
    //             }
    //           });
    //         }
    //       }
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //     isLoading.value = false;
    //     update();
    //   },
    //   retryFunction: getMyStall,
    // );
  }

  saveSetting() {
    // var formData = FormData({
    //   'edit': '1',
    //   'editId': restaurantId,
    //   'user_id': userId.value,
    //   'fee': deliverFeeController.text,
    //   'onlyfamooshed': famooshedDeliveryDriver.value,
    //   'percent': famooshedDeliveryDriverPercentValue.value,
    //   'perkm': famooshedDeliveryDriverPerKmValue.value,
    //   'area': deliverAreaController.text,
    //   'minAmount': minFeeController.text
    // });

    String merchantCarList = selectedStallList.map((e) => e.id).toString();
    merchantCarList = merchantCarList.replaceAll('(', '');
    merchantCarList = merchantCarList.replaceAll(')', '');
    merchantCarList = merchantCarList.trim();
    print(merchantCarList);
    var body = {
      'id': restaurantId,
      'fee': deliverFeeController.text,
      'next_fee': nextDayFeeController.text,
      'home_deli_fee': homeDeliveryFeeController.text,
      'merchant_categories': merchantCarList,
      'onlyfamooshed': famooshedDeliveryDriver.value ? 1 : 0,
      'percent': famooshedDeliveryDriverPercentValue.value ? 1 : 0,
      'home_deli_percentEdit': homeDeliveryPercentValue.value ? 1 : 0,
      'perkm': famooshedDeliveryDriverPerKmValue.value ? 1 : 0,
      'home_deli_perkmEdit': homeDeliveryPerKmValue.value ? 1 : 0,
      'pick_up': pickUpSub1.value ? 1 : 0,
      'next_day': nextDaySub1.value ? 1 : 0,
      'home_deli': homeDeliverySub1.value ? 1 : 0,
      'area': deliverAreaController.text,
      'minAmount': minFeeController.text,
    };

    print(body);
    _apiHelper.postApi(AppUrl.settingedit, body).futureValue(
      (value) {
        dprint(value);
        isLoading.value = false;
        Get.back();
        update();
      },
      retryFunction: saveSetting,
    );
  }

  final RxList<CatList> _stallCatList = RxList();
  List<CatList> get stallCatList => _stallCatList;
  set stallCatList(List<CatList> foodList1) => _stallCatList.addAll(foodList1);

  List<CatList> selectedStallList = [];
  getStallCatList() async {
    LoadingDialog.showLoadingDialog();
    try {
      Response response = await _apiHelper.getApi(
        AppUrl.myStallCat,
      );

      if (response.statusCode == 200) {
        stallCatList.clear();

        if (response.body['catList'] != null) {
          List data = response.body['catList'];
          if (data.isNotEmpty) {
            data.forEach((element) {
              stallCatList.add(CatList.fromJson(element));
            });
          }
        }
      }
    } catch (e) {
      update();

      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }
}
