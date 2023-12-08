import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/data/models/get_owner_coupon_response.dart';
import 'package:famooshed_vendor/app/modules/my_promotions_module/my_promotions_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_default_icon_button.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';

class MyPromotionsPage extends GetView<MyPromotionsController> {
  const MyPromotionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "My Promotions",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                Row(
                  children: [
                    DefaultIconButton(
                      onTap: () {
                        Get.toNamed(Routes.ADD_NEW_COUPONS);
                      },
                      width: Get.width * .45,
                      backgroundColor: AppColors.buttonColor,
                      buttonText: 'New Coupon',
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
                        controller.getOwnerCouponFilter();
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
                InkWell(
                  onTap: () {
                    if (controller.selectedCategory.isNotEmpty) {
                      controller.deleteNotification();
                    }
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
                    // Get.toNamed(Routes.MY_NEW_PROMOTIONS);
                  },
                  child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.couponList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = controller.couponList[index];
                            return driverItems(data);
                          },
                        ),
                      )),
                )
              ])),
        ));
  }

  Widget driverItems(CouponInfo coupon) {
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
                      value: controller.selectedCategory.contains(coupon.id),
                      onChanged: (v) {
                        if (controller.selectedCategory.contains(coupon.id)) {
                          controller.selectedCategory
                              .remove(coupon.id); // unselect
                        } else {
                          controller.selectedCategory.add(coupon.id); // select
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
                  Text(coupon.name, style: urbanistBold.copyWith(fontSize: 16)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Discount: ",
                          style: urbanistMedium.copyWith(fontSize: 14)),
                      Text(
                          "${double.parse(coupon.discount).toInt()}${coupon.inpercents == 1 ? " %" : ""}",
                          style: urbanistExtraBold.copyWith(
                              fontSize: 16, color: AppColors.appTheme))
                    ],
                  ),
                  Text("ID ${coupon.id}",
                      style: urbanistExtraBold.copyWith(
                          fontSize: 16, color: AppColors.doveGray)),
                  Chip(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: getStatusColor(coupon.published),
                    label: Text(
                        "${coupon.published == 1 ? "Active" : "Inactive"}",
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
                      var result = await Get.toNamed(Routes.ADD_NEW_COUPONS,
                          arguments: coupon);
                      if (result != null) {
                        controller.getOwnerCoupon();
                      }
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
                              style: urbanistSemiBold.copyWith(fontSize: 14),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset("assets/images/edit_icon.svg")
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Min. Amount",
                        style: urbanistSemiBold.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "£${coupon.minamount}",
                        style: urbanistSemiBold.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * .01),
                  Row(
                    children: [
                      Text(
                        "Date Start:  ",
                        style: urbanistSemiBold.copyWith(fontSize: 14),
                      ),
                      Text(
                        coupon.dateStart
                            .formatedDate(dateFormat: "dd-MM-yyyy")
                            .toString(),
                        style: urbanistSemiBold.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "End Date:  ",
                        style: urbanistSemiBold.copyWith(fontSize: 14),
                      ),
                      Text(
                        coupon.dateStart
                            .formatedDate(dateFormat: "dd-MM-yyyy")
                            .toString(),
                        style: urbanistSemiBold.copyWith(fontSize: 14),
                      ),
                    ],
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

  getStatusColor(statusCode) {
    if (statusCode == 1) {
      return "#EBF9DC".fromHex;
    } else if (statusCode == 0) {
      return "#E4E4E4".fromHex;
    } else {
      return "#F9DBDB".fromHex;
    }
  }
}
