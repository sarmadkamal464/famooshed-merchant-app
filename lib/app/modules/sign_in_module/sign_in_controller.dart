import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/sigin_response.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/util/exports.dart';
import '../../common/util/loading_dialog.dart';
import '../../common/util/validators.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../../utils/common_helper.dart';
import '../chat_module/firebase_chat_serivice/firebase_database_service.dart';
import '../chat_module/firebase_chat_serivice/firebase_helper.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_text_field_widget.dart';

class SignInController extends GetxController {
  @override
  void onReady() {
    getDebugData();
    super.onReady();
  }

  @override
  void onInit() {
    Future.delayed(Duration(seconds: 0)).then((value) async {
      String? rememberMe = Storage.getValue(Constants.rememberMe);
      String? token = Storage.getValue(Constants.token);
      String? uID = Storage.getValue(Constants.uID);
      print(token);
      print(rememberMe);
      if (rememberMe != null &&
          rememberMe == "Yes" &&
          token != null &&
          token.isNotEmpty) {
        if (uID != null) {
          FirebaseFirestore.instance
              .collection(USER_COLLECTION)
              .doc(uID)
              .update({
            'deviceToken': FirebaseMessages().fcmToken,
            'chattingWith': ''
          });
        }
        ApiHelper apiHelper = ApiHelper.to;
        // LoadingDialog.showLoadingDialog();
        Response fcmResponse = await apiHelper.postApi(
            AppUrl.fcbToken, {"fcbToken": FirebaseMessages().fcmToken});
        print("FCM_RESPONSE======>" + fcmResponse.body.toString());
        Get.offNamed(Routes.DASHBOARD);
      } else {
        Get.offNamed(Routes.SIGN_IN);
      }
    });
    super.onInit();
  }

  final _apiHelper = ApiHelper.to;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  RxBool isRemember = false.obs;
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  getDebugData() {
    if (kDebugMode) {
      emailController.text = "ankit@spyvebsolutions.com";
      // emailController.text = "simon@take2technology.com";
      passController.text = "123465";
      // passController.text = "wbs@simon123456";
    }
  }

  void login() {
    var body = {
      'email': emailController.text,
      'password': passController.text,
      "owner": "true"
    };

    if (signinFormKey.currentState!.validate()) {
      _apiHelper.postApi(AppUrl.login, body).futureValue(
        (value) async {
          try {
            var response = SignInResponse.fromJson(value);

            if (response.error == 0) {
              if (response.user != null) {
                saveUser(response.user!);
              }
              Storage.saveValue(Constants.uID, "${response.user!.id}");
              Storage.saveValue(Constants.name, "${response.user!.name}");
              Storage.saveValue(
                  Constants.image, "${getImageUrl(response.user!.avatar)}");
              Storage.saveValue(
                  Constants.userId, "Bearer ${response.user!.id}");
              Storage.saveValue(Constants.rememberMe,
                  isRemember.value == true ? "Yes" : "No");
              Storage.saveValue(
                      Constants.token, "Bearer ${response.accessToken}")
                  .whenComplete(() async {
                Response fcmResponse = await _apiHelper.postApi(
                    AppUrl.fcbToken, {"fcbToken": FirebaseMessages().fcmToken});
                print("FCM_RESPONSE======>" + fcmResponse.body.toString());
                Utils.showSnackbar("Login Successfully");
                Get.offNamed(Routes.DASHBOARD);
              });
            } else {
              Utils.showSnackbar("Invalid Credentials");
            }
          } catch (e, trace) {
            log(e.toString(), stackTrace: trace);
          }
        },
        retryFunction: login,
      );
    }
  }

  redirctToSignUp() {
    Get.toNamed(Routes.SIGN_UP);
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

  final forgotPasstextCont = TextEditingController();

  Future<void> forgotPassword() async {
    LoadingDialog.showLoadingDialog();

    try {
      var body = {"email": forgotPasstextCont.text};
      Response response = await _apiHelper.postApi(
        AppUrl.forgotPassword,
        body,
      );

      print(body);
      if (response.statusCode == 200) {
        LoadingDialog.closeLoadingDialog();
        if (response.body['error'] == '0') {
          Get.back();
          checkEmailBottomSheet();
        } else {
          Utils.showSnackbar(
              response.body['message'] ?? "Something went wrong!!!");
        }
      }
    } catch (e) {
      LoadingDialog.closeLoadingDialog();
      print(e.toString());
    }
  }

  checkEmailBottomSheet() {
    return Get.bottomSheet(
      barrierColor: Colors.black.withOpacity(.6),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.0),
              topLeft: Radius.circular(24.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
              ),
              child: Column(children: [
                SvgPicture.asset(AppImages.bottomHeader),
                SizedBox(height: Get.height * .05),
                SvgPicture.asset(AppImages.checkMail),
                SizedBox(height: Get.height * .03),
                Text(
                  Strings.checkEmail,
                  style: beVietnamProaBold.copyWith(
                      color: AppColors.appTheme, fontSize: 24),
                ),
                SizedBox(height: Get.height * .03),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We have sent a password recovery instructions\nemail to ",
                        style: urbanistMedium.copyWith(
                          color: '#9EA4A0'.fromHex,
                          fontSize: getProportionalFontSize(16),
                        ),
                        children: [
                          TextSpan(
                            text: forgotPasstextCont.text,
                            style: urbanistMedium.copyWith(
                                color: AppColors.appTheme, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * .03),
                DefaultButton(
                  backgroundColor: AppColors.appTheme,
                  height: 60,
                  width: Get.width * .8,
                  onTap: () {
                    Get.back();
                    launch("https://mail.google.com/mail/u/0/#inbox");
                  },
                  buttonText: Strings.goToEmail,
                ),
                SizedBox(height: Get.height * .03),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    forgotPasswordBottomSheet();
                  },
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Didn’t receive the email?  ",
                            style: urbanistMedium.copyWith(
                                color: '#9EA4A0'.fromHex, fontSize: 16),
                            children: [
                              TextSpan(
                                text: "try again",
                                style: urbanistMedium.copyWith(
                                    color: AppColors.appTheme, fontSize: 16),
                              )
                            ])
                      ])),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  GlobalKey<FormState> formKeyFor = GlobalKey<FormState>();
  forgotPasswordBottomSheet() {
    return Get.bottomSheet(
        barrierColor: Colors.black.withOpacity(.6),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            // height: Get.height,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                topLeft: Radius.circular(24.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * .02, horizontal: Get.width * .08),
                child: Form(
                  key: formKeyFor,
                  child: Column(children: [
                    SvgPicture.asset(AppImages.bottomHeader),
                    SizedBox(height: Get.height * .05),
                    SvgPicture.asset(AppImages.forgotPassword),
                    SizedBox(height: Get.height * .03),
                    Text(Strings.forgotPassword,
                        style: beVietnamProaBold.copyWith(
                            color: AppColors.appTheme, fontSize: 22)),
                    SizedBox(height: Get.height * .01),
                    Text(
                      Strings.forgotPassInstrs,
                      style: urbanistMedium.copyWith(
                          color: "#9EA4A0".fromHex, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Get.height * .03),
                    CustomTextFieldWidget(
                      controller: forgotPasstextCont,
                      validator: Validators.validateEmail,
                      addHint: false,
                      hintText: Strings.emailAddress,
                      obscureText: false,
                    ),
                    SizedBox(height: Get.height * .03),
                    DefaultButton(
                      backgroundColor: AppColors.darkGreenColor,
                      width: Get.width * .8,
                      onTap: () async {
                        // checkEmailBottomSheet();

                        if (formKeyFor.currentState!.validate()) {
                          forgotPassword();
                        }

                        // final backButton = await Navigator.of(Get.context!).push<bool?>(
                        //   PageRouteBuilder(
                        //     opaque: false,
                        //     barrierDismissible: true,
                        //     pageBuilder: (_, __, ___) => checkEmailBottomSheet(),
                        //   ),
                        // );
                        // if (backButton == null || backButton == false) {
                        //   if (backButton == true) Navigator.of(Get.context!).pop();
                        // }
                      },
                      buttonText: 'Send Email',
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  // checkUser(auth.User user) {
  //   _apiHelper.getApi(AppUrl.checkUser + user.email!).futureValue(
  //     (value) {
  //       if (value["error"] == null) {
  //         dprint(value);
  //         register(user);
  //       } else {
  //         loginSocial(user);
  //       }
  //     },
  //     retryFunction: () {},
  //   );
  // }
  //
  // signInWithGoogle() async {
  //   // await Authentication.signOut(context: Get.context!);
  //   auth.User? user =
  //       await Authentication.signInWithGoogle(context: Get.context!);
  //   dprint(user);
  //   checkUser(user!);
  // }
  //
  // void register(auth.User user) {
  //   // var body = {
  //   //   'email': user.email,
  //   //   'password': user.uid,
  //   //   'name': user.displayName,
  //   //   'typeReg': 'google',
  //   //   'photoUrl': user.photoURL
  //   // };
  //   var body = {
  //     'email': user.email,
  //     'password': user.uid,
  //     'name': user.displayName,
  //     'phone': user.phoneNumber ?? '',
  //     'child_cat': 1
  //   };
  //   // if (formKey.currentState!.validate()) {
  //   _apiHelper.postApi(AppUrl.register, body).futureValue(
  //     (value) {
  //       loginSocial(user);
  //     },
  //     retryFunction: () {},
  //   );
  //   // }
  // }
  //
  // void loginSocial(auth.User user) {
  //   var body = {'email': user.email, 'password': user.uid, "owner": "true"};
  //   _apiHelper.postApi(AppUrl.login, body).futureValue(
  //     (value) async {
  //       try {
  //         var response = SignInResponse.fromJson(value);
  //
  //         if (response.error == 0) {
  //           if (response.user != null) {
  //             saveUser(response.user!);
  //           }
  //           Storage.saveValue(Constants.uID, "${response.user!.id}");
  //           Storage.saveValue(Constants.name, "${response.user!.name}");
  //           Storage.saveValue(
  //               Constants.image, "${getImageUrl(response.user!.avatar)}");
  //           Storage.saveValue(Constants.userId, "Bearer ${response.user!.id}");
  //           Storage.saveValue(
  //               Constants.rememberMe, isRemember.value == true ? "Yes" : "No");
  //           Storage.saveValue(Constants.token, "Bearer ${response.accessToken}")
  //               .whenComplete(() {
  //             Utils.showSnackbar("Login Successfully");
  //             Get.offNamed(Routes.DASHBOARD);
  //           });
  //         } else {
  //           Utils.showSnackbar("Invalid Credentials");
  //         }
  //       } catch (e, trace) {
  //         log(e.toString(), stackTrace: trace);
  //       }
  //     },
  //     retryFunction: login,
  //   );
  //   // _apiHelper.postApi(AppUrl.login, body).futureValue(
  //   //   (value) async {
  //   //     try {
  //   //       var response = SignInResponse.fromJson(value);
  //   //       if (response.error == 0) {
  //   //         await Storage.saveValue(Constants.userId, response.user!.id);
  //   //         await Storage.saveValue(
  //   //                 Constants.token, "Bearer ${response.accessToken}")
  //   //             .whenComplete(() => Get.offAllNamed(Routes.DASHBOARD));
  //   //       } else {
  //   //         Utils.showSnackbar(response.message);
  //   //       }
  //   //     } catch (e, trace) {
  //   //       log(e.toString(), stackTrace: trace);
  //   //     }
  //   //   },
  //   //   retryFunction: () {},
  //   // );
  // }
}
