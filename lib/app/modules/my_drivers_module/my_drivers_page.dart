import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/modules/my_drivers_module/my_drivers_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_default_icon_button.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../../common/util/exports.dart';
import '../../data/models/get_my_driver_response.dart';
import '../../theme/size_config.dart';

class MyDriversPage extends GetView<MyDriversController> {
  MyDriversPage({Key? key}) : super(key: key);
  GlobalKey btnKey3 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
          title: "My Drivers",
          centerTitle: true,
          textColor: AppColors.appTheme),
      body: GetBuilder(
        builder: (MyDriversController driversController) {
          return SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  Row(
                    children: [
                      DefaultIconButton(
                        onTap: () {
                          Get.toNamed(
                            Routes.ADD_NEW_DRIVER,
                          );
                        },
                        width: Get.width * .45,
                        backgroundColor: AppColors.buttonColor,
                        buttonText: 'New Driver',
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                          child: CustomTextFieldWidget(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.getMyDrivers(false);
                        },
                        prefixIconPadding:
                            const EdgeInsets.only(left: 15, right: 10),
                        prefixIcon: SvgPicture.asset(AppIcons.search),
                        obscureText: false,
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(color: AppColors.appTheme)),
                      ))
                    ],
                  ),
                  const Divider(thickness: 1, height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text("Inventory",
                      //     style: beVietnamProExtraBold.copyWith(
                      //         fontSize: 24, color: AppColors.appTheme)),

                      InkWell(
                        key: btnKey3,
                        onTap: () {
                          showPopover(
                            context: btnKey3.currentContext!,
                            bodyBuilder: (context) => StatefulBuilder(
                              builder: (context, mSetState) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(10),
                                    horizontal: getProportionateScreenWidth(16),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Transform.scale(
                                        scale: 1.08,
                                        child: CheckboxListTile(
                                            activeColor: AppColors.appTheme,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Online",
                                              style: urbanistMedium.copyWith(
                                                  fontSize:
                                                      getProportionalFontSize(
                                                          13)),
                                            ),
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            value: controller.sortOnline.value,
                                            onChanged: (v) {
                                              controller.sortOnline.value = v!;
                                              mSetState(() {});
                                              controller.update();
                                            }),
                                      ),
                                      Transform.scale(
                                        scale: 1.08,
                                        child: CheckboxListTile(
                                            activeColor: AppColors.appTheme,
                                            contentPadding: EdgeInsets.zero,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            title: Text(
                                              "Offline",
                                              style: urbanistMedium.copyWith(
                                                  fontSize:
                                                      getProportionalFontSize(
                                                          13)),
                                            ),
                                            checkboxShape:
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            value: controller.sortOffline.value,
                                            onChanged: (v) {
                                              controller.sortOffline.value = v!;
                                              mSetState(() {});

                                              controller.update();
                                            }),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            onPop: () {
                              Future.delayed(Duration.zero).then((value) {
                                controller.getMyDrivers(false);
                              });
                            },
                            direction: PopoverDirection.bottom,
                            width: getProportionateScreenWidth(160),
                            arrowHeight: 15,
                            arrowWidth: 30,
                          );
                        },
                        child: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.appTheme,
                            child: SvgPicture.asset(AppIcons.filter)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // if(controller.selectedCategory.isNotEmpty) {
                      //   controller.deleteNotification();
                      // }
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
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.MY_ANALYTICS);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(16)),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: driversController.driverList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = driversController.driverList[index];
                          return driverItems(data);
                        },
                      ),
                    ),
                  )
                ])),
          );
        },
      ),
    );
  }

  Widget driverItems(Driver driver) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
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
                      value: controller.selectedCategory.contains(driver.id),
                      onChanged: (v) {
                        if (controller.selectedCategory.contains(driver.id)) {
                          controller.selectedCategory
                              .remove(driver.id); // unselect
                        } else {
                          controller.selectedCategory
                              .add(driver.id ?? 0); // select
                        }
                        controller.update();
                      },
                      activeColor: AppColors.white,
                      checkColor: AppColors.appTheme,
                    )),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver.name ?? '-',
                      style: urbanistBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 5),
                  Text("Phone : ${driver.phone}",
                      style: urbanistMedium.copyWith(fontSize: 14)),
                  Text("Orders: : 10",
                      style: urbanistMedium.copyWith(fontSize: 14)),
                  driver.active == 1
                      ? Chip(
                          backgroundColor: getColor(driver.active),
                          label: Text("Active",
                              style: urbanistSemiBold.copyWith(fontSize: 14)),
                        )
                      : Chip(
                          backgroundColor: getColor(driver.active),
                          label: Text("Inactive",
                              style: urbanistSemiBold.copyWith(fontSize: 14)),
                        ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Get.toNamed(Routes.ADD_NEW_DRIVER,
                          arguments: driver);

                      // if (result != null) {
                      //   controller.getMyDrivers();
                      // }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                              style: urbanistSemiBold.copyWith(fontSize: 14),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset("assets/images/edit_icon.svg")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Earnings",
                    style: urbanistSemiBold.copyWith(fontSize: 14),
                  ),
                  Text(
                    "£1.10",
                    style: urbanistSemiBold.copyWith(fontSize: 14),
                  ),
                ],
              )
            ],
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }

  getColor(status) {
    if (status == 1) {
      return "#EBF9DC".fromHex;
    } else {
      return "#E4E4E4".fromHex;
    }
  }
}
