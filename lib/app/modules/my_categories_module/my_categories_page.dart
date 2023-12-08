import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/data/models/category_list_response.dart';
import 'package:famooshed_vendor/app/modules/my_categories_module/my_categories_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_default_icon_button.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';

class MyCategoriesPage extends GetView<MyCategoriesController> {
  MyCategoriesPage({required this.isHideAppBar});
  bool isHideAppBar;
  GlobalKey btnKey3 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isHideAppBar
          ? null
          : CustomAppbarWidget(
              title: "My Categories",
              centerTitle: true,
              textColor: AppColors.appTheme),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  DefaultIconButton(
                    onTap: () {
                      Get.toNamed(Routes.ADD_CATEGORIES);
                    },
                    width: Get.width * .45,
                    backgroundColor: AppColors.buttonColor,
                    buttonText: 'Add new',
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                      child: CustomTextFieldWidget(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.searchController.text = value ?? '';
                      controller.update();
                      controller.getFoodList(showLoader: false);
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
                                vertical: getProportionateScreenHeight(10),
                                horizontal: getProportionateScreenWidth(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.scale(
                                    scale: 1.08,
                                    child: CheckboxListTile(
                                        activeColor: AppColors.appTheme,
                                        contentPadding: EdgeInsets.zero,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text(
                                          "Published Items",
                                          style: urbanistMedium.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(13)),
                                        ),
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        value: controller.sortPublished.value,
                                        onChanged: (v) {
                                          controller.sortPublished.value = v!;
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
                                          "Unpublished Items",
                                          style: urbanistMedium.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(13)),
                                        ),
                                        checkboxShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        value: controller.sortUnPublished.value,
                                        onChanged: (v) {
                                          controller.sortUnPublished.value = v!;
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
                          Get.back();
                          controller.getFoodList();
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
                  controller.deleteCategory();
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
              const SizedBox(height: 10),
              Obx(() => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.categoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = controller.categoryList[index];
                      return categoryItems(data);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryItems(Category category) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.grey, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Obx(() => Checkbox(
                          value:
                              controller.selectedCategory.contains(category.id),
                          onChanged: (v) {
                            if (controller.selectedCategory
                                .contains(category.id)) {
                              controller.selectedCategory
                                  .remove(category.id); // unselect
                            } else {
                              controller.selectedCategory
                                  .add(category.id); // select
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
                      Text(category.name,
                          style: urbanistBold.copyWith(fontSize: 16)),
                      const SizedBox(height: 5),
                      Text("Parent : ${category.parentName ?? "-"}",
                          style: urbanistMedium.copyWith(fontSize: 14)),
                      Text("items : ${category.itemsCount}",
                          style: urbanistMedium.copyWith(fontSize: 14)),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          category.isReadOnly = true;
                          controller.update();
                          Get.toNamed(Routes.ADD_CATEGORIES,
                              arguments: category);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.doveGray.withOpacity(.2)),
                              color: AppColors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Text(
                              "View Items",
                              style: urbanistSemiBold.copyWith(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.goToEdit(category);
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
                                  style:
                                      urbanistSemiBold.copyWith(fontSize: 14),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset("assets/images/edit_icon.svg")
                              ],
                            ),
                          ),
                        ),
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
        ));
  }
}
