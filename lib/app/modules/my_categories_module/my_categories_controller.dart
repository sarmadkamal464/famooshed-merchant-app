import 'dart:developer';

import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/data/models/category_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../routes/app_pages.dart';

class MyCategoriesController extends GetxController {
  // RxBool isLoading = true.obs;

  // GetFoodListResponse? getFoodListResponse;
  dynamic args = Get.arguments;

  @override
  void onReady() {
    getFoodList();
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;
  final RxList<Category> _categoryList = RxList();
  List<Category> get categoryList => _categoryList;
  set categoryList(List<Category> categoryList) =>
      _categoryList.addAll(categoryList);

  RxList<int> selectedCategory = <int>[].obs;

  goToEdit(Category category) async {
    category.isReadOnly = false;
    update();
    Get.toNamed(Routes.ADD_CATEGORIES, arguments: category);
    // var result = await Get.toNamed(Routes.ADD_CATEGORIES, arguments: category);
    // if (result != null) {
    //   Get.back();
    //   getFoodList();
    // }
    // update();
  }

  TextEditingController searchController = TextEditingController();
  RxBool sortPublished = RxBool(true);
  RxBool sortUnPublished = RxBool(true);
  getFoodList({bool? showLoader}) async {
    if (showLoader ?? true) {
      LoadingDialog.showLoadingDialog();
    }
    var body = {
      'search': searchController.text,
      'published_item': sortPublished.value ? 1 : 0,
      'unpublished_item': sortUnPublished.value ? 1 : 0
    };
    print(body);
    try {
      Response response = await _apiHelper.postApi(AppUrl.categoryList, body);
      if (response.statusCode == 200) {
        categoryList.clear();
        var category = CategoryListResponse.fromJson(response.body);
        categoryList = category.subCategory;

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
    // _apiHelper.postApi(AppUrl.categoryList, body).futureValue(
    //   (value) {
    //     try {
    //       var category = CategoryListResponse.fromJson(value);
    //       if (categoryList.isNotEmpty) {
    //         categoryList.clear();
    //         categoryList = category.category;
    //       } else {
    //         categoryList = category.category;
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

  deleteCategory() {
    if (selectedCategory.isNotEmpty) {
      var list = selectedCategory.join(",");
      _apiHelper.postApi("${AppUrl.categoryDelete}?id=$list", {}).futureValue(
        (value) {
          if (value["error"] == "0") {
            selectedCategory.value = [];
            try {
              var category = CategoryListResponse.fromJson(value);
              if (categoryList.isNotEmpty) {
                categoryList.clear();
                categoryList = category.category;
              } else {
                categoryList = category.category;
              }
            } catch (e, trace) {
              log(e.toString(), stackTrace: trace);
            }
          }
          update();
        },
        retryFunction: deleteCategory,
      );
    } else {}
  }
}
