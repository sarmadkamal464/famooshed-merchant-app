import 'dart:developer';

import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/models/get_owner_coupon_response.dart';

class MyPromotionsController extends GetxController {
  @override
  void onReady() {
    getOwnerCoupon();

    super.onReady();
  }

  final _apiHelper = ApiHelper.to;
  final RxList<CouponInfo> _couponList = RxList();
  List<CouponInfo> get couponList => _couponList;
  set couponList(List<CouponInfo> couponList) => _couponList.addAll(couponList);

  getOwnerCoupon() {
    _apiHelper.getApi(AppUrl.ownerCoupens).futureValue(
      (value) {
        try {
          dprint(value);

          var response = GetOwnerCouponResponse.fromJson(value);
          couponList.clear();
          couponList = response.restaurants;
          // if (couponList.isNotEmpty) {
          //
          //   couponList = response.restaurants;
          // } else {
          //   couponList = response.restaurants;
          // }
          update();
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }

        update();
      },
      retryFunction: getOwnerCoupon,
    );
  }

  TextEditingController searchController = TextEditingController();
  getOwnerCouponFilter() async {
    try {
      Response value = await _apiHelper
          .postApi(AppUrl.coupensListing, {"search": searchController.text});
      if (value.statusCode == 200) {
        dprint(value);

        var response = GetOwnerCouponResponse.fromJson(value.body);
        couponList.clear();
        couponList = response.restaurants;
        update();
      }
    } catch (e, trace) {
      log(e.toString(), stackTrace: trace);
    }
  }

  RxList<int> selectedCategory = <int>[].obs;
  deleteNotification() {
    if (selectedCategory.isNotEmpty) {
      var list = selectedCategory.join(",");
      _apiHelper
          .postApi("${AppUrl.delelteownerCoupens}?id=$list", {}).futureValue(
        (value) {
          selectedCategory.value = [];
          getOwnerCoupon();
          update();
        },
        retryFunction: deleteNotification,
      );
    } else {}
  }
}
