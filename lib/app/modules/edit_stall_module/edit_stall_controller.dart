import 'dart:developer';
import 'dart:io';

import 'package:famooshed_vendor/app/common/storage/storage.dart';
import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image/image.dart' as img;

import '../../common/constants.dart';
import '../../common/util/loading_dialog.dart';
import '../../data/models/my_stall_response.dart';
import '../../data/models/upload_image_response.dart';
import '../../utils/dprint.dart';
import '../my_stall_module/my_stall_controller.dart';

class EditStallController extends GetxController {
  RxBool isLoading = true.obs;
  dynamic args = Get.arguments;

  GetMyStallResponse? getMyStallResponse;

  @override
  void onReady() {
    // getMyStall();
    getStallData();
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;

  getMyStall() {
    _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
      (value) {
        try {
          getMyStallResponse = GetMyStallResponse.fromJson(value);
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        isLoading.value = false;
        update();
      },
      retryFunction: getMyStall,
    );
  }

  void goToSettings() {
    _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
      (value) {
        try {
          GetMyStallResponse getMyStallResponse =
              GetMyStallResponse.fromJson(value);
          if (getMyStallResponse.restaurants.isNotEmpty) {
            Get.toNamed(Routes.EDIT_INFORMATION,
                arguments: getMyStallResponse.restaurants[0].id);
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        isLoading.value = false;
        update();
      },
      retryFunction: getMyStall,
    );
  }

  TextEditingController stallNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instaController = TextEditingController();

  TextEditingController flatNoController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();

  TextEditingController mondayStartController = TextEditingController();
  TextEditingController mondayEndController = TextEditingController();
  TextEditingController tuesdayStartController = TextEditingController();
  TextEditingController tuesdayEndController = TextEditingController();
  TextEditingController wedStartController = TextEditingController();
  TextEditingController wedEndController = TextEditingController();
  TextEditingController thuStartController = TextEditingController();
  TextEditingController thuEndController = TextEditingController();
  TextEditingController friStartController = TextEditingController();
  TextEditingController friEndController = TextEditingController();
  TextEditingController satStartController = TextEditingController();
  TextEditingController satEndController = TextEditingController();
  TextEditingController sunStartController = TextEditingController();
  TextEditingController sunEndController = TextEditingController();

  File? logoFile;
  File? imageFile;

  Restaurant? restaurant;

  void getStallData() {
    if (args != null) {
      restaurant = args as Restaurant;
      stallNameController.text = restaurant!.name ?? '';
      bioController.text = restaurant!.desc ?? '';
      addressController.text = restaurant!.address ?? '';
      flatNoController.text = restaurant!.flatNo ?? '';
      landMarkController.text = restaurant!.landmark ?? '';
      phoneController.text = restaurant!.phone ?? '';
      facebookController.text = restaurant!.facebook ?? '';
      twitterController.text = restaurant!.twitter ?? '';
      instaController.text = restaurant!.instagram ?? '';

      mondayStartController.text = restaurant!.openTimeMonday ?? '';
      mondayEndController.text = restaurant!.closeTimeMonday ?? '';
      tuesdayStartController.text = restaurant!.openTimeTuesday ?? '';
      tuesdayEndController.text = restaurant!.closeTimeTuesday ?? '';
      wedStartController.text = restaurant!.openTimeWednesday ?? '';
      wedEndController.text = restaurant!.closeTimeWednesday ?? '';
      thuStartController.text = restaurant!.openTimeThursday ?? '';
      thuEndController.text = restaurant!.closeTimeThursday ?? '';
      friStartController.text = restaurant!.openTimeFriday ?? '';
      friEndController.text = restaurant!.closeTimeFriday ?? '';
      satStartController.text = restaurant!.openTimeSaturday ?? '';
      satEndController.text = restaurant!.closeTimeSaturday ?? '';
      sunStartController.text = restaurant!.openTimeSunday ?? '';
      sunEndController.text = restaurant!.closeTimeSunday ?? '';

      if (restaurant!.images != null && restaurant!.imageid != null) {
        imageUrl = Constants.imgUrl + restaurant!.images!;
        imageId = restaurant!.imageid!;
      }

      if (restaurant!.logo != null && restaurant!.logoId != null) {
        bioUrl = Constants.imgUrl + restaurant!.logo;
        bioId = restaurant!.logoId!;
      }
      update();
    }
  }

  String imageUrl = "";
  int imageId = 0;

  String bioUrl = "";
  int bioId = 0;
  uploadProductImage(imagePath, String imageType) async {
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
          if (imageType == 'BIO') {
            bioId = uResponse.id;
            bioUrl = Constants.imgUrl + uResponse.filename;
          } else {
            imageId = uResponse.id;
            imageUrl = Constants.imgUrl + uResponse.filename;
          }
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

  void saveInformation() async {
    LoadingDialog.showLoadingDialog();

    try {
      String uId = await Storage.getValue(Constants.uID);
      Map<String, dynamic> body = {
        "image": imageId,
        "logoIdEdit": bioId,
        "user_id": uId,
        "name": stallNameController.text,
        "desc": bioController.text,
        "address": addressController.text,
        "address_latitude": lat.value,
        "address_longitude": lng.value,
        "phone": phoneController.text,
        "openTimeMonday": mondayStartController.text,
        "closeTimeMonday": mondayEndController.text,
        "openTimeTuesday": tuesdayStartController.text,
        "closeTimeTuesday": tuesdayEndController.text,
        "openTimeWednesday": wedStartController.text,
        "closeTimeWednesday": wedEndController.text,
        "openTimeThursday": thuStartController.text,
        "closeTimeThursday": thuEndController.text,
        "openTimeFriday": friStartController.text,
        "closeTimeFriday": friEndController.text,
        "openTimeSaturday": satStartController.text,
        "closeTimeSaturday": satEndController.text,
        "openTimeSunday": sunStartController.text,
        "closeTimeSunday": sunEndController.text,
        "facebook": facebookController.text,
        "twitter": twitterController.text,
        "instagram": instaController.text,
        "flat_house_no": flatNoController.text,
        "near_by_landmark": landMarkController.text,
      };

      if (restaurant != null) {
        body.addAll({"id": restaurant!.id});
      }

      print(body);
      Response response =
          await _apiHelper.postApi(AppUrl.restaurantsedit, body);
      if (response.statusCode == 200) {
        if (response.body['error'] == '0') {
          MyStallController myStallController = Get.find<MyStallController>();

          myStallController.getMyStall();
          myStallController.update();
          // Response sendResponse =
          //     await _apiHelper.postApi(AppUrl.restaurantsList, {});
          //
          // if (sendResponse.statusCode == 200) {
          //   myStallController.getMyStallResponse =
          //       GetMyStallResponse.fromJson(sendResponse.body);
          //   myStallController.update();
          // }

          LoadingDialog.closeLoadingDialog();

          Get.back();

          if (args != null) {
            Utils.showSnackbar("Stall updated successfully");
          } else {
            Utils.showSnackbar("Stall added successfully");
          }
        }
      }
    } catch (e) {
      dprint(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  var kGoogleApiKey = "AIzaSyBRPxjNN-yrJh2tGSCmsx0fdYX83Wodei4";
  final searchController = TextEditingController();
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  Future<void> handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    final p = await PlacesAutocomplete.show(
      context: Get.context!,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: 'en',
      components: [
        Component(Component.country, 'gb'),
        Component(Component.country, 'in')
      ],
      resultTextStyle: Theme.of(Get.context!).textTheme.titleMedium,
    );
    await displayPrediction(p, ScaffoldMessenger.of(Get.context!));
  }

  Future<void> displayPrediction(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }

    final places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    lat.value = geometry.location.lat;
    lng.value = geometry.location.lng;

    dprint(p.description);
    searchController.text = p.description!;
    addressController.text = p.description!;
    update();
  }
}
