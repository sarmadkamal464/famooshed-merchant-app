import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/modules/my_new_promotions_module/my_notifications_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_default_icon_button.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../data/models/get_notification_response.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyNotificationsPage extends GetView<MyNotificationsController> {
  MyNotificationsPage({required this.isHideAppBar});
  bool isHideAppBar;
  ScrollController? listController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isHideAppBar
            ? null
            : CustomAppbarWidget(
                // title: "My Promotions",
                title: "Notifications",
                centerTitle: true,
                textColor: AppColors.appTheme),
        body: GetBuilder<MyNotificationsController>(
          init: MyNotificationsController(),
          initState: (state) {
            print("initState");
            listController ??= ScrollController()
              ..addListener(() {
                if (listController!.position.pixels ==
                    listController!.position.maxScrollExtent) {
                  print("Listen");
                  controller.loadNextPage();
                }
              });
          },
          dispose: (state) {
            listController!.dispose();

            print("DISPOSE");
          },
          builder: (controller) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Row(
                  children: [
                    DefaultIconButton(
                      onTap: () async {
                        Map<String, dynamic> args = {"edit": "0", "editId": ""};
                        await Get.toNamed(Routes.NEW_NOTIFICATIONS,
                            arguments: args);
                        // controller.update();
                        // controller.getAllNotification();
                      },
                      width: Get.width * .45,
                      backgroundColor: AppColors.buttonColor,
                      buttonText: 'Send New',
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                        child: CustomTextFieldWidget(
                      controller: controller.searchController,
                      prefixIconPadding:
                          const EdgeInsets.only(left: 15, right: 10),
                      prefixIcon: SvgPicture.asset(AppIcons.search),
                      obscureText: false,
                      hintText: "Search",
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          controller.isSearch.value = true;
                        } else {
                          controller.isSearch.value = false;
                        }
                        controller.update();
                        controller.getFilterNotificationList(value);
                      },
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: AppColors.appTheme)),
                    ))
                  ],
                ),
                const Divider(thickness: 1, height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("List",
                        style: beVietnamProExtraBold.copyWith(
                            fontSize: 24, color: AppColors.appTheme)),
                    // CircleAvatar(
                    //     radius: 25,
                    //     backgroundColor: AppColors.appTheme,
                    //     child: SvgPicture.asset(AppIcons.filter))
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    controller.deleteNotification();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Remove"),
                      const SizedBox(width: 8),
                      SvgPicture.asset("assets/images/delete.svg")
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.ADD_NEW_COUPONS);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        child: ListView.builder(
                          controller: listController,
                          itemCount: controller.isSearch.value
                              ? controller.filterNotificationList.length
                              : controller.notificationList.length,
                          padding: const EdgeInsets.only(top: 8),
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller.isSearch.value
                                ? controller.filterNotificationList[index]
                                : controller.notificationList[index];
                            return driverItems(data);
                          },
                        )),
                  ),
                ),
              ])),
        ));
  }

  Widget driverItems(NotoficationDataItem notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Obx(() => Checkbox(
                      value:
                          controller.selectedCategory.contains(notification.id),
                      onChanged: (v) {
                        if (controller.selectedCategory
                            .contains(notification.id)) {
                          controller.selectedCategory
                              .remove(notification.id); // unselect
                        } else {
                          controller.selectedCategory
                              .add(notification.id ?? 0); // select
                        }
                        controller.update();
                      },
                      activeColor: AppColors.white,
                      checkColor: AppColors.appTheme,
                    )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${notification.title ?? '-'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: urbanistSemiBold.copyWith(fontSize: 14)),
                          const SizedBox(height: 5),
                          Text(notification.text ?? '-',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: urbanistMedium.copyWith(fontSize: 14)),
                          // Text("John L.",
                          //     style: urbanistExtraBold.copyWith(fontSize: 14)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.VIEW_NOTIFICATIONS,
                                arguments: notification);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.doveGray.withOpacity(.2)),
                                color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  Text("View",
                                      style: urbanistSemiBold.copyWith(
                                          fontSize: 14)),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.remove_red_eye_outlined,
                                      size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * .01),
                        InkWell(
                          onTap: () async {
                            Map<String, dynamic> args = {
                              "edit": "1",
                              "editId": notification.id.toString(),
                              "notification": notification
                            };
                            await Get.toNamed(Routes.NEW_NOTIFICATIONS,
                                arguments: args);
                            // controller.update();
                            // controller.getAllNotification();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.doveGray.withOpacity(.2)),
                                color: AppColors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Edit",
                                    style:
                                        urbanistSemiBold.copyWith(fontSize: 14),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.edit, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * .01),

                        Row(
                          children: [
                            Text("Statistics: ",
                                style: urbanistSemiBold.copyWith(
                                    fontSize: 14, color: AppColors.doveGray)),
                            Text(
                              "Delivered",
                              style: urbanistSemiBold.copyWith(
                                  fontSize: 14, color: AppColors.doveGray),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // const Spacer(),
            ],
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
