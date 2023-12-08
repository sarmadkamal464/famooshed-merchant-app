import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/modules/sign_in_module/sign_in_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: CustomAppbarWidget(
          addBackButton: false,
          centerTitle: true,
          backgroundColor: AppColors.backgroundColor,
          statusBarColor: AppColors.backgroundColor,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: GetBuilder(
            builder: (SignInController signInController) {
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(AppImages.backgroundImage))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Get.height * .02),
                            child: Form(
                              key: signInController.signinFormKey,
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppImages.famooshedLogo),
                                  SizedBox(height: Get.height * .01),
                                  Text("Sign In",
                                      style: beVietnamProBold.copyWith(
                                          fontSize: 30,
                                          color: AppColors.appTheme)),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * .02),
                                    child: Container(
                                      height: 350,
                                      width: 398,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: Get.width * .04),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: AppColors.appTheme),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(children: [
                                          customInputField(
                                            "Email",
                                            "Enter Email",
                                            false,
                                            signInController.emailController,
                                            // Validators.validateEmail,
                                          ),
                                          SizedBox(height: Get.height * .02),
                                          customInputField(
                                            "Password",
                                            "Enter Password",
                                            true,
                                            signInController.passController,
                                            // Validators.validatePassword,
                                          ),
                                          SizedBox(height: Get.height * .01),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                  value: signInController
                                                      .isRemember.value,
                                                  checkColor:
                                                      AppColors.buttonColor,
                                                  fillColor:
                                                      const MaterialStatePropertyAll(
                                                          AppColors.white),
                                                  onChanged: (v) {
                                                    if (v != null) {
                                                      signInController
                                                          .isRemember.value = v;
                                                      signInController.update();
                                                    }
                                                  }),
                                              Text(
                                                "Remember me",
                                                style: urbanistMedium.copyWith(
                                                    fontSize: 18,
                                                    color: AppColors.white),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: Get.height * .01),
                                          DefaultButton(
                                            buttonText: Strings.login,
                                            width: 180,
                                            height: 50,
                                            onTap: () {
                                              signInController.login();
                                            },
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * .02),
                                  InkWell(
                                    onTap: () {
                                      controller.forgotPasswordBottomSheet();
                                    },
                                    child: Text(
                                      Strings.forgotPassword,
                                      style: urbanistSemiBold.copyWith(
                                          color: AppColors.appTheme,
                                          fontSize: 18,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColors.appTheme),
                                    ),
                                  ),
                                  // SizedBox(height: Get.height * .04),
                                  // Text(
                                  //   Strings.signInWith,
                                  //   style: urbanistMedium.copyWith(
                                  //       color: AppColors.appTheme, fontSize: 16),
                                  // ),
                                  // SizedBox(height: Get.height * .03),
                                  // InkWell(
                                  //   onTap: () {
                                  //     controller.signInWithGoogle();
                                  //   },
                                  //   child: CustomIconButtonWidget(
                                  //       text: Strings.signInWithGoogle,
                                  //       buttonColor: AppColors.lightWhite,
                                  //       color: AppColors.white,
                                  //       textColor: AppColors.black,
                                  //       width: Get.width * .65,
                                  //       logo: AppImages.googleLogo),
                                  // ),
                                  // SizedBox(height: Get.height * .02),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     final credential =
                                  //         await SignInWithApple.getAppleIDCredential(
                                  //       scopes: [
                                  //         AppleIDAuthorizationScopes.email,
                                  //         AppleIDAuthorizationScopes.fullName,
                                  //       ],
                                  //     );
                                  //
                                  //     print(credential);
                                  //   },
                                  //   child: CustomIconButtonWidget(
                                  //       text: Strings.signInWithApple,
                                  //       buttonColor: AppColors.black,
                                  //       color: AppColors.lightBlack,
                                  //       textColor: AppColors.white,
                                  //       width: Get.width * .65,
                                  //       logo: AppImages.appleLogo),
                                  // ),
                                  // SizedBox(height: Get.height * .02),
                                  // CustomIconButtonWidget(
                                  //     text: Strings.signInWithFacebook,
                                  //     textColor: AppColors.white,
                                  //     buttonColor: AppColors.blueColor,
                                  //     color: AppColors.lightBlue,
                                  //     width: Get.width * .65,
                                  //     logo: AppImages.facebooklogo),
                                  SizedBox(height: Get.height * .03),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          signInController.redirctToSignUp();
                        },
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  style: urbanistMedium.copyWith(
                                      color: AppColors.appTheme, fontSize: 16),
                                  text: Strings.donotHaveAcc,
                                  children: [
                                    TextSpan(
                                      text: Strings.createAcc,
                                      style: urbanistBold.copyWith(
                                          color: AppColors.appTheme,
                                          fontSize: 16),
                                    )
                                  ])
                            ])),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget customInputField(text, hintText, obscureText, controller) {
    return Container(
      height: 70,
      width: 340,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0), color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, bottom: 0.0),
              child: Text(text,
                  style: urbanistSemiBold.copyWith(
                      fontSize: 18, color: AppColors.appTheme))),
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: CustomTextFieldWidget(
                // validator: validator,
                controller: controller,
                obscureText: obscureText,
                hintText: hintText,
                hintStyle: urbanistMedium.copyWith(
                    fontSize: 16, color: AppColors.appThemeGrey),
                fillColor: AppColors.white,
                border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
