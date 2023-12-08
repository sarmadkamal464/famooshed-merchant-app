import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../libraries/dotted_container/dotted_border.dart';
import '../../common/util/exports.dart';
import 'edit_stall_controller.dart';

class EditStallPage extends GetView<EditStallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: controller.args != null ? "Edit My Stall" : "Add New Stall",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<EditStallController>(
            builder: (controller) {
              return Container(
                color: AppColors.lightGreen,
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(8),
                    horizontal: getProportionateScreenWidth(8)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Utils.showImagePicker(
                            onGetImage: (image) {
                              Get.back();
                              controller.uploadProductImage(image.path, 'BIO');
                            },
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                controller.bioUrl.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 38,
                                        backgroundImage:
                                            NetworkImage(controller.bioUrl),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        padding: EdgeInsets.all(28),
                                        child: Icon(Icons.add_a_photo_outlined),
                                      ),
                                Positioned(
                                  bottom: -5,
                                  right: -1,
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: AppColors.lightGreen),
                                    child: SvgPicture.asset(
                                        "assets/images/upload.svg"),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: CustomTextFieldWidget(
                                controller: controller.stallNameController,
                                fillColor: AppColors.white,
                                prefixIconPadding:
                                    const EdgeInsets.only(left: 15, right: 10),
                                obscureText: false,
                                hintText: "Enter stall name",
                                hintStyle: AppTextStyle.regularStyle.copyWith(
                                  color: AppColors.greyText,
                                  fontSize: Dimens.fontSize13,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    borderSide: const BorderSide(
                                        color: AppColors.white)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      Text(
                        "Bio",
                        style: beVietnamProExtraBold.copyWith(
                            color: AppColors.appTheme, fontSize: 22),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      // CustomTextFieldWidget(
                      //   controller: controller.bioController,
                      //   fillColor: AppColors.white,
                      //   maxLines: 5,
                      //   minLines: 1,
                      //   enabled: true,
                      //   prefixIconPadding:
                      //       const EdgeInsets.only(left: 15, right: 10),
                      //   obscureText: false,
                      //   hintText: "Enter stall bio",
                      //   hintStyle: AppTextStyle.regularStyle.copyWith(
                      //     color: AppColors.greyText,
                      //     fontSize: Dimens.fontSize13,
                      //   ),
                      //   border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(11),
                      //       borderSide:
                      //           const BorderSide(color: AppColors.white)),
                      // ),

                      TextFormField(
                        controller: controller.bioController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 12),
                          hintText: "Enter stall bio",
                          hintStyle: urbanistRegular.copyWith(
                              fontSize: 14, color: AppColors.doveGray),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.white)),
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: AppColors.white)),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      Text(
                        "Flat / House no / Floor / Building ",
                        style: urbanistBold.copyWith(
                            color: AppColors.appTheme, fontSize: 18),
                      ),
                      CustomTextFieldWidget(
                        controller: controller.flatNoController,
                        fillColor: AppColors.white,
                        prefixIconPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        obscureText: false,
                        hintText: "Enter Flat / House no / Floor / Building",
                        hintStyle: AppTextStyle.regularStyle.copyWith(
                          color: AppColors.greyText,
                          fontSize: Dimens.fontSize13,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide:
                                const BorderSide(color: AppColors.white)),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      Text(
                        "Nearby landmark",
                        style: urbanistBold.copyWith(
                            color: AppColors.appTheme, fontSize: 18),
                      ),
                      CustomTextFieldWidget(
                        controller: controller.landMarkController,
                        fillColor: AppColors.white,
                        prefixIconPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        obscureText: false,
                        hintText: "Enter nearby landmark",
                        hintStyle: AppTextStyle.regularStyle.copyWith(
                          color: AppColors.greyText,
                          fontSize: Dimens.fontSize13,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide:
                                const BorderSide(color: AppColors.white)),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style: urbanistBold.copyWith(
                                      color: AppColors.appTheme, fontSize: 18),
                                ),
                                CustomTextFieldWidget(
                                  controller: controller.addressController,
                                  fillColor: AppColors.white,
                                  prefixIconPadding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  obscureText: false,
                                  readOnly: true,
                                  onTap: () {
                                    controller.handlePressButton();
                                  },
                                  hintText: "Enter stall address",
                                  hintStyle: AppTextStyle.regularStyle.copyWith(
                                    color: AppColors.greyText,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11),
                                      borderSide: const BorderSide(
                                          color: AppColors.white)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(8),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: urbanistBold.copyWith(
                                      color: AppColors.appTheme, fontSize: 18),
                                ),
                                CustomTextFieldWidget(
                                  controller: controller.phoneController,
                                  fillColor: AppColors.white,
                                  prefixIconPadding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  obscureText: false,
                                  hintText: "Enter stall contact",
                                  hintStyle: AppTextStyle.regularStyle.copyWith(
                                    color: AppColors.greyText,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11),
                                      borderSide: const BorderSide(
                                          color: AppColors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      Text(
                        "Opening Hours",
                        style: urbanistBold.copyWith(
                            color: AppColors.appTheme, fontSize: 18),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          openingHourCard(
                              "MONDAY",
                              controller.mondayStartController,
                              controller.mondayEndController),
                          openingHourCard(
                              "TUESDAY",
                              controller.tuesdayStartController,
                              controller.tuesdayEndController),
                          openingHourCard(
                              "WEDNESDAY",
                              controller.wedStartController,
                              controller.wedEndController),
                          openingHourCard(
                              "THURSDAY",
                              controller.thuStartController,
                              controller.thuEndController),
                          openingHourCard(
                              "FRIDAY",
                              controller.friStartController,
                              controller.friEndController),
                          openingHourCard(
                              "SATURDAY",
                              controller.satStartController,
                              controller.satEndController),
                          openingHourCard(
                              "SUNDAY",
                              controller.sunStartController,
                              controller.sunEndController),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(18),
                      ),
                      InkWell(
                        onTap: () async {
                          Utils.showImagePicker(
                            onGetImage: (image) {
                              Get.back();
                              controller.uploadProductImage(
                                  image.path, 'IMAGE');
                            },
                          );
                        },
                        child: controller.imageUrl.isNotEmpty
                            ? Container(
                                padding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(8),
                                    right: getProportionateScreenWidth(8)),
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(
                                    left: getProportionateScreenWidth(10)),
                                height: getProportionateScreenHeight(180),
                                decoration: BoxDecoration(
                                    color: Color(0xFFF4F4F4),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            controller.imageUrl),
                                        fit: BoxFit.cover)),
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(
                                      left: getProportionateScreenWidth(5),
                                      right: getProportionateScreenWidth(5)),
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEBF9DC),
                                      borderRadius: BorderRadius.circular(3)),
                                  child: SvgPicture.asset(
                                    AppImages.photoUpload,
                                    width: getProportionateScreenWidth(15),
                                    height: getProportionateScreenHeight(15),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                    right: getProportionateScreenWidth(10),
                                    top: getProportionateScreenHeight(10)),
                                height: getProportionateScreenHeight(180),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: DottedBorder(
                                    radius: Radius.circular(10),
                                    strokeCap: StrokeCap.butt,
                                    color: AppColors.appTheme,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.photoUpload,
                                            fit: BoxFit.cover,
                                            height:
                                                getProportionateScreenHeight(
                                                    25),
                                            width:
                                                getProportionateScreenWidth(25),
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(5),
                                          ),
                                          Text(
                                            "Click To\nUpload An\nImage",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: AppColors.appTheme,
                                                height: 1.5,
                                                fontSize:
                                                    getProportionalFontSize(11),
                                                fontWeight: FontWeight.w800),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(18),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset("assets/images/link_fb.svg"),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextFieldWidget(
                                  controller: controller.facebookController,
                                  fillColor: AppColors.white,
                                  prefixIconPadding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  obscureText: false,
                                  isDense: true,
                                  hintText: "https://www.facebook.com/",
                                  hintStyle: AppTextStyle.regularStyle.copyWith(
                                    color: AppColors.greyText,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: AppColors.white)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/images/link_twitter.svg"),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextFieldWidget(
                                  controller: controller.twitterController,
                                  fillColor: AppColors.white,
                                  prefixIconPadding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  obscureText: false,
                                  isDense: true,
                                  hintText: "https://www.twitter.com/",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: AppColors.white)),
                                  hintStyle: AppTextStyle.regularStyle.copyWith(
                                    color: AppColors.greyText,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(8),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: AppColors.appThemeDark,
                                child: SvgPicture.asset(
                                    "assets/images/insta_logo.svg"),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextFieldWidget(
                                  controller: controller.instaController,
                                  fillColor: AppColors.white,
                                  prefixIconPadding: const EdgeInsets.only(
                                      left: 15, right: 10),
                                  obscureText: false,
                                  isDense: true,
                                  hintText: "https://www.instagram.com/",
                                  hintStyle: AppTextStyle.regularStyle.copyWith(
                                    color: AppColors.greyText,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: AppColors.white)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(16),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: DefaultButton(
                          onTap: () {
                            controller.saveInformation();
                          },
                          width: Get.width * .6,
                          backgroundColor: AppColors.buttonColor,
                          buttonText: 'Save',
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  openingHourCard(
    String day,
    TextEditingController startTimeController,
    TextEditingController endTimeController,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            day,
            style: urbanistSemiBold.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          width: getProportionateScreenWidth(5),
        ),
        Flexible(
          child: CustomTextFieldWidget(
            controller: startTimeController,
            fillColor: AppColors.white,
            prefixIconPadding: const EdgeInsets.only(left: 15, right: 10),
            obscureText: false,
            hintText: "00:00",
            readOnly: true,
            hintStyle: AppTextStyle.regularStyle.copyWith(
              color: AppColors.greyText,
              fontSize: Dimens.fontSize13,
            ),
            isDense: true,
            onTap: () async {
              TimeOfDay? timeStart = await showTimePicker(
                context: Get.context!,
                initialTime: TimeOfDay.now(),
              );

              if (timeStart != null) {
                startTimeController.text = timeStart.format(Get.context!);
                controller.update();
              }
            },
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(11),
            //     borderSide: const BorderSide(
            //         color: AppColors.white)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('--'),
        ),
        Flexible(
          child: CustomTextFieldWidget(
            controller: endTimeController,
            fillColor: AppColors.white,
            isDense: true,
            readOnly: true,

            prefixIconPadding: const EdgeInsets.only(left: 15, right: 10),
            obscureText: false,
            hintText: "00:00",
            hintStyle: AppTextStyle.regularStyle.copyWith(
              color: AppColors.greyText,
              fontSize: Dimens.fontSize13,
            ),
            onTap: () async {
              TimeOfDay? timeStart = await showTimePicker(
                context: Get.context!,
                initialTime: TimeOfDay.now(),
              );

              if (timeStart != null) {
                endTimeController.text = timeStart.format(Get.context!);
                controller.update();
              }
            },
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.circular(11),
            //     borderSide: const BorderSide(
            //         color: AppColors.white)),
          ),
        ),
      ],
    );
  }
}
