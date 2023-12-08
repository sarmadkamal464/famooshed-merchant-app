import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famooshed_vendor/app/data/models/sign_up_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/storage/storage.dart';
import '../../common/util/loading_dialog.dart';
import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../data/models/get_food_cat_list.dart';
import '../../routes/app_pages.dart';
import '../../utils/common_helper.dart';
import '../../utils/dprint.dart';
import '../chat_module/firebase_chat_serivice/firebase_database_service.dart';
import '../chat_module/firebase_chat_serivice/firebase_helper.dart';

class SignUpController extends GetxController {
  @override
  void onInit() {
    // getDebugData();
    super.onInit();
  }

  @override
  void onReady() {
    getStallCatList();
    super.onReady();
  }

  final ApiHelper _apiHelper = ApiHelper.to;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool passwordVisible = false.obs;
  int currentView = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final RxList<CatList> _stallCatList = RxList();
  List<CatList> get stallCatList => _stallCatList;
  set stallCatList(List<CatList> foodList1) => _stallCatList.addAll(foodList1);
  List<String> stallCategoryList = [];

  getDebugData() {
    if (kDebugMode) {
      emailController.text = "Test User";
      passController.text = "123456";
      nameController.text = "Dev Name";
      emailController.text = "Test User";
      locationController.text = "Mohali";
    }
  }

  getStallCatList() async {
    LoadingDialog.showLoadingDialog();
    try {
      Response response = await _apiHelper.getApi(
        AppUrl.myStallCat,
      );

      if (response.statusCode == 200) {
        stallCatList.clear();
        stallCategoryList.clear();

        if (response.body['catList'] != null) {
          List data = response.body['catList'];
          if (data.isNotEmpty) {
            data.forEach((element) {
              stallCatList.add(CatList.fromJson(element));
            });
          }
        }

        stallCatList.forEach((element) {
          stallCategoryList.add(element.name!);
        });
      }
    } catch (e) {
      update();

      dprint(e);
      LoadingDialog.closeLoadingDialog();
    }
    update();
    LoadingDialog.closeLoadingDialog();
  }

  void register() {
    String childCat = '';
    stallCatList.forEach((element) {
      if (stallCategoryList.contains(element.name)) {
        if (childCat.isNotEmpty) {
          childCat = childCat + "," + element.id.toString();
        } else {
          childCat = element.id.toString();
        }
      }
    });
    var body = {
      'email': emailController.text,
      'password': passController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'child_cat': childCat,
      'is_app': true
    };
    if (formKey.currentState!.validate()) {
      if (passController.text == confirmController.text) {
        _apiHelper.postApi(AppUrl.register, body).futureValue(
          (value) async {
            dprint(value);

            try {
              var response = SignUpResponse.fromJson(value);

              if (response.error == 0) {
                if (response.user != null) {
                  await saveUser(response.user!);
                }
                await Storage.saveValue(
                        Constants.token, "Bearer ${response.accessToken}")
                    .whenComplete(() async {
                  await Storage.saveValue(
                      Constants.uID, "${response.user!.id}");
                  await Storage.saveValue(
                      Constants.name, "${response.user!.name}");
                  await Storage.saveValue(
                      Constants.image, "${getImageUrl(response.user!.avatar)}");
                  // Storage.saveValue(
                  //     Constants.userId, "Bearer ${response.user!.id}");
                  await Storage.saveValue(Constants.rememberMe, "No");
                  Response fcmResponse = await _apiHelper.postApi(
                      AppUrl.fcbToken,
                      {"fcbToken": FirebaseMessages().fcmToken});
                  print("FCM_RESPONSE======>" + fcmResponse.body.toString());
                  Utils.showSnackbar("Login Successfully");
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    Get.offAllNamed(Routes.DASHBOARD);
                  });
                });
              } else {
                Utils.showSnackbar("Invalid Credentials");
              }
            } catch (e, trace) {
              log(e.toString(), stackTrace: trace);
            }
            // if (value['success'] != null && value['success'] == 'true') {
            //
            //   Get.offAllNamed(Routes.DASHBOARD);
            //   // Map<String, dynamic> arg = {"url": "${value['stripe_link']}"};
            //
            //   // Navigator.pushReplacement(
            //   //     Get.context!,
            //   //     MaterialPageRoute(
            //   //       builder: (context) => StripeWebViewScreen(data: arg),
            //   //     ));
            // } else {
            //   Utils.showSnackbar(value['error'] ?? "Registration Failed");
            // }
            // Get.toNamed(Routes.DASHBOARD);
          },
          retryFunction: register,
        );
      } else {
        Utils.showSnackbar("Confirm Password must be same");
      }
    }
  }

  Future<void> saveUser(User user) async {
    DatabaseService databaseService = DatabaseService();
    final QuerySnapshot users = await FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .where('uid', isEqualTo: user.id)
        .get();
    final List<DocumentSnapshot> documents = users.docs;
    if (documents.isEmpty) {
      databaseService.createUser(user.id.toString(), user.name.toString(),
          getImageUrl(user.avatar).toString(), FirebaseMessages().fcmToken, "");
    } else {
      FirebaseFirestore.instance
          .collection(USER_COLLECTION)
          .doc(user.id.toString())
          .update(
              {'deviceToken': FirebaseMessages().fcmToken, 'chattingWith': ''});
    }
  }
}
