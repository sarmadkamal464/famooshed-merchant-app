import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../common/constants.dart';
import '../../theme/app_text_theme.dart';
import '../sign_up_module/stripe_webview_screen.dart';
import '../widgets/custom_appbar_widget.dart';
import 'my_profile_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder(
        builder: (MyProfileController controller) {
          return controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.transparent)
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        CustomAppbarWidget(
                            title: "My Profile",
                            centerTitle: true,
                            textColor: AppColors.appTheme),
                        SizedBox(height: Get.height * .01),
                        userInfo(),
                        SizedBox(height: Get.height * .01),
                        _tabSection(context),
                        SizedBox(
                          height: getProportionateScreenHeight(70),
                        ),
                        controller.getProfileResponse != null &&
                                (controller.getProfileResponse!.stripeLink ==
                                        null ||
                                    controller.getProfileResponse!.stripeLink!
                                        .isEmpty)
                            ? GestureDetector(
                                onTap: null,
                                child: Container(
                                  height: 60,
                                  width: Get.width * .8,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: HexColor('2BB673'),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(12),
                                      ),
                                      Text(
                                        "Stripe Account Connected!!",
                                        style: urbanistBold.copyWith(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (controller.getProfileResponse != null &&
                                      controller
                                              .getProfileResponse!.stripeLink !=
                                          null &&
                                      controller.getProfileResponse!.stripeLink!
                                          .isNotEmpty) {}
                                  Map<String, dynamic> arg = {
                                    "url":
                                        "${controller.getProfileResponse!.stripeLink!}"
                                  };

                                  await Navigator.push(
                                      Get.context!,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StripeWebViewScreen(data: arg),
                                      ));

                                  controller.getProfile();
                                },
                                child: Container(
                                  height: 60,
                                  width: Get.width * .8,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: HexColor('635BFF'),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "Connect Stripe Account",
                                    style: urbanistBold.copyWith(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                        SizedBox(height: Get.height * .01),
                        // DefaultButton(
                        //     backgroundColor: AppColors.appTheme,
                        //     buttonText: "Connect Stripe",
                        //     width: Get.width * .8,
                        //     onTap: () {
                        //       // Map<String, dynamic> arg = {"url": "${value['stripe_link']}"};
                        //       //
                        //       //   Navigator.pushReplacement(
                        //       //       Get.context!,
                        //       //       MaterialPageRoute(
                        //       //         builder: (context) => StripeWebViewScreen(data: arg),
                        //       //       ));
                        //     }),
                        GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                              barrierDismissible: true,
                              title: "Delete Account",
                              content: Text(
                                "Are you sure you want to delete your account?",
                                textAlign: TextAlign.center,
                                style: AppTextStyle.semiBoldStyle.copyWith(
                                  color: AppColors.mineShaft,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),
                              confirm: TextButton(
                                onPressed: () {
                                  controller.deleteProfile();
                                },
                                child: Text("Yes",
                                    style: AppTextStyle.semiBoldStyle.copyWith(
                                      color: AppColors.redColor,
                                      fontSize: Dimens.fontSize14,
                                    )),
                              ),
                              cancel: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Cancel",
                                    style: AppTextStyle.semiBoldStyle.copyWith(
                                      color: AppColors.mineShaft,
                                      fontSize: Dimens.fontSize14,
                                    )),
                              ),
                            );

                            // controller.deleteProfile();
                          },
                          child: Container(
                            height: 60,
                            width: Get.width * .8,
                            decoration: BoxDecoration(
                                color: AppColors.deleteButton,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppImages.delete,
                                      color: "#E34D4D".fromHex),
                                  const SizedBox(width: 5),
                                  Text("Delete Account",
                                      style: urbanistBold.copyWith(
                                          fontSize: 16, color: Colors.red))
                                ]),
                          ),
                        ),
                        SizedBox(height: Get.height * .12),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  userInfo() {
    return Column(
      children: [
        // const CircleAvatar(radius: 40, backgroundColor: AppColors.appTheme),
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              Constants.imgUrl + controller.getProfileResponse!.user.avatar),
        ),
        const SizedBox(height: 8),
        Text(
          controller.getProfileResponse!.user.name.capitalize.toString(),
          style: beVietnamProaBold.copyWith(
              fontSize: 20, color: AppColors.appTheme),
        ),
        const SizedBox(height: 3),
        Text(
          controller.getProfileResponse!.user.email,
          style: urbanistSemiBold.copyWith(
              fontSize: 16, color: HexColor("9D9D9D")),
        ),
        SizedBox(height: Get.height * .01),
        // SizedBox(
        //   child: Text(
        //     Strings.merchantsDes,
        //     style: urbanistRegular.copyWith(
        //       fontSize: 14,
        //       color: HexColor("#9D9D9D"),
        //       height: 24.0.toFigmaHeight(16),
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        // )
      ],
    );
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
              indicatorColor: AppColors.appTheme,
              // indicator: const UnderlineTabIndicator(
              //   borderSide: BorderSide(color: Color(0xDD613896), width: 8.0),
              //   insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              // ),

              labelColor: AppColors.appTheme,
              unselectedLabelColor: AppColors.appTheme,
              labelStyle: beVietnamProSemiBold.copyWith(
                fontSize: 18,
              ),
              tabs: const [
                Tab(text: "Personal Info"),
                // Tab(text: Strings.shoppingInfo),
              ]),
          SizedBox(
            height: Get.height * .35,
            child: TabBarView(children: [
              personalInfo(),
              // shippingInfo(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget personalInfoItem(
      {required Widget leading,
      required Widget title,
      required Widget subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          SizedBox(height: 32, width: 32, child: leading),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              const SizedBox(
                height: 10,
              ),
              subtitle
            ],
          )
        ],
      ),
    );
  }

  personalInfo() {
    return Column(
      children: [
        personalInfoItem(
            leading: SvgPicture.asset(
              AppImages.photoUpload,
              color: AppColors.appTheme,
              fit: BoxFit.scaleDown,
            ),
            title: Text("Email",
                style: urbanistMedium.copyWith(
                    fontSize: 16, color: AppColors.greyText)),
            subtitle: Text(controller.getProfileResponse!.user.email,
                style: urbanistMedium.copyWith(
                    fontSize: 16, color: AppColors.appTheme))),
        const Divider(),
        personalInfoItem(
          leading: SvgPicture.asset(AppImages.photoUpload,
              color: AppColors.appTheme),
          title: Text("Phone",
              style: urbanistMedium.copyWith(
                  fontSize: 16, color: AppColors.greyText)),
          subtitle: Text(controller.getProfileResponse!.user.phone,
              style: urbanistMedium.copyWith(
                  fontSize: 16, color: AppColors.appTheme)),
        ),
        const Divider(),
        // personalInfoItem(
        //   leading:
        //       SvgPicture.asset(AppImages.location, color: AppColors.appTheme),
        //   title: Text("Location",
        //       style: urbanistMedium.copyWith(
        //           fontSize: 16, color: AppColors.greyText)),
        //   subtitle: Text(controller.getProfileResponse!.user.address,
        //       style: urbanistMedium.copyWith(
        //           fontSize: 16, color: AppColors.appTheme)),
        // ),
      ],
    );
  }

  shippingInfo() {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.width * .1,
          ),
          Row(
            children: [
              shippingInfoItem("Purchased",
                  controller.getProfileResponse!.itemCount + " Items"),
              SizedBox(width: Get.width * .1),
              shippingInfoItem("Amount spent",
                  "£${controller.getProfileResponse!.amountSpent}")
            ],
          ),
          SizedBox(height: Get.width * .1),
          shippingInfoItem(
              "Last purchase",
              controller.getProfileResponse!.lastOrderDate == "No Order"
                  ? "No Order"
                  : DateFormat('d MMM,yyyy').format((DateTime.parse(controller
                      .getProfileResponse!.lastOrderDate
                      .toString()))))
        ],
      ),
    );
  }

  shippingInfoItem(heading, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading,
            style: urbanistMedium.copyWith(
                color: AppColors.appTheme, fontSize: 16)),
        const SizedBox(height: 5),
        Text(value.toString(),
            style: beVietnamProaBold.copyWith(
                color: AppColors.appTheme, fontSize: 20))
      ],
    );
  }
}
