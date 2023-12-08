import 'dart:io';

import 'package:famooshed_vendor/app/common/util/loading_dialog.dart';
import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/models/get_my_driver_response.dart';
import 'package:famooshed_vendor/app/modules/my_drivers_module/my_drivers_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

import '../../common/constants.dart';
import '../../data/api_helper.dart';
import '../../data/models/upload_image_response.dart';
import '../../utils/dprint.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddNewDriverController extends GetxController {
  @override
  void onReady() {
    getInitData();
    super.onReady();
  }

  TextEditingController areaOfWork = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController townCityController = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController dobController = TextEditingController();

  dynamic routeData = Get.arguments;

  List<Areawork> areaWorkList = [];
  Areawork selectedAreaWork = Areawork();

  final _apiHelper = ApiHelper.to;

  getInitData() {
    areaWorkList.clear();
    MyDriversController myDriversController = Get.find<MyDriversController>();
    if (myDriversController.areaWorkList.isNotEmpty) {
      areaWorkList.addAll(myDriversController.areaWorkList);
    }
    if (routeData != null) {
      Driver driver = routeData;

      // areaOfWork.text = driver.areain.toString();

      if (driver.areain != null) {
        areaWorkList.forEach((element) {
          if (element.id == driver.areain) {
            selectedAreaWork = element;
          }
        });
      }
      if (selectedAreaWork.id == null || selectedAreaWork.id == 0) {
        selectedAreaWork = areaWorkList[0];
      }

      if (driver.imageid != null && driver.imageid != 0) {
        editImageId = (driver.imageid ?? '').toString();
      }

      editImageUrl = driver.image ?? '';
      nameController.text = driver.name ?? '';
      emailController.text = driver.email ?? '';
      phoneController.text = driver.phone ?? '';
      emailController.text = driver.email ?? '';
      passwordController.text = driver.password ?? '';
      countryController.text = driver.country.toString();
      address1Controller.text = driver.address ?? '';
      // address2Controller.text = driver.address??'';
      // countryController.text = driver.country ?? '';
      postalCode.text = driver.zipcode ?? '';
      // dobController.text = driver.dateOfBirth.toString();
      selected = driver.vehicle ?? 'bicycle';
      townCityController.text = driver.city ?? '';
    } else {
      selectedAreaWork = areaWorkList[0];
    }
    update();
  }

  addNewDriver() async {
    LoadingDialog.showLoadingDialog();

    try {
      Map<String, dynamic> body = {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
        // "address": address1Controller.text + " " + address2Controller.text,
        "address": address1Controller.text,
        // "image": editImageId,
        // "vehicle": selected,
        // "city": townCityController.text,
        // "zipcode": postalCode.text,
        // "areaname": selectedAreaWork.id,
        // "country": countryController.text,
        "driver_type": "merchant",
      };
      if (routeData != null) {
        Driver driver = routeData;
        body.addAll({"id": driver.id.toString()});
      }
      print(body);
      Response response = await _apiHelper.postApi(AppUrl.addEditDriver, body);

      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();

        if (response.body['error'] == '0') {
          // Get.find<MyDriversController>().onReady();

          MyDriversController myDriversController =
              Get.find<MyDriversController>();

          myDriversController.getMyDrivers(true);
          myDriversController.update();
          // if (response.body['idata'] != null) {
          //   if (response.body['idata']['data'] != null) {
          //     List data = response.body['idata']['data'];
          //     List<NotoficationDataItem> notificationDataItemList = [];
          //     data.forEach((element) {
          //       notificationDataItemList
          //           .add(NotoficationDataItem.fromJson(element));
          //     });
          //     newPromotionsController.notificationList = notificationDataItemList;
          //     newPromotionsController.update();
          //   }
          // }
          LoadingDialog.closeLoadingDialog();

          Get.back();
          if (routeData != null) {
            Utils.showSnackbar("Driver updated successfully");
          } else {
            Utils.showSnackbar("Driver added successfully");
          }
        }
      }
    } catch (e) {
      print(e);
      LoadingDialog.closeLoadingDialog();
    }
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

  String selected = "";
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "assets/images/bicycle.png",
    },
    {
      "id": 1,
      "value": false,
      "title": "assets/images/scooter.png",
    },
    {
      "id": 2,
      "value": false,
      "title": "assets/images/carMain.png",
    },
  ];
}
