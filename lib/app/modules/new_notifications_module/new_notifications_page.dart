import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/modules/new_notifications_module/new_notifications_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/util/exports.dart';
import '../../data/models/get_notification_response.dart';
import '../../theme/size_config.dart';

class NewNotificationsPage extends GetView<NewNotificationsController> {
  const NewNotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "New Notification",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder<NewNotificationsController>(
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Notification Information",
                      style: beVietnamProExtraBold.copyWith(
                          color: AppColors.appTheme, fontSize: 22)),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: AppColors.lightGreen),
                      child: productInformation())
                ],
              ),
            ),
          ),
        ));
  }

  Widget productInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(Strings.user),
          // textField(
          //   "Send to All Users",
          //   true,
          // ),
          DropdownSearch<NotificationDriverUser>(
            enabled: true,
            popupProps: PopupProps.menu(
              listViewProps: ListViewProps(),
              itemBuilder: (context, item, isSelected) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(16),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16),
                  ),
                  child: Text(
                    item.name.toString(),
                    style: TextStyle(
                        fontSize: getProportionalFontSize(13),
                        overflow: TextOverflow.visible,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                );
              },
              searchDelay: Duration.zero,
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: "Search here",
                  hintStyle: TextStyle(
                      fontSize: getProportionalFontSize(12),
                      overflow: TextOverflow.visible,
                      color: AppColors.lightBlack),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.only(
                    top: getProportionateScreenHeight(4),
                    bottom: getProportionateScreenHeight(4),
                    left: getProportionateScreenWidth(16),
                    right: getProportionateScreenWidth(16),
                  ),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.lightBlack),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.appTheme),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.appTheme),
                  ),
                ),
              ),
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.only(
                  top: getProportionateScreenHeight(4),
                  bottom: getProportionateScreenHeight(4),
                  left: getProportionateScreenWidth(16),
                  right: getProportionateScreenWidth(16),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.lightBlack),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.appTheme)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.appTheme)),
              ),
            ),
            dropdownButtonProps: DropdownButtonProps(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: getProportionalFontSize(12),
                  ),
                ),
                side: MaterialStateProperty.all(
                  BorderSide(color: AppColors.appTheme),
                ),
              ),
            ),
            selectedItem: controller.selectedUser,
            items: controller.usersList,
            validator: (value) {
              if (value == null) {
                return 'Please select user';
              }
              return null;
            },
            onChanged: (T) {
              controller.selectedUser = T as NotificationDriverUser;
              controller.update();
            },
            itemAsString: (item) => item.name!,
          ),
          // ButtonTheme(
          //   alignedDropdown: true,
          //   child: DropdownButtonFormField<Iuser>(
          //     isExpanded: false,
          //     isDense: true,
          //     alignment: Alignment.bottomLeft,
          //     icon: Icon(Icons.keyboard_arrow_down),
          //     borderRadius: BorderRadius.circular(8),
          //     decoration: InputDecoration(
          //       fillColor: Colors.white,
          //       filled: true,
          //       contentPadding: EdgeInsets.only(
          //         top: getProportionateScreenHeight(4),
          //         bottom: getProportionateScreenHeight(4),
          //         left: getProportionateScreenWidth(0),
          //         right: getProportionateScreenWidth(6),
          //       ),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide.none),
          //       focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide.none),
          //       enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide.none),
          //     ),
          //     validator: (value) {
          //       if (value == null) {
          //         return 'Please select user';
          //       }
          //       return null;
          //     },
          //     items: controller.usersList
          //         .map(
          //           (item) => DropdownMenuItem<Iuser>(
          //             value: item,
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   item.name.toString(),
          //                   style: TextStyle(
          //                       fontSize: getProportionalFontSize(12),
          //                       overflow: TextOverflow.visible,
          //                       color: Colors.black),
          //                   textAlign: TextAlign.start,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //         .toList(),
          //     onChanged: (T) {
          //       controller.selectedUser = T as Iuser;
          //       controller.update();
          //     },
          //     value: controller.selectedUser,
          //     hint: const Text("Select User"),
          //     style: TextStyle(fontSize: getProportionalFontSize(12)),
          //   ),
          // ),

          text("Schedule it"),

          // SizedBox(height: getProportionateScreenHeight(8),),
          CustomTextFieldWidget(
            controller: controller.scheduleController,
            maxLength: 6,
            fillColor: AppColors.white,
            obscureText: false,
            readOnly: true,
            onTap: () async {
              // DateTime? dateTime = await DatePicker.showDateTimePicker(
              //   navigator!.context,
              //   minTime: DateTime.now(),
              //   currentTime: DateTime.now(),
              //   showTitleActions: true,
              //   theme: d.DatePickerTheme(
              //     doneStyle: TextStyle(
              //         color: AppColors.appTheme,
              //         fontSize: getProportionalFontSize(15),
              //         fontWeight: FontWeight.w500),
              //   ),
              // );
              // if (dateTime != null) {
              //   controller.scheduleController.text = dateTime
              //       .formatedDate(dateFormat: 'yyyy-MM-ddThh:mm')
              //       .toString();
              //   print(controller.scheduleController.text);
              //   controller.update();
              // }
              DateTime currentDateTime = DateTime.now().toLocal();
              if (controller.scheduleController.text.isNotEmpty) {
                currentDateTime = DateFormat('yyyy-MM-ddTHH:mm')
                    .parse(controller.scheduleController.text);

                // DateTime.parse(controller.scheduleController.text).formatedDate(dateFormat: 'yyyy-MM-ddTHH:mm');
              }
              DateTime? dateTime = await DatePicker.showDateTimePicker(
                Get.context!,
                currentTime: currentDateTime,
              );
              if (dateTime != null) {
                controller.scheduleController.text =
                    DateFormat('yyyy-MM-ddTHH:mm').format(dateTime);
                controller.update();
              }
            },
            hintText: "dd/mm/yyyy, --:--",
            hintStyle: urbanistRegular.copyWith(
                fontSize: 14, color: AppColors.doveGray),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.white)),
          ),
          // textField("Now", true),
          text(Strings.title),
          textField("Insert message title", false,
              textController: controller.titleController),
          text(Strings.message),
          customTextArea("Insert description.\nMax 250 symbols",
              controller.descriptionContoller),
          const SizedBox(height: 20),
          DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              color: AppColors.doveGray,
              child: controller.editImageUrl.isNotEmpty
                  ? GestureDetector(
                      onTap: () async {
                        File? selectedFile = await Utils.getImage(source: 0);
                        if (selectedFile != null) {
                          // controller.addNewFile = File(selectedFile.path);
                          controller.uploadProductImage(selectedFile.path);
                        }
                      },
                      child: Container(
                        width: Get.width * .9,
                        height: Get.height * .18,
                        padding:
                            EdgeInsets.symmetric(vertical: 28, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: CachedNetworkImageProvider(
                                Constants.imgUrl + controller.editImageUrl,
                              ),
                            ),
                            color: AppColors.grey),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        File? selectedFile = await Utils.getImage(source: 0);
                        if (selectedFile != null) {
                          // controller.addNewFile = File(selectedFile.path);
                          controller.uploadProductImage(selectedFile.path);
                        }
                      },
                      child: Container(
                        width: Get.width * .9,
                        height: SizeConfig.deviceHeight! * .2,
                        padding:
                            EdgeInsets.symmetric(vertical: 28, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey),
                        child: Column(
                          children: [
                            SvgPicture.asset("assets/images/imageplace.svg",
                                height: 48),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/upload.svg",
                                    height: 22),
                                const SizedBox(width: 8),
                                Text(
                                  "Drop File Here\nor click to upload",
                                  style: beVietnamProExtraBold.copyWith(
                                      color: AppColors.appTheme, fontSize: 13),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
          SizedBox(height: Get.height * .02),
          Center(
            child: DefaultButton(
              onTap: () {
                controller.sendNotification();
              },
              width: Get.width * .4,
              buttonText: 'Save',
            ),
          ),
        ],
      ),
    );
  }

  text(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: urbanistRegular.copyWith(fontSize: 16)),
    );
  }

  Widget textField(hintText, readonly, {textController}) {
    return CustomTextFieldWidget(
      controller: textController,
      // maxLength: 6,
      fillColor: AppColors.white,
      obscureText: false,
      readOnly: readonly,
      hintText: hintText,
      hintStyle:
          urbanistRegular.copyWith(fontSize: 14, color: AppColors.doveGray),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.white)),
    );
  }

  Widget customTextArea(hintText, textController) {
    return TextFormField(
      controller: textController,
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        hintText: hintText,
        hintStyle:
            urbanistRegular.copyWith(fontSize: 14, color: AppColors.doveGray),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white)),
        fillColor: AppColors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white)),
      ),
    );
  }

  Widget clickToUpload(
      double height, double width, double radius, double imageSize, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Get.width * .9,
        padding: EdgeInsets.symmetric(vertical: height, horizontal: width),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: AppColors.grey),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/imageplace.svg", height: imageSize),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/upload.svg", height: 22),
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: Text(
                    "Drop Files Here\nor click to upload",
                    style: beVietnamProExtraBold.copyWith(
                        color: AppColors.appTheme, fontSize: 13),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
