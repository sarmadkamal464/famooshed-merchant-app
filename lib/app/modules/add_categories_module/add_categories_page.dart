import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/modules/add_categories_module/add_categories_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../libraries/dotted_container/dotted_border.dart';
import '../../common/constants.dart';
import '../../common/util/exports.dart';
import '../../data/models/get_product_category_model.dart';
import '../../theme/size_config.dart';

class AddCategoriesPage extends GetView<AddCategoriesController> {
  const AddCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: controller.data != null
                ? (controller.data!.isReadOnly != null &&
                        controller.data!.isReadOnly == true)
                    ? "Category Info"
                    : "Edit New Subcategory"
                : "Add New Subcategory",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder<AddCategoriesController>(
          builder: (controller) {
            return Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(
                    vertical: Get.height * .02, horizontal: Get.width * .05),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: AbsorbPointer(
                      absorbing: controller.data != null &&
                          (controller.data!.isReadOnly != null &&
                              controller.data!.isReadOnly == true),
                      child: Column(
                        children: [
                          textStyle("Subcategory Name"),
                          textField("Insert Name", controller.productName),
                          textStyle(Strings.parentCategory),
                          SizedBox(
                            width: getProportionateScreenWidth(220),
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child:
                                  DropdownButtonFormField<ProductCategoryModel>(
                                isExpanded: false,
                                isDense: true,
                                alignment: Alignment.bottomLeft,
                                icon: Icon(Icons.keyboard_arrow_down),
                                borderRadius: BorderRadius.circular(8),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                    top: getProportionateScreenHeight(4),
                                    bottom: getProportionateScreenHeight(4),
                                    left: getProportionateScreenWidth(0),
                                    right: getProportionateScreenWidth(6),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select parent category';
                                  }
                                  return null;
                                },
                                items: controller.productCategoryList
                                    .map(
                                      (item) => DropdownMenuItem<
                                          ProductCategoryModel>(
                                        value: item,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                item.name.toString(),
                                                textAlign: TextAlign.center,
                                                style: urbanistRegular.copyWith(
                                                    fontSize: 14,
                                                    color: AppColors.doveGray),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (T) {
                                  controller.selectedParentProductCat =
                                      T as ProductCategoryModel;
                                  controller.update();
                                },
                                value: controller.selectedParentProductCat,
                                hint: const Text("Select Parent Category"),
                                selectedItemBuilder: (context) {
                                  return controller.productCategoryList
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(
                                                  item.name.toString(),
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      urbanistRegular.copyWith(
                                                          fontSize: 14,
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList();
                                },
                                style: urbanistRegular.copyWith(
                                    fontSize: 14, color: AppColors.black),
                              ),
                            ),
                          ),
                          textStyle("Description"),
                          textField(
                            "Enter comments",
                            controller.description,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(16),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(220),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              checkColor: AppColors.white,
                              activeColor: AppColors.appTheme,
                              title: Text("Published Item",
                                  style: beVietnamProSemiBold.copyWith(
                                      fontSize: getProportionalFontSize(14))),
                              value: controller.publishedItem.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.publishedItem.value = value;
                                  controller.update();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(220),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              checkColor: AppColors.white,
                              activeColor: AppColors.appTheme,
                              dense: true,
                              title: Text("Featured Category",
                                  style: beVietnamProSemiBold.copyWith(
                                      fontSize: getProportionalFontSize(14))),
                              value: controller.featuredCategory.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.featuredCategory.value = value;
                                  controller.update();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(22),
                          ),
                          DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(20),
                              color: AppColors.doveGray,
                              child: controller.editImageUrl.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () async {
                                        File? selectedFile =
                                            await Utils.getImage(source: 0);
                                        if (selectedFile != null) {
                                          // controller.addNewFile = File(selectedFile.path);
                                          controller.uploadProductImage(
                                              selectedFile.path);
                                        }
                                      },
                                      child: Container(
                                        height: SizeConfig.deviceHeight! * .25,
                                        width: getProportionateScreenWidth(220),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 28, horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.contain,
                                              image: CachedNetworkImageProvider(
                                                Constants.imgUrl +
                                                    controller.editImageUrl,
                                              ),
                                            ),
                                            color: AppColors.grey),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        File? selectedFile =
                                            await Utils.getImage(source: 0);
                                        if (selectedFile != null) {
                                          // controller.addNewFile = File(selectedFile.path);
                                          controller.uploadProductImage(
                                              selectedFile.path);
                                        }
                                      },
                                      child: Container(
                                        width: getProportionateScreenWidth(220),
                                        height: SizeConfig.deviceHeight! * .25,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 28, horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.grey),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/imageplace.svg",
                                                height: 48),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/upload.svg",
                                                    height: 22),
                                                const SizedBox(width: 8),
                                                Text(
                                                  "Drop File Here\nor click to upload",
                                                  style: beVietnamProExtraBold
                                                      .copyWith(
                                                          color: AppColors
                                                              .appTheme,
                                                          fontSize: 13),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          SizedBox(height: Get.height * .04),
                          Obx(() => DefaultButton(
                                onTap: () {
                                  controller.addCategory();
                                },
                                width: Get.width * .6,
                                buttonText: !controller.isEdit.value
                                    ? 'Add New Category'
                                    : "Save",
                              )),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }

  Widget textField(hintText, textController) {
    return SizedBox(
      width: getProportionateScreenWidth(220),
      child: CustomTextFieldWidget(
        // textAlignVertical: TextAlignVertical.center,

        controller: textController,
        textAlign: TextAlign.center,
        fillColor: AppColors.white,

        obscureText: false,
        hintText: hintText,
        hintStyle:
            urbanistRegular.copyWith(fontSize: 14, color: AppColors.doveGray),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white)),
      ),
    );
  }

  textStyle(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: urbanistRegular.copyWith(fontSize: 16)),
    );
  }
}
