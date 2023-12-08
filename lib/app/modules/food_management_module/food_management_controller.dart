import 'dart:developer';
import 'dart:io';

import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/values/app_url.dart';
import '../../data/models/get_food_detail_response.dart';
import '../../data/models/get_food_list_response.dart';

class FoodManagementController extends GetxController {
  RxBool isLoading = true.obs;

  // GetFoodListResponse? getFoodListResponse;

  dynamic args = Get.arguments;

  @override
  void onReady() {
    getFoodList();
    super.onReady();
  }

  RxInt currintIndex = 0.obs;

  final _apiHelper = ApiHelper.to;
  final RxList<Food> _foodList = RxList();
  List<Food> get foodList => _foodList;
  set foodList(List<Food> foodList) => _foodList.addAll(foodList);

  final RxList<List<Food>> _foodList1 = RxList();
  List<List<Food>> get foodList1 => _foodList1;
  set foodList1(List<List<Food>> foodList1) => _foodList1.addAll(foodList1);

  RxList<int> selectedFood = <int>[].obs;

  File? mainFile;
  File? addNewFile;
  List<File> selectedFiles = [];

  dynamic currentFood;

  GetFoodDetailResponse getFoodDetailResponse = GetFoodDetailResponse();

  getFoodList() async {
    // LoadingDialog.showLoadingDialog();

    try {
      Response response = await _apiHelper.postApi(AppUrl.foodsList, {});
      if (response.statusCode == 200) {
        foodList.clear();
        foodList1.clear();
        var getFoodListResponse = GetFoodListResponse.fromJson(response.body);
        if (getFoodListResponse.foods.isNotEmpty) {
          foodList = getFoodListResponse.foods;
          foodList1 = chunk(foodList, 5);
          update();
          // LoadingDialog.closeLoadingDialog();
        }

        // if (foodList.isNotEmpty) {
        //   foodList.clear();
        //   foodList = getFoodListResponse.foods;
        //
        //   foodList1 = chunk(foodList, 10);
        //   log(foodList1.toString());
        // } else {
        //   foodList = getFoodListResponse.foods;
        //   foodList1 = chunk(foodList, 10);
        //   log(foodList1.toString());
        // }
      }
    } catch (e) {
      print(e);
      // LoadingDialog.closeLoadingDialog();
    }

    // _apiHelper.postApi(AppUrl.foodsList, {}).futureValue(
    //   (value) {
    //     try {
    //       var getFoodListResponse = GetFoodListResponse.fromJson(value);
    //       if (foodList.isNotEmpty) {
    //         foodList.clear();
    //         foodList = getFoodListResponse.foods;
    //
    //         foodList1 = chunk(foodList, 10);
    //         log(foodList1.toString());
    //       } else {
    //         foodList = getFoodListResponse.foods;
    //         foodList1 = chunk(foodList, 10);
    //         log(foodList1.toString());
    //       }
    //     } catch (e, trace) {
    //       log(e.toString(), stackTrace: trace);
    //     }
    //     isLoading.value = false;
    //     update();
    //   },
    //   retryFunction: getFoodList,
    // );
  }

  TextEditingController searchController = TextEditingController();
  RxBool sortPublished = RxBool(true);
  RxBool sortUnPublished = RxBool(true);
  filterFoodList() async {
    // LoadingDialog.showLoadingDialog();

    try {
      Response response = await _apiHelper.postApi(AppUrl.foodListing, {
        'search': searchController.text,
        'sortPublished': sortPublished.value ? 1 : 0,
        'sortUnPublished': sortUnPublished.value ? 1 : 0
      });
      if (response.statusCode == 200) {
        var getFoodListResponse = GetFoodListResponse.fromJson(response.body);
        foodList.clear();
        foodList1.clear();
        if (getFoodListResponse.foods.isNotEmpty) {
          foodList = getFoodListResponse.foods;

          foodList1 = chunk(foodList, 5);
          log(foodList1.toString());
        }
        // if (foodList.isNotEmpty) {
        //   foodList.clear();
        //   foodList = getFoodListResponse.foods;
        //
        //   foodList1 = chunk(foodList, 10);
        //   log(foodList1.toString());
        // } else {
        //   foodList = getFoodListResponse.foods;
        //   foodList1 = chunk(foodList, 10);
        //   log(foodList1.toString());
        // }
      }
    } catch (e) {
      print(e);
      // LoadingDialog.closeLoadingDialog();
    }
    update();
    // LoadingDialog.closeLoadingDialog();
  }

  getFoodDetails(String id) async {
    LoadingDialog.showLoadingDialog();
    try {
      Response response =
          await _apiHelper.postApi(AppUrl.foodsDetail, {"id": id});

      if (response.statusCode == 200) {
        if (response.body['error'] != null && response.body['error'] == '0') {
          getFoodDetailResponse = GetFoodDetailResponse.fromJson(response.body);
        }
      }
    } catch (e) {
      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  List<List<Food>> chunk(List<Food> list, int chunkSize) {
    List<List<Food>> chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i + chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }

  deleteFood() {
    if (selectedFood.isNotEmpty) {
      var list = selectedFood.join(",");
      _apiHelper.postApi("${AppUrl.foodDelete}?id=$list", {}).futureValue(
        (value) {
          if (value["error"] == "0") {
            selectedFood.value = [];
            try {
              var getFoodListResponse = GetFoodListResponse.fromJson(value);
              if (foodList.isNotEmpty) {
                foodList.clear();
                foodList = getFoodListResponse.foods;
                foodList1.clear();
                foodList1 = chunk(foodList, 5);
                log(foodList1.toString());
              } else {
                foodList = getFoodListResponse.foods;
                foodList1.clear();
                foodList1 = chunk(foodList, 5);
                log(foodList1.toString());
              }
            } catch (e, trace) {
              log(e.toString(), stackTrace: trace);
            }
          }
          update();
        },
        retryFunction: deleteFood,
      );
    } else {}
  }

  getProductStatus(Food food) {
    String status = "Inactive";
    if (food.published == 0) {
      status = "Inactive";
    } else {
      if (food.invenotory_stock != null && food.invenotory_stock! > 0) {
        status = "Active";
      } else {
        status = "Out of Stock";
      }
    }
    return status;
  }

  Color getProductColor(Food food) {
    Color color = AppColors.lightYellow;
    if (food.published == 0) {
      color = AppColors.greyText.withOpacity(.4);
    } else {
      if (food.invenotory_stock != null && food.invenotory_stock! > 0) {
        color = AppColors.lightGreen;
      } else {
        color = AppColors.lightRed;
      }
    }
    return color;
  }
  // RxBool isSearch = RxBool(false);
  // void getResultList(String? text) {
  //   searchOrderList.clear();
  //   if (filterStatus.id != null && filterStatus.id != -1) {
  //     List<Order> orders =
  //     order.where((element) => element.status == filterStatus.id).toList();
  //
  //     if (text != null && text.isNotEmpty) {
  //       orders.forEach((element) {
  //         if (element.userName != null && element.userName!.isNotEmpty) {
  //           if (element.userName!.toUpperCase().contains(text) ||
  //               element.userName!.toLowerCase().contains(text)) {
  //             searchOrderList.add(element);
  //           }
  //         }
  //       });
  //     } else {
  //       isSearch.value = true;
  //       searchOrderList.addAll(orders);
  //     }
  //     update();
  //   } else {
  //     if (text != null && text.isNotEmpty) {
  //       order.forEach((element) {
  //         if (element.userName != null && element.userName!.isNotEmpty) {
  //           if (element.userName!.toUpperCase().contains(text) ||
  //               element.userName!.toLowerCase().contains(text)) {
  //             searchOrderList.add(element);
  //           }
  //         }
  //       });
  //     }
  //   }
  //   update();
  // }
}
