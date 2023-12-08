import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/modules/food_management_module/food_management_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_default_icon_button.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:popover/popover.dart';

import '../../common/util/exports.dart';
import '../../data/models/get_food_list_response.dart';
import '../../utils/common_helper.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class FoodManagementPage extends GetView<FoodManagementController> {
  FoodManagementPage({required this.isHideAppBar});
  bool isHideAppBar;

  GlobalKey btnKey3 = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isHideAppBar
            ? null
            : CustomAppbarWidget(
                title: "My Products",
                centerTitle: true,
                textColor: AppColors.appTheme),
        bottomNavigationBar: GetBuilder<FoodManagementController>(
          builder: (controller) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: NumberPaginator(
                config: NumberPaginatorUIConfig(
                    buttonSelectedBackgroundColor: AppColors.appTheme,
                    buttonUnselectedBackgroundColor: Colors.transparent,
                    buttonSelectedForegroundColor: AppColors.white,
                    buttonUnselectedForegroundColor: AppColors.appTheme,
                    contentPadding: EdgeInsets.zero,
                    buttonShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    mode: ContentDisplayMode.numbers),
                numberPages: controller.foodList1.isNotEmpty
                    ? controller.foodList1.length
                    : 1,
                onPageChange: (int index) {
                  controller.currintIndex.value = index;
                  controller.update();
                },
              ),
            );
          },
        ),
        body: GetBuilder<FoodManagementController>(
          init: FoodManagementController(),
          builder: (FoodManagementController foodManagementController) {
            // if (foodManagementController.isLoading.value) {
            //   return const Center(
            //     child: CircularProgressIndicator.adaptive(),
            //   );
            // } else {
            //   return SingleChildScrollView(
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(
            //           vertical: Get.height * .02, horizontal: Get.width * .04),
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               DefaultIconButton(
            //                 onTap: () {
            //                   // Get.toNamed(Routes.ADD_PRODUCT);
            //                   Get.toNamed(Routes.EDIT_FOOD_MANAGEMENT);
            //                 },
            //                 width: Get.width * .45,
            //                 backgroundColor: "#217041".fromHex,
            //                 buttonText: 'New Product',
            //               ),
            //               const SizedBox(width: 12),
            //               Flexible(
            //                   child: CustomTextFieldWidget(
            //                 controller: controller.searchController,
            //                 prefixIconPadding:
            //                     const EdgeInsets.only(left: 15, right: 10),
            //                 prefixIcon: SvgPicture.asset(AppIcons.search),
            //                 obscureText: false,
            //                 onChanged: (value) {
            //                   controller.filterFoodList();
            //                 },
            //                 hintText: "Search",
            //                 border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.circular(11),
            //                     borderSide:
            //                         BorderSide(color: AppColors.appTheme)),
            //               ))
            //             ],
            //           ),
            //           const Divider(thickness: 1, height: 50),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Inventory",
            //                 style: beVietnamProExtraBold.copyWith(
            //                     fontSize: 24, color: AppColors.appTheme),
            //               ),
            //
            //               InkWell(
            //                 key: btnKey3,
            //                 onTap: () {
            //                   showPopover(
            //                     context: btnKey3.currentContext!,
            //                     bodyBuilder: (context) => StatefulBuilder(
            //                       builder: (context, mSetState) {
            //                         return Padding(
            //                           padding: EdgeInsets.symmetric(
            //                             vertical:
            //                                 getProportionateScreenHeight(10),
            //                             horizontal:
            //                                 getProportionateScreenWidth(16),
            //                           ),
            //                           child: Column(
            //                             mainAxisSize: MainAxisSize.min,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Transform.scale(
            //                                 scale: 1.08,
            //                                 child: CheckboxListTile(
            //                                     activeColor: AppColors.appTheme,
            //                                     contentPadding: EdgeInsets.zero,
            //                                     controlAffinity:
            //                                         ListTileControlAffinity
            //                                             .leading,
            //                                     title: Text(
            //                                       "Published Items",
            //                                       style: urbanistMedium.copyWith(
            //                                           fontSize:
            //                                               getProportionalFontSize(
            //                                                   13)),
            //                                     ),
            //                                     checkboxShape:
            //                                         RoundedRectangleBorder(
            //                                       borderRadius:
            //                                           BorderRadius.circular(3),
            //                                     ),
            //                                     value: controller
            //                                         .sortPublished.value,
            //                                     onChanged: (v) {
            //                                       controller
            //                                           .sortPublished.value = v!;
            //                                       mSetState(() {});
            //                                       controller.update();
            //                                     }),
            //                               ),
            //                               Transform.scale(
            //                                 scale: 1.08,
            //                                 child: CheckboxListTile(
            //                                     activeColor: AppColors.appTheme,
            //                                     contentPadding: EdgeInsets.zero,
            //                                     controlAffinity:
            //                                         ListTileControlAffinity
            //                                             .leading,
            //                                     title: Text(
            //                                       "Unpublished Items",
            //                                       style: urbanistMedium.copyWith(
            //                                           fontSize:
            //                                               getProportionalFontSize(
            //                                                   13)),
            //                                     ),
            //                                     checkboxShape:
            //                                         RoundedRectangleBorder(
            //                                       borderRadius:
            //                                           BorderRadius.circular(3),
            //                                     ),
            //                                     value: controller
            //                                         .sortUnPublished.value,
            //                                     onChanged: (v) {
            //                                       controller.sortUnPublished
            //                                           .value = v!;
            //                                       mSetState(() {});
            //
            //                                       controller.update();
            //                                     }),
            //                               ),
            //                             ],
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     onPop: () {
            //                       controller.filterFoodList();
            //                     },
            //                     direction: PopoverDirection.bottom,
            //                     width: getProportionateScreenWidth(160),
            //                     arrowHeight: 15,
            //                     arrowWidth: 30,
            //                   );
            //                 },
            //                 child: CircleAvatar(
            //                     radius: 25,
            //                     backgroundColor: AppColors.appTheme,
            //                     child: SvgPicture.asset(AppIcons.filter)),
            //                 // child: Container(
            //                 //   padding: EdgeInsets.symmetric(
            //                 //     horizontal: getProportionateScreenWidth(16),
            //                 //     vertical: getProportionateScreenHeight(8),
            //                 //   ),
            //                 //   decoration: BoxDecoration(
            //                 //     color: AppColors.grey,
            //                 //     borderRadius: BorderRadius.circular(8),
            //                 //   ),
            //                 //   child: Row(
            //                 //     mainAxisAlignment:
            //                 //         MainAxisAlignment.spaceBetween,
            //                 //     children: [
            //                 //       Text("Filter"),
            //                 //       Icon(Icons.arrow_drop_down)
            //                 //     ],
            //                 //   ),
            //                 // ),
            //               )
            //               // CircleAvatar(
            //               //     radius: 25,
            //               //     backgroundColor: AppColors.appTheme,
            //               //     child: SvgPicture.asset(AppIcons.filter))
            //             ],
            //           ),
            //           SizedBox(height: Get.height * .01),
            //           GestureDetector(
            //             onTap: () {
            //               controller.deleteFood();
            //             },
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Text("Remove",
            //                     style: urbanistSemiBold.copyWith(
            //                         color: AppColors.doveGray, fontSize: 14)),
            //                 const SizedBox(width: 8),
            //                 SvgPicture.asset("assets/images/delete.svg",
            //                     colorFilter: const ColorFilter.mode(
            //                         AppColors.doveGray, BlendMode.srcIn))
            //               ],
            //             ),
            //           ),
            //           Container(
            //             margin: const EdgeInsets.symmetric(vertical: 15),
            //             decoration: BoxDecoration(color: AppColors.grey),
            //             child: foodManagementController.foodList1.isNotEmpty
            //                 ? productItems(
            //                     foodManagementController
            //                         .foodList1[controller.currintIndex.value],
            //                   )
            //                 : SizedBox(),
            //           )
            //         ],
            //       ),
            //     ),
            //   );
            // }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * .02, horizontal: Get.width * .04),
                child: Column(
                  children: [
                    Row(
                      children: [
                        DefaultIconButton(
                          onTap: () async {
                            // Get.toNamed(Routes.ADD_PRODUCT);
                            var result =
                                await Get.toNamed(Routes.EDIT_FOOD_MANAGEMENT);
                            if (result == true) {
                              controller.getFoodList();
                            }
                          },
                          width: Get.width * .45,
                          backgroundColor: "#217041".fromHex,
                          buttonText: 'New Product',
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                            child: CustomTextFieldWidget(
                          controller: controller.searchController,
                          prefixIconPadding:
                              const EdgeInsets.only(left: 15, right: 10),
                          prefixIcon: SvgPicture.asset(AppIcons.search),
                          obscureText: false,
                          onChanged: (value) {
                            controller.filterFoodList();
                          },
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide:
                                  BorderSide(color: AppColors.appTheme)),
                        ))
                      ],
                    ),
                    const Divider(thickness: 1, height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Inventory",
                          style: beVietnamProExtraBold.copyWith(
                              fontSize: 24, color: AppColors.appTheme),
                        ),

                        InkWell(
                          key: btnKey3,
                          onTap: () {
                            showPopover(
                              context: btnKey3.currentContext!,
                              bodyBuilder: (context) => StatefulBuilder(
                                builder: (context, mSetState) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          getProportionateScreenHeight(10),
                                      horizontal:
                                          getProportionateScreenWidth(16),
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
                                                  ListTileControlAffinity
                                                      .leading,
                                              title: Text(
                                                "Published Items",
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
                                              value: controller
                                                  .sortPublished.value,
                                              onChanged: (v) {
                                                controller.sortPublished.value =
                                                    v!;
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
                                                  ListTileControlAffinity
                                                      .leading,
                                              title: Text(
                                                "Unpublished Items",
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
                                              value: controller
                                                  .sortUnPublished.value,
                                              onChanged: (v) {
                                                controller
                                                    .sortUnPublished.value = v!;
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
                                controller.filterFoodList();
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
                          // child: Container(
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: getProportionateScreenWidth(16),
                          //     vertical: getProportionateScreenHeight(8),
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: AppColors.grey,
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text("Filter"),
                          //       Icon(Icons.arrow_drop_down)
                          //     ],
                          //   ),
                          // ),
                        )
                        // CircleAvatar(
                        //     radius: 25,
                        //     backgroundColor: AppColors.appTheme,
                        //     child: SvgPicture.asset(AppIcons.filter))
                      ],
                    ),
                    SizedBox(height: Get.height * .01),
                    GestureDetector(
                      onTap: () {
                        controller.deleteFood();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Remove",
                              style: urbanistSemiBold.copyWith(
                                  color: AppColors.doveGray, fontSize: 14)),
                          const SizedBox(width: 8),
                          SvgPicture.asset("assets/images/delete.svg",
                              colorFilter: const ColorFilter.mode(
                                  AppColors.doveGray, BlendMode.srcIn))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: AppColors.grey),
                      child: foodManagementController.foodList1.isNotEmpty
                          ? productItems(
                              foodManagementController
                                  .foodList1[controller.currintIndex.value],
                            )
                          : SizedBox(),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget productItems(List<Food> foodList) {
    return ListView.builder(
      itemCount: foodList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        var food = foodList[index];
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * .01, horizontal: Get.width * .03),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Obx(() => Checkbox(
                          value: controller.selectedFood.contains(food.id),
                          onChanged: (v) {
                            if (controller.selectedFood.contains(food.id)) {
                              controller.selectedFood
                                  .remove(food.id); // unselect
                            } else {
                              controller.selectedFood.add(food.id); // select
                            }
                            controller.update();
                          },
                          activeColor: AppColors.white,
                          checkColor: AppColors.appTheme,
                        )),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      food.fileName != null
                          ? CachedNetworkImage(
                              // imageUrl: Constants.imgUrl + restaurant.images,
                              imageUrl: getImageUrl(food.fileName),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: getProportionateScreenHeight(80),
                                width: getProportionateScreenWidth(70),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset("assets/images/milk_logo.png"),
                      const SizedBox(height: 8),
                      Text(
                        "ID ${food.id}",
                        style: urbanistExtraBold.copyWith(
                            fontSize: 14, color: AppColors.doveGray),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 120,
                                child: Text(
                                  food.name,
                                  style: urbanistMedium.copyWith(fontSize: 14),
                                )),
                            InkWell(
                              onTap: () async {
                                var result = await Get.toNamed(
                                    Routes.EDIT_FOOD_MANAGEMENT,
                                    arguments: food);
                                if (result == true) {
                                  controller.getFoodList();
                                }
                                // controller.getFoodList();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color:
                                            AppColors.doveGray.withOpacity(.2)),
                                    color: AppColors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Edit",
                                        style: urbanistSemiBold.copyWith(
                                            fontSize: 14),
                                      ),
                                      const SizedBox(width: 5),
                                      SvgPicture.asset(
                                          "assets/images/edit_icon.svg")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 23,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controller.getProductColor(food),
                              ),
                              child: Center(
                                  child: Text(
                                      "${controller.getProductStatus(food)}",
                                      style: urbanistSemiBold.copyWith(
                                          fontSize: 14))),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Discount:",
                                  style: urbanistMedium.copyWith(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text("Price:",
                                    style:
                                        urbanistMedium.copyWith(fontSize: 14)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(" £${food.discountprice}",
                                    style:
                                        urbanistMedium.copyWith(fontSize: 16)),
                                const SizedBox(height: 5),
                                Text(" £${food.price}",
                                    style:
                                        urbanistMedium.copyWith(fontSize: 16)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 1,
              )
            ],
          ),
        );
      },
    );
  }
}
