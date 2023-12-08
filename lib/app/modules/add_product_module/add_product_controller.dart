import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:dio/dio.dart' as dio;
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/upload_image_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../utils/common_helper.dart';
import '../../utils/dprint.dart';

class AddProductController extends GetxController {
  String dropDownValue = "";
  List<ImageFilesData> imagesFiles = [];
  final _apiHelper = ApiHelper.to;

  var editControllerName = TextEditingController();
  var editControllerPrice = TextEditingController();
  var editControllerDiscountPrice = TextEditingController();
  var editControllerDesc = TextEditingController();
  var editControllerUnit = TextEditingController();
  var editControllerWeight = TextEditingController();
  var editControllerPackageCount = TextEditingController();
  var editControllerIngredients = TextEditingController();
  var editControllerVariantsName = TextEditingController();
  var editControllerVariantsPrice = TextEditingController();
  var editControllerVariantsDiscountPrice = TextEditingController();
  var published = false;
  String productImage = "";
  String productImageUrl = "";
  int productImageId = 0;
  int categoryId = 0;
  RxBool isProductUploading = false.obs;
  RxBool isAddUploading = false.obs;

  List<String> aditionalImages = [];

  foodSave() {
    if (editControllerName.text.isEmpty) {
      Utils.showSnackbar("Product Name can't be empty");
      return;
    }
    if (editControllerPrice.text.isEmpty) {
      Utils.showSnackbar("Price can't be empty");
      return;
    }
    if (editControllerDiscountPrice.text.isEmpty) {
      Utils.showSnackbar("Discount can't be empty");
      return;
    }
    if (editControllerUnit.text.isEmpty) {
      Utils.showSnackbar("Unit can't be empty");
      return;
    }
    if (editControllerWeight.text.isEmpty) {
      Utils.showSnackbar("Weight can't be empty");
      return;
    }
    if (editControllerPackageCount.text.isEmpty) {
      Utils.showSnackbar("Package can't be empty");
      return;
    }

    var restId = Storage.getValue(Constants.restId);
    var body = FormData({
      'name': editControllerName.text,
      'imageid': productImageId,
      'images': aditionalImages,
      'price': editControllerPrice.text,
      'discountprice': editControllerDiscountPrice.text,
      'desc': editControllerDesc.text,
      'restaurant': restId,
      'category': "273",
      'ingredients': editControllerIngredients.text,
      'unit': editControllerUnit.text,
      'packageCount': editControllerPackageCount.text,
      'weight': editControllerWeight.text,
      'canDelivery': '1',
      'published': published ? 1 : 0,
      'stars': '5',
      'extras': '0',
      'nutritions': '0'
    });

    dprint(body.fields);

    _apiHelper.postApi(AppUrl.foodSave, body).futureValue(
      (value) {
        try {
          if (value["error"] == "0") {
            dprint(value);
          } else {
            Utils.showSnackbar("Something Went Wrong");
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }

        update();
      },
      retryFunction: uploadProductImage,
    );
  }

  uploadImage() async {
    var headers = {
      'Authorization': Storage.getValue(Constants.token).toString()
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://famooshed.com/admin/public/api/uploadImage'));
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      File(productImage).path,
    ));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var resp = await response.stream.bytesToString();

      var uploadResponse = UploadImageResponse.fromJson(json.decode(resp));
      productImageId = uploadResponse.id;
      productImageUrl = Constants.imgUrl + uploadResponse.filename;
      update();
    } else {
      dprint(response.reasonPhrase);
    }
  }

  uploadProductImage() {
    img.Image? image = img.decodeImage(File(productImage).readAsBytesSync());
    img.Image thumbnail = img.copyResize(image!, width: 1000);
    File(productImage).writeAsBytesSync(img.encodeJpg(thumbnail));
    var formData = FormData({
      "file": MultipartFile(
        productImage,
        filename: productImage,
      ),
    });

    _apiHelper.postApi(AppUrl.uploadImage, formData).futureValue(
      (value) {
        try {
          if (value["error"] == "0") {
            var response = UploadImageResponse.fromJson(value);
            productImageId = response.id;
            productImageUrl = Constants.imgUrl + response.filename;
            update();
          } else {
            Utils.showSnackbar("Something Went Wrong");
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        update();
      },
      retryFunction: uploadProductImage,
    );
  }

  getAdditionalImage() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    if (images.isNotEmpty) {
      for (var item in images) {
        try {
          var headers = {
            'Authorization': Storage.getValue(Constants.token).toString()
          };
          var request = http.MultipartRequest('POST',
              Uri.parse('https://famooshed.com/admin/public/api/uploadImage'));
          request.files.add(await http.MultipartFile.fromPath(
            'file',
            item.path,
          ));
          request.headers.addAll(headers);

          http.StreamedResponse response = await request.send();

          if (response.statusCode == 200) {
            var resp = await response.stream.bytesToString();

            var uploadResponse =
                UploadImageResponse.fromJson(json.decode(resp));
            aditionalImages.add(uploadResponse.filename);
            update();
          } else {
            dprint(response.reasonPhrase);
          }
        } catch (e, stack) {
          log(e.toString(), stackTrace: stack);
        }
      }
      update();
      dprint(aditionalImages);
    }
  }
}
