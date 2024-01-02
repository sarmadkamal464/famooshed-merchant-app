import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/data/models/my_stall_response.dart';
import 'package:famooshed_vendor/app/modules/my_stall_module/my_stall_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/loader.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';

class MyStallPage extends GetView<MyStallController> {
  MyStallPage({required this.isHideAppBar});
  bool isHideAppBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isHideAppBar
            ? null
            : CustomAppbarWidget(
                title: "My Stall",
                centerTitle: true,
                textColor: AppColors.appTheme),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<MyStallController>(builder: (controller) {
              if (controller.isLoading.value) {
                return const Center(
                  child: Loader(),
                );
              } else {
                if (controller.getMyStallResponse!.restaurants.isNotEmpty) {
                  var restaurant =
                      controller.getMyStallResponse!.restaurants[0];
                  return Column(
                    children: [
                      Row(
                        children: [
                          restaurant.logo != null
                              ? CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(
                                      Constants.imgUrl + restaurant.logo),
                                )
                              : SizedBox(),
                          const SizedBox(width: 15),
                          Text(
                            restaurant.name ?? '-',
                            style: beVietnamProBold.copyWith(
                                color: AppColors.appTheme, fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                // imageUrl:
                                //     Constants.imgUrl + restaurant.images,
                                imageUrl: restaurant.images != null &&
                                        restaurant.images!.isNotEmpty
                                    ? Constants.imgUrl + restaurant.images!
                                    : "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: SizeConfig.deviceHeight! * .25,
                                  // width: Get.width * .9,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const Loader(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              // Align(
                              //     alignment: Alignment.topRight,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(10.0),
                              //       child: Row(
                              //         mainAxisSize: MainAxisSize.min,
                              //         // mainAxisAlignment: MainAxisAlignment.end,
                              //         children: [
                              //           Container(
                              //               padding: const EdgeInsets.all(5.0),
                              //               decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.circular(5.0),
                              //                   color: AppColors.lightGreen),
                              //               child: SvgPicture.asset(
                              //                   "assets/images/upload.svg")),
                              //           const SizedBox(width: 8),
                              //           Container(
                              //               padding: const EdgeInsets.all(5.0),
                              //               decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.circular(5.0),
                              //                   color: AppColors.lightGreen),
                              //               child: SvgPicture.asset(
                              //                   "assets/images/delete.svg")),
                              //         ],
                              //       ),
                              //     ))
                            ],
                          )),
                      const SizedBox(height: 20),
                      bioCard(restaurant.desc ?? '-'),
                      addressCard(restaurant.businessAddress ?? '-',
                          restaurant.phone ?? '-', restaurant),
                      openingHours(restaurant),
                      linksCard(restaurant.facebook ?? '',
                          restaurant.twitter ?? '', restaurant.instagram ?? ''),
                      DefaultButton(
                        onTap: () async {
                          Get.toNamed(Routes.EDIT_STALL_SCREEN,
                              arguments: restaurant);
                          // await Get.toNamed(Routes.EDIT_STALL_SCREEN,
                          //     arguments: restaurant);
                          // controller.onReady();
                          // controller.isLoading.value = false;
                          // controller.update();
                        },
                        width: Get.width * .6,
                        backgroundColor: AppColors.buttonColor,
                        buttonText: 'Edit Information',
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You don't have any Restaurant. ",
                          style: beVietnamProaBold.copyWith(
                              color: AppColors.appTheme,
                              fontSize: getProportionalFontSize(16)),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.EDIT_STALL_SCREEN);
                            },
                            child: Text(
                              "Add New Restaurant",
                              style: beVietnamProaBold.copyWith(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.appTheme,
                                  fontSize: getProportionalFontSize(16)),
                            )),
                      ],
                    ),
                  );
                }
              }
            }),
          ),
        ));
  }

  Widget bioCard(String bio) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColors.lightGreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bio",
            style: beVietnamProExtraBold.copyWith(
                color: AppColors.appTheme, fontSize: 22),
          ),
          Text(
            bio,
            style: urbanistRegular.copyWith(
                color: AppColors.appTheme, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget addressCard(String address, String phone, Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColors.grey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Address",
                style: urbanistBold.copyWith(
                    color: AppColors.appTheme, fontSize: 18),
              ),
              Text(
                "Phone Number",
                style: urbanistBold.copyWith(
                    color: AppColors.appTheme, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    restaurant.flatNo != null && restaurant.flatNo!.isNotEmpty
                        ? Text(
                            restaurant.flatNo!,
                            style: urbanistRegular.copyWith(
                                color: AppColors.appTheme, fontSize: 14),
                          )
                        : SizedBox(),
                    restaurant.landmark != null &&
                            restaurant.landmark!.isNotEmpty
                        ? Text(
                            restaurant.landmark!,
                            style: urbanistRegular.copyWith(
                                color: AppColors.appTheme, fontSize: 14),
                          )
                        : SizedBox(),
                    Text(
                      address,
                      style: urbanistRegular.copyWith(
                          color: AppColors.appTheme, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                phone,
                style: urbanistRegular.copyWith(
                    color: AppColors.appTheme, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget linksCard(facebook, twitter, instagram) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColors.grey),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/images/link_fb.svg"),
              const SizedBox(width: 10),
              Text(facebook,
                  style: urbanistRegular.copyWith(
                      color: AppColors.appTheme, fontSize: 14))
            ],
          ),
          Row(
            children: [
              SvgPicture.asset("assets/images/link_twitter.svg"),
              const SizedBox(width: 10),
              Text(
                twitter,
                style: urbanistRegular.copyWith(
                    color: AppColors.appTheme, fontSize: 14),
              )
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.appThemeDark,
                  child: SvgPicture.asset("assets/images/insta_logo.svg")),
              const SizedBox(width: 10),
              Text(
                instagram,
                style: urbanistRegular.copyWith(
                    color: AppColors.appTheme, fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget openingHours(Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColors.grey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Opening Hours",
              style: urbanistSemiBold.copyWith(
                  fontSize: 18, color: AppColors.appTheme)),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textKey(
                    "Monday",
                  ),
                  textKey(
                    "Tuesday",
                  ),
                  textKey(
                    "Wednesday",
                  ),
                  textKey(
                    "Thursday",
                  ),
                  textKey(
                    "Friday",
                  ),
                  textKey(
                    "Saturday",
                  ),
                  textKey(
                    "Sunday",
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    textValue(
                      "${restaurant.openTimeMonday} - ${restaurant.closeTimeMonday}",
                    ),
                    textValue(
                      "${restaurant.openTimeTuesday} - ${restaurant.closeTimeTuesday}",
                    ),
                    textValue(
                      "${restaurant.openTimeWednesday} - ${restaurant.closeTimeWednesday}",
                    ),
                    textValue(
                      "${restaurant.openTimeThursday} - ${restaurant.closeTimeThursday}",
                    ),
                    textValue(
                      "${restaurant.openTimeFriday} - ${restaurant.closeTimeFriday}",
                    ),
                    textValue(
                      "${restaurant.openTimeSaturday} - ${restaurant.closeTimeSaturday}",
                    ),
                    textValue(
                      "${restaurant.openTimeSunday} - ${restaurant.closeTimeSunday}",
                    ),
                  ],
                ),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     textKey(
              //       "Saturday",
              //     ),
              //     textKey(
              //       "Sunday",
              //     ),
              //   ],
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     textValue(
              //       "${restaurant.openTimeSaturday} - ${restaurant.closeTimeSaturday}",
              //     ),
              //     textValue(
              //       "${restaurant.openTimeSunday} - ${restaurant.closeTimeSunday}",
              //     ),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }

  Widget textKey(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: urbanistSemiBold.copyWith(fontSize: 14),
      ),
    );
  }

  Widget textValue(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: urbanistRegular.copyWith(fontSize: 14),
      ),
    );
  }
}
