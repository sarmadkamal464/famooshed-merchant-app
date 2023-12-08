import 'dart:developer';
import 'dart:io';

import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/modules/my_categories_module/my_categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

import '../../common/constants.dart';
import '../../common/util/loading_dialog.dart';
import '../../common/values/app_url.dart';
import '../../data/models/category_list_response.dart';
import '../../data/models/get_food_cat_list.dart';
import '../../data/models/get_product_category_model.dart';
import '../../data/models/upload_image_response.dart';
import '../../utils/dprint.dart';

class AddCategoriesController extends GetxController {
  @override
  void onReady() {
    getInitData();
    getFoodCatList();
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;
  Category? data = Get.arguments;
  Category? categoryData;
  RxBool isEdit = false.obs;

  getInitData() {
    if (data != null) {
      categoryData = data;

      edit = '1';
      editId = categoryData!.id.toString();
      editImageId = (categoryData!.imageId ?? 0).toString();
      if (categoryData!.image != null) {
        editImageUrl = categoryData!.image!;
      }
      productName.text = categoryData!.name;
      description.text = categoryData!.desc;
      publishedItem.value = categoryData!.visible == 1;
      featuredCategory.value = categoryData!.featuredCat == 1;
      isEdit.value = true;
      update();
    }
  }

  TextEditingController productName = TextEditingController();
  TextEditingController productParent = TextEditingController();
  TextEditingController description = TextEditingController();

  GetFoodCatListResponse getFoodCatListResponse = GetFoodCatListResponse();
  // final RxList<CatList> _parentCatList = RxList();
  // List<CatList> get parentCatList => _parentCatList;
  // set parentCatList(List<CatList> foodList1) =>
  //     _parentCatList.addAll(foodList1);
  //
  // CatList selectedCategory = CatList();
  // getFoodCatList() async {
  //   LoadingDialog.showLoadingDialog();
  //   try {
  //     Response response = await _apiHelper.getApi(
  //       AppUrl.getFoodCatList,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       if (response.body['error'] != null && response.body['error'] == '0') {
  //         getFoodCatListResponse =
  //             GetFoodCatListResponse.fromJson(response.body);
  //         parentCatList.clear();
  //         if (getFoodCatListResponse.catList != null &&
  //             getFoodCatListResponse.catList!.isNotEmpty) {
  //           parentCatList.addAll(getFoodCatListResponse.catList!);
  //
  //           if (parentCatList.isNotEmpty) {
  //             if (categoryData != null) {
  //               // selectedCategory = parentCatList
  //               //     .where((element) => element.id == categoryData!.parent)
  //               //     .first;
  //               parentCatList.forEach((element) {
  //                 if (element.id != null &&
  //                     element.id == categoryData!.parent) {
  //                   selectedCategory = element;
  //                 }
  //               });
  //               if (selectedCategory.id == null || selectedCategory.id == 0) {
  //                 selectedCategory = parentCatList[0];
  //               }
  //             }
  //             print(selectedCategory);
  //             // if (selectedCategory.id == null) {
  //             //   selectedCategory = parentCatList[0];
  //             // }
  //           }
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     dprint(e);
  //     LoadingDialog.closeLoadingDialog();
  //   }
  //   update();
  //   LoadingDialog.closeLoadingDialog();
  // }

  final RxList<ProductCategoryModel> _productCategoryList = RxList();
  List<ProductCategoryModel> get productCategoryList => _productCategoryList;
  set productCategoryList(List<ProductCategoryModel> productCategoryList) =>
      _productCategoryList.addAll(productCategoryList);

  // final RxList<ProductCategoryModel> _productSubCategoryList = RxList();
  // List<ProductCategoryModel> get productSubCategoryList =>
  //     _productSubCategoryList;
  // set productSubCategoryList(List<ProductCategoryModel> productCategoryList) =>
  //     _productSubCategoryList.addAll(productCategoryList);

  ProductCategoryModel selectedParentProductCat = ProductCategoryModel();

  getFoodCatList() async {
    // LoadingDialog.showLoadingDialog();
    try {
      Response response = await _apiHelper.getApi(
        AppUrl.getFoodCatList,
      );

      if (response.statusCode == 200) {
        productCategoryList.clear();
        if (response.body['error'] != null && response.body['error'] == '0') {
          if (response.body['catList'] != null) {
            List parentCategoryList = response.body['catList'];
            if (parentCategoryList.isNotEmpty) {
              parentCategoryList.forEach((element) {
                productCategoryList.add(ProductCategoryModel.fromJson(element));
              });
            }
          }
          if (productCategoryList.isNotEmpty) {
            if (categoryData != null &&
                categoryData!.parent.toString().isNotEmpty) {
              productCategoryList.forEach((element) {
                if (element.id != null &&
                    element.id.toString() == categoryData!.parent.toString()) {
                  selectedParentProductCat = element;
                }
              });
            }
            if (selectedParentProductCat.id == null) {
              selectedParentProductCat = productCategoryList[0];
            }
          }
          update();
        }
      }
    } catch (e) {
      dprint(e);
      // LoadingDialog.closeLoadingDialog();
    }

    // LoadingDialog.closeLoadingDialog();
  }

  RxBool publishedItem = RxBool(false);
  RxBool featuredCategory = RxBool(false);

  String edit = '0';
  String editId = '';
  addCategory() {
    if (productName.text.isEmpty) {
      Utils.showSnackbar("Category Name can't be empty");
      return;
    }
    // if (selectedCategory.id == null) {
    //   Utils.showSnackbar("Please Select Category");
    //   return;
    // }
    if (editImageUrl.isEmpty) {
      Utils.showSnackbar("Please Upload Image");
      return;
    }
    if (selectedParentProductCat.id == null) {
      Utils.showSnackbar("Please select parent category");
      return;
    }
    var formData = FormData({});
    if (isEdit.value) {
      formData = FormData({
        "edit": edit,
        "editId": editId,
        // "category_type": selectedCategory.categoryType,
        "category_type": selectedParentProductCat.id,
        "name": productName.text,
        "desc": description.text,
        "imageid": editImageId,
        "visible": publishedItem.value ? 1 : 0,
        // "parent": selectedCategory.id,
        "parent": selectedParentProductCat.id,
        "featured_cat": featuredCategory.value ? 1 : 0,
      });
    } else {
      formData = FormData({
        "edit": edit,
        "editId": editId,
        // "category_type": selectedCategory.categoryType,
        "category_type": selectedParentProductCat.id,
        "name": productName.text,
        "desc": description.text,
        "imageid": editImageId,
        "visible": publishedItem.value ? 1 : 0,
        // "parent": selectedCategory.id,
        "parent": selectedParentProductCat.id,
        "featured_cat": featuredCategory.value ? 1 : 0,
      });
    }

    print(formData.fields.toString());
    print(formData.fields.toSet());

    _apiHelper.postApi(AppUrl.categorySave, formData).futureValue(
      (value) {
        try {
          if (value["error"] == "0") {
            MyCategoriesController myCategoriesController =
                Get.find<MyCategoriesController>();
            myCategoriesController.getFoodList();
            myCategoriesController.update();

            // Get.back(result: "true");

            Get.back();
            Get.back();
            Utils.showSnackbar(isEdit.value
                ? "Category Updated Successfully"
                : "Category Added Successfully");
          } else {
            Utils.showSnackbar("Something Went Wrong");
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }

        update();
      },
      retryFunction: addCategory,
    );
  }

  String productImageUrl = "";
  int productImageId = 0;

  String editImageId = '';
  String editImageUrl = '';
  uploadProductImage(
    imagePath,
  ) async {
    LoadingDialog.showLoadingDialog();

    try {
      img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());
      img.Image thumbnail = img.copyResize(image!, width: 1000);
      File(imagePath).writeAsBytesSync(img.encodeJpg(thumbnail));
      var formData = FormData({
        "file": MultipartFile(
          imagePath,
          filename: imagePath,
        ),
      });

      Response response =
          await _apiHelper.postApi(AppUrl.uploadImage, formData);
      if (response.statusCode == 200) {
        if (response.body['error'] == '0') {
          var uResponse = UploadImageResponse.fromJson(response.body);
          productImageId = uResponse.id;
          productImageUrl = Constants.imgUrl + uResponse.filename;

          editImageId = uResponse.id.toString();
          editImageUrl = uResponse.filename;
          // getFoodDetailResponse.image = uResponse.filename;
        }
      }
    } catch (e) {
      dprint(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }
}
