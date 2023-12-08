import 'dart:developer';

import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/get_owner_coupon_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/util/loading_dialog.dart';
import '../../data/models/category_list_response.dart';
import '../../data/models/get_food_list_response.dart';
import '../my_promotions_module/my_promotions_controller.dart';

class AddNewCouponsController extends GetxController {
  @override
  void onReady() {
    getInitialData();
    getFoodList();
    getCategoryList();
    super.onReady();
  }

  TextEditingController promoCodeController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController prouctController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController minAmountController = TextEditingController();

  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now();

  final _apiHelper = ApiHelper.to;
  // final RxList<CouponInfo> _couponList = RxList();
  // List<CouponInfo> get couponList => _couponList;
  // set couponList(List<CouponInfo> couponList) => _couponList.addAll(couponList);

  dynamic routeData = Get.arguments;
  String couponId = "";

  getInitialData() {
    if (routeData != null) {
      CouponInfo couponData = routeData;
      promoCodeController.text = couponData.name;
      startController.text = couponData.dateStart
          .formatedDate(dateFormat: "dd-MM-yyyy, hh:mm a")
          .toString();
      endController.text = couponData.dateEnd
          .formatedDate(dateFormat: "dd-MM-yyyy, hh:mm a")
          .toString();
      discountController.text = couponData.discount.toString();
      inPercent.value = couponData.inpercents == 1;
      allCategory.value = couponData.allCategory == 1;
      allFoods.value = couponData.allFoods == 1;
      inPercent.value = couponData.inpercents == 1;
      percentageController.text = couponData.inpercents.toString();
      minAmountController.text = couponData.minamount.toString();
      desController.text = couponData.desc;
      couponId = couponData.id.toString();

      // startDate = couponData.dateStart;
      // endDate = couponData.dateEnd;
    }
  }

  addNewCoupon(int published) async {
    if (promoCodeController.text.isEmpty) {
      Utils.showSnackbar("Promo Code can't be empty");
      return;
    }
    if (startController.text.isEmpty) {
      Utils.showSnackbar("Start Datetime Can't be empty");
      return;
    }
    if (endController.text.isEmpty) {
      Utils.showSnackbar("End Datetime Can't be empty");
      return;
    }
    if (discountController.text.isEmpty) {
      Utils.showSnackbar("Discount Can't be empty");
      return;
    }
    if (minAmountController.text.isEmpty) {
      Utils.showSnackbar("Amount Can't be empty");
      return;
    }
    if (desController.text.isEmpty) {
      Utils.showSnackbar("Description Can't be empty");
      return;
    }

    LoadingDialog.showLoadingDialog();
    // dprint(startDate.toString().split(" ").first);
    // dprint(endDate.toString().split(" ").first);

    String foodIdList = '';
    String catList = '';

    // foodIdList = selectedFoodList.first.id
    //     .toString();
    foodIdList = selectedFoodList.map((e) => e.id).toString();
    foodIdList = foodIdList.replaceAll('(', '');
    foodIdList = foodIdList.replaceAll(')', '');

    catList = selectedCategoryList.map((e) => e.id).toString();
    catList = catList.replaceAll('(', '');
    catList = catList.replaceAll(')', '');
    var formData = FormData({});
    var body;
    print(couponId);
    if (routeData != null) {
      formData = FormData({
        'name': promoCodeController.text,
        'dateStart': startController.text,
        'dateEnd': endController.text,
        'discount': discountController.text,
        'published': published,
        'inpercents': inPercent.value ? 1 : 0,
        'amount': minAmountController.text,
        'vendor': Storage.getValue(Constants.userId),
        'desc': desController.text,
        'allFoods': allFoods.value ? 1 : 0,
        'allCategory': allCategory.value ? 1 : 0,
        'restaurantsList': Storage.getValue(Constants.restId),
        'categoryList': catList,
        'foodsList': foodIdList,
        'editId': couponId,
        'edit': '1'
      });
      body = {
        'name': promoCodeController.text,
        'dateStart': startController.text,
        'dateEnd': endController.text,
        'discount': discountController.text,
        'published': published,
        'inpercents': inPercent.value ? 1 : 0,
        'amount': minAmountController.text,
        'vendor': Storage.getValue(Constants.uID),
        'desc': desController.text,
        'allFoods': allFoods.value ? 1 : 0,
        'allCategory': allCategory.value ? 1 : 0,
        'restaurantsList': Storage.getValue(Constants.restId),
        'categoryList': catList,
        'foodsList': foodIdList,
        'editId': couponId,
        'edit': '1'
      };
    } else {
      formData = FormData({
        'name': promoCodeController.text,
        'dateStart': startController.text,
        'dateEnd': endController.text,
        'discount': discountController.text,
        'published': published,
        'inpercents': inPercent.value ? 1 : 0,
        'amount': minAmountController.text,
        'vendor': Storage.getValue(Constants.uID),
        'desc': desController.text,
        'allFoods': allFoods.value ? 1 : 0,
        'allCategory': allCategory.value ? 1 : 0,
        'restaurantsList': Storage.getValue(Constants.restId),
        'categoryList': catList,
        'foodsList': foodIdList,
        'editId': '',
        'edit': '0'
      });
      body = {
        'name': promoCodeController.text,
        'dateStart': startController.text,
        'dateEnd': endController.text,
        'discount': discountController.text,
        'published': published,
        'inpercents': inPercent.value ? 1 : 0,
        'amount': minAmountController.text,
        'vendor': Storage.getValue(Constants.uID),
        'desc': desController.text,
        'allFoods': allFoods.value ? 1 : 0,
        'allCategory': allCategory.value ? 1 : 0,
        'restaurantsList': Storage.getValue(Constants.restId),
        'categoryList': catList,
        'foodsList': foodIdList,
        'editId': '',
        'edit': '0'
      };
    }
    print(body);

    try {
      Response value = await _apiHelper.postApi(AppUrl.addownerCoupens, body);
      if (value.statusCode == 200) {
        print(value.body);
        MyPromotionsController myPromotionsController =
            Get.find<MyPromotionsController>();

        myPromotionsController.getOwnerCoupon();
        myPromotionsController.update();

        LoadingDialog.closeLoadingDialog();

        Get.back();

        if (routeData != null) {
          Utils.showSnackbar("Coupon updated successfully");
        } else {
          Utils.showSnackbar("Coupon created successfully");
        }

        // var response = GetOwnerCouponResponse.fromJson(value.body);
        //
        // if (response.error == "0") {
        //   dprint(value);
        // }
      }
    } catch (e, trace) {
      LoadingDialog.closeLoadingDialog();

      log(e.toString(), stackTrace: trace);
    }
  }

  List<Food> foodList = [];
  List<Food> selectedFoodList = [];

  List<Category> categoryList = [];
  List<Category> selectedCategoryList = [];

  RxBool allCategory = RxBool(false);
  RxBool allFoods = RxBool(false);

  RxBool publishedItem = RxBool(false);

  RxBool inPercent = RxBool(false);

  getFoodList() async {
    // LoadingDialog.showLoadingDialog();
    try {
      Response response = await _apiHelper.postApi(AppUrl.foodsList, {});
      if (response.statusCode == 200) {
        foodList.clear();
        GetFoodListResponse getFoodListResponse =
            GetFoodListResponse.fromJson(response.body);
        foodList = getFoodListResponse.foods;
      }
    } catch (e) {
      print(e.toString());
      // LoadingDialog.closeLoadingDialog();
    }
    update();
    // LoadingDialog.closeLoadingDialog();
  }

  // getCategoryList() async {
  //   // LoadingDialog.showLoadingDialog();
  //   try {
  //     Response response =
  //         await _apiHelper.postApi(AppUrl.loadstallCategories, {});
  //     if (response.statusCode == 200) {
  //       categoryList.clear();
  //       CategoryListResponse getCategoryResponse =
  //           CategoryListResponse.fromJson(response.body);
  //       categoryList = getCategoryResponse.category;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     // LoadingDialog.closeLoadingDialog();
  //   }
  //   update();
  //   // LoadingDialog.closeLoadingDialog();
  // }

  getCategoryList({bool? showLoader}) async {
    if (showLoader ?? true) {
      LoadingDialog.showLoadingDialog();
    }
    var body = {'search': '', 'published_item': 1, 'unpublished_item': 0};
    print(body);
    try {
      Response response = await _apiHelper.postApi(AppUrl.categoryList, body);
      if (response.statusCode == 200) {
        categoryList.clear();
        var category = CategoryListResponse.fromJson(response.body);
        if (category.category.isNotEmpty) {
          categoryList.addAll(category.category);
        }
        if (category.subCategory.isNotEmpty) {
          categoryList.addAll(category.subCategory);
        }
        update();
        if (showLoader ?? true) {
          LoadingDialog.closeLoadingDialog();
        }
      }
    } catch (e) {
      if (showLoader ?? true) {
        LoadingDialog.closeLoadingDialog();
      }
      print(e.toString());
    }
  }
}
