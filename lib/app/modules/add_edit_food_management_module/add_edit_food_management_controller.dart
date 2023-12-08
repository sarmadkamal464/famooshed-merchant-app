import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/get_food_cat_list.dart';
import 'package:famooshed_vendor/app/data/models/get_product_category_model.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../common/storage/storage.dart';
import '../../common/values/app_url.dart';
import '../../data/models/get_food_detail_response.dart';
import '../../data/models/get_food_list_response.dart';
import '../../data/models/upload_image_response.dart';
import '../food_management_module/food_management_controller.dart';

class AddEditFoodManagementController extends GetxController {
  @override
  void onReady() {
    Food? args = Get.arguments as Food?;
    if (args != null && args.id.toString().isNotEmpty) {
      getFoodDetails(args.id.toString());
    }

    getFoodCatList();
    FoodManagementController foodManagementController =
        Get.find<FoodManagementController>();
    foodList.clear();
    foodList = foodManagementController.foodList;
    print(foodList.length);
    foodList.forEach((element) {
      foodListString.add(element.name);
    });
    update();

    super.onReady();
  }

  List<Food> foodList = [];
  List<Food> selectedFoodList = [];
  List<String> foodListString = [];
  String selectedFoodForRecommand = '';
  final _apiHelper = ApiHelper.to;

  GetFoodDetailResponse getFoodDetailResponse = GetFoodDetailResponse();
  GetFoodCatListResponse getFoodCatListResponse = GetFoodCatListResponse();
  File? mainFile;
  File? addNewFile;
  List<File> selectedFiles = [];

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController packageController = TextEditingController();
  TextEditingController packageDescriptionController = TextEditingController();
  TextEditingController inventoryStock = TextEditingController();

  final RxList<Variant> _variantFoodList = RxList();
  List<Variant> get variantFoodList => _variantFoodList;
  set variantFoodList(List<Variant> foodList1) =>
      _variantFoodList.addAll(foodList1);

  RxList<Variant> selectedVariant = <Variant>[].obs;
  RxList<SimilarFood> selectedSimilar = <SimilarFood>[].obs;

  TextEditingController variantProductNameController = TextEditingController();
  TextEditingController variantPriceController = TextEditingController();
  TextEditingController variantDiscountPriceController =
      TextEditingController();
  TextEditingController variantProductUnitController = TextEditingController();
  TextEditingController variantWeightController = TextEditingController();

  final RxList<SimilarFood> _similarFoodList = RxList();
  List<SimilarFood> get similarFoodList => _similarFoodList;
  set similarFoodList(List<SimilarFood> foodList1) =>
      _similarFoodList.addAll(foodList1);

  final RxList<CatList> _parentCatList = RxList();
  List<CatList> get parentCatList => _parentCatList;
  set parentCatList(List<CatList> foodList1) =>
      _parentCatList.addAll(foodList1);

  List<String> parentCategoryList = [];
  String selectedParentCategory = '';

  final RxList<CatList> _stallCatList = RxList();
  List<CatList> get stallCatList => _stallCatList;
  set stallCatList(List<CatList> foodList1) => _stallCatList.addAll(foodList1);
  List<String> stallCategoryList = [];

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
  ProductCategoryModel selectedSubProductCat = ProductCategoryModel();

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
            if (getFoodDetailResponse.category != null &&
                getFoodDetailResponse.category.toString().isNotEmpty) {
              // selectedParentProductCat = productCategoryList
              //     .where((element) =>
              //         element.id != null &&
              //         element.id.toString() ==
              //             getFoodDetailResponse.category.toString())
              //     .first;

              productCategoryList.forEach((element) {
                if (element.id != null &&
                    element.id.toString() ==
                        getFoodDetailResponse.category.toString()) {
                  selectedParentProductCat = element;
                }
              });
            }
            if (selectedParentProductCat.id == null) {
              selectedParentProductCat = productCategoryList[0];
            }
            if (selectedParentProductCat.subCategories != null &&
                selectedParentProductCat.subCategories!.isNotEmpty) {
              // selectedSubProductCat = selectedParentProductCat.subCategories!
              //     .where((element) =>
              //         element.id != null &&
              //         element.id.toString() ==
              //             getFoodDetailResponse.category.toString())
              //     .first;

              if (getFoodDetailResponse.subCategory != null &&
                  getFoodDetailResponse.subCategory.toString().isNotEmpty) {
                selectedParentProductCat.subCategories!.forEach((element) {
                  if (element.id != null &&
                      element.id.toString() ==
                          getFoodDetailResponse.subCategory.toString()) {
                    selectedSubProductCat = element;
                  }
                });
              }
            }
          }
          update();
          // getFoodCatListResponse =
          //     GetFoodCatListResponse.fromJson(response.body);
          // parentCatList.clear();
          // stallCatList.clear();
          // parentCategoryList.clear();
          // stallCategoryList.clear();
          // if (getFoodCatListResponse.catList != null &&
          //     getFoodCatListResponse.catList!.isNotEmpty) {
          //   parentCatList.addAll(getFoodCatListResponse.catList!);
          //
          //   parentCatList.forEach((element) {
          //     parentCategoryList.add(element.name!);
          //     if (element.id != null &&
          //         element.id == getFoodDetailResponse.category) {
          //       selectedParentCategory = element.name!;
          //     }
          //     // else {
          //     //   selectedParentCategory = parentCategoryList[0];
          //     // }
          //   });
          // }
          // if (getFoodCatListResponse.stallcatList != null &&
          //     getFoodCatListResponse.stallcatList!.isNotEmpty) {
          //   stallCatList.addAll(getFoodCatListResponse.stallcatList!);
          //   stallCatList.forEach((element) {
          //     stallCategoryList.add(element.name!);
          //   });
          // }
        }
      }
    } catch (e) {
      dprint(e);
      // LoadingDialog.closeLoadingDialog();
    }

    // LoadingDialog.closeLoadingDialog();
  }

  String? mainProductUrl;
  getFoodDetails(String id) async {
    // LoadingDialog.showLoadingDialog();
    try {
      Response response =
          await _apiHelper.postApi(AppUrl.foodsDetail, {"id": id});

      if (response.statusCode == 200) {
        if (response.body['error'] != null && response.body['error'] == '0') {
          getFoodDetailResponse = GetFoodDetailResponse.fromJson(response.body);

          mainProductUrl = getFoodDetailResponse.image;
          productNameController.text = getFoodDetailResponse.name ?? '';
          priceController.text = getFoodDetailResponse.price ?? '';
          discountPriceController.text =
              getFoodDetailResponse.discountprice ?? '';
          ingredientController.text = getFoodDetailResponse.ingredients ?? '';
          unitController.text = getFoodDetailResponse.unit ?? '';
          weightController.text =
              (getFoodDetailResponse.weight ?? '').toString();
          packageController.text =
              (getFoodDetailResponse.packageCount ?? '').toString();
          packageDescriptionController.text = getFoodDetailResponse.desc ?? '';
          variantFoodList.clear();
          if (getFoodDetailResponse.variants != null &&
              getFoodDetailResponse.variants!.isNotEmpty) {
            variantFoodList.addAll(getFoodDetailResponse.variants!);
          }
          similarFoodList.clear();
          if (getFoodDetailResponse.similarFood != null &&
              getFoodDetailResponse.similarFood!.isNotEmpty) {
            similarFoodList.addAll(getFoodDetailResponse.similarFood!);
          }
        }
      }
    } catch (e) {
      dprint(e);
      // LoadingDialog.closeLoadingDialog();
    }
    update();
    // LoadingDialog.closeLoadingDialog();
  }

  addProductVariant(String id) async {
    LoadingDialog.showLoadingDialog();
    try {
      String uploadedImageId = '';
      img.Image? image =
          img.decodeImage(File(addNewFile!.path).readAsBytesSync());
      img.Image thumbnail = img.copyResize(image!, width: 1000);
      File(addNewFile!.path).writeAsBytesSync(img.encodeJpg(thumbnail));
      var formData = FormData({
        "file": MultipartFile(
          addNewFile!.path,
          filename: addNewFile!.path,
        ),
      });
      Response imageResponse =
          await _apiHelper.postApi(AppUrl.uploadImage, formData);
      if (imageResponse.statusCode == 200) {
        var response = UploadImageResponse.fromJson(imageResponse.body);
        uploadedImageId = response.id.toString();
      }
      var body = {
        "id": id,
        "name": variantProductNameController.text,
        "price": variantPriceController.text,
        "dprice": variantDiscountPriceController.text,
        "unit": variantProductUnitController.text,
        "weight": variantWeightController.text,
        "imageid": uploadedImageId
      };
      Response response =
          await _apiHelper.postApi(AppUrl.addProductVariant, body);

      if (response.statusCode == 200) {
        variantFoodList.clear();
        if (response.body['error'] != null && response.body['error'] == '0') {
          if (response.body['data'] != null) {
            List dataList = response.body['data'];
            List<Variant> variants = [];
            dataList.forEach((element) {
              variants.add(Variant.fromJson(element));
            });
            variantFoodList.addAll(variants);
            variantProductNameController.clear();
            variantPriceController.clear();
            variantDiscountPriceController.clear();
            variantProductUnitController.clear();
            variantWeightController.clear();
            addNewFile = null;
          }
        }
      }
    } catch (e) {
      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  deleteProductVariant() async {
    LoadingDialog.showLoadingDialog();
    String deletedVariant = '';

    for (int i = 0; i < selectedVariant.length; i++) {
      if (deletedVariant.isNotEmpty) {
        deletedVariant =
            deletedVariant + "," + selectedVariant[i].id.toString();
      } else {
        deletedVariant = selectedVariant[i].id.toString();
      }
    }
    try {
      Response imageResponse = await _apiHelper
          .postApi(AppUrl.deleteProductVariant, {"ids": deletedVariant});
      if (imageResponse.statusCode == 200) {
        variantFoodList
            .removeWhere((element) => selectedVariant.contains(element));
        selectedVariant.clear();
      }
    } catch (e) {
      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  deleteSimilarProduct() async {
    LoadingDialog.showLoadingDialog();
    String deletedSimilars = '';

    for (int i = 0; i < selectedSimilar.length; i++) {
      if (deletedSimilars.isNotEmpty) {
        deletedSimilars =
            deletedSimilars + "," + selectedSimilar[i].id.toString();
      } else {
        deletedSimilars = selectedSimilar[i].id.toString();
      }
    }
    try {
      Response imageResponse = await _apiHelper
          .postApi(AppUrl.multiplerProductsdelete, {"ids": deletedSimilars});
      if (imageResponse.statusCode == 200) {
        similarFoodList
            .removeWhere((element) => selectedSimilar.contains(element));
        selectedSimilar.clear();
      }
    } catch (e) {
      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  String productImageUrl = "";
  int productImageId = 0;

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
          getFoodDetailResponse.image = uResponse.filename;
        }
      }
    } catch (e) {
      dprint(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
    LoadingDialog.closeLoadingDialog();
    update();
  }

  uploadSingleImage(imagePath, int index) {
    LoadingDialog.showLoadingDialog();

    img.Image? image = img.decodeImage(File(imagePath).readAsBytesSync());
    img.Image thumbnail = img.copyResize(image!, width: 1000);
    File(imagePath).writeAsBytesSync(img.encodeJpg(thumbnail));
    var formData = FormData({
      "file": MultipartFile(
        imagePath,
        filename: imagePath,
      ),
    });

    _apiHelper.postApi(AppUrl.uploadImage, formData).futureValue(
      (value) {
        try {
          if (value["error"] == "0") {
            var response = UploadImageResponse.fromJson(value);

            aditionalImages.removeAt(index);
            aditionalImages.add(response.filename);
            // aditionalImages.forEach((element) {
            //
            // });
            LoadingDialog.closeLoadingDialog();
            update();
          } else {
            Utils.showSnackbar("Something Went Wrong");
          }
        } catch (e, trace) {
          LoadingDialog.closeLoadingDialog();
          update();
          log(e.toString(), stackTrace: trace);
        }
        LoadingDialog.closeLoadingDialog();

        update();
      },
      retryFunction: uploadSingleImage(imagePath, index),
    );
  }

  List<String> aditionalImages = [];
  String productImage = "";

  getAdditionalImage() async {
    LoadingDialog.showLoadingDialog();
    List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      if (images.length > 3) {
        LoadingDialog.closeLoadingDialog();
        update();
        Utils.showSnackbar("Max 3 images is allowed");
      } else {
        for (var item in images) {
          try {
            var headers = {
              'Authorization': Storage.getValue(Constants.token).toString()
            };
            var request = http.MultipartRequest(
                'POST',
                Uri.parse(
                    'https://famooshed.com/admin/public/api/uploadImage'));
            request.files.add(await http.MultipartFile.fromPath(
              'file',
              item.path,
            ));
            request.headers.addAll(headers);

            http.StreamedResponse response = await request.send();

            if (response.statusCode == 200) {
              var resp = await response.stream.bytesToString();

              var uploadResponse = UploadImageResponse.fromJson(
                json.decode(resp),
              );
              aditionalImages.add(uploadResponse.filename);
            } else {
              dprint(response.reasonPhrase);
            }
          } catch (e, stack) {
            LoadingDialog.closeLoadingDialog();

            update();
            log(e.toString(), stackTrace: stack);
          }
        }
      }
      LoadingDialog.closeLoadingDialog();

      update();
      dprint(aditionalImages);
    }
  }

  addRecommandedProduct(String rp) async {
    LoadingDialog.showLoadingDialog();
    try {
      Response response = await _apiHelper
          // .postApi(AppUrl.rProductAdd, {"id": args.id.toString(), "rp": rp});
          .postApi(AppUrl.rProductAdd, {"id": '0', "rp": rp});
      if (response.statusCode == 200) {
        if (response.body['error'] != null && response.body['error'] == '0') {
          if (response.body['data'] != null) {
            List dataList = response.body['data'];
            List<SimilarFood> similarFoods = [];
            dataList.forEach((element) {
              similarFoods.add(SimilarFood.fromJson(element));
            });
            similarFoodList.addAll(similarFoods);
          }
        }
      }
    } catch (e) {
      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  foodSave(bool published, bool edit, String editId) async {
    // LoadingDialog.showLoadingDialog();
    var restId = Storage.getValue(Constants.restId);
    // String parentCat = '';
    // String childCat = '';
    String additionalImages = '';

    // parentCatList.forEach((element) {
    //   if (element.name == selectedParentCategory) {
    //     parentCat = element.id.toString();
    //   }
    // });

    // stallCatList.forEach((element) {
    //   if (stallCategoryList.contains(element.name)) {
    //     if (childCat.isNotEmpty) {
    //       childCat = childCat + "," + element.id.toString();
    //     } else {
    //       childCat = element.id.toString();
    //     }
    //   }
    // });
    additionalImages = aditionalImages.join(',');

    var body = FormData({
      'edit': edit ? 1 : 0,
      'editId': editId,
      'name': productNameController.text,
      'imageid':
          productImageId != 0 ? productImageId : getFoodDetailResponse.imageid,
      'images': additionalImages,
      'price': priceController.text,
      'discPrice': discountPriceController.text,
      'desc': packageDescriptionController.text,
      'restaurant': restId,
      'category': selectedParentProductCat.id ?? '',
      'child_cat': selectedSubProductCat.id ?? '',
      'ingredients': ingredientController.text,
      'unit': unitController.text,
      'package': packageController.text,
      'weight': weightController.text,
      'inventory_stock': inventoryStock.text,
      'published': published ? 1 : 0,
    });

    dprint(body.fields);

    try {
      Response response = await _apiHelper.postApi(AppUrl.foodSave, body);
      if (response.statusCode == 200) {
        if (response.body['error'] != null && response.body['error'] == '0') {
          // LoadingDialog.closeLoadingDialog();

          // FoodManagementController foodManagementController =
          //     Get.find<FoodManagementController>();
          // foodManagementController.getFoodList();

          Get.back(result: true);
          Utils.showSnackbar("Product Saved.");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
    // update();
    // LoadingDialog.closeLoadingDialog();
  }
}
