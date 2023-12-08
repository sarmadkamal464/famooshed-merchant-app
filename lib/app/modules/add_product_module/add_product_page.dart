import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:famooshed_vendor/app/common/constants.dart';
import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/utils/dprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:famooshed_vendor/app/modules/add_product_module/add_product_controller.dart';
import '../../common/util/exports.dart';

class AddProductPage extends GetView<AddProductController> {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "Add / Edit Product",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder(builder: (AddProductController addProductController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controller.productImageUrl.isEmpty
                          ? clickToUpload(40, 40, 10, 76, () {
                              Utils.showImagePicker(onGetImage: (image) {
                                controller.productImage = image.path;
                                controller.uploadImage();
                                controller.update();
                                dprint(image.path);
                              });
                            })
                          : clickToUpload1(40, 40, 10, 76, () {
                              Utils.showImagePicker(onGetImage: (image) {
                                controller.productImage = image.path;
                                controller.uploadProductImage();
                                controller.update();
                                dprint(image.path);
                              });
                            }),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text("Additional Images",
                                  style: beVietnamProExtraBold.copyWith(
                                      fontSize: 15,
                                      color: AppColors.appTheme))),
                          const SizedBox(height: 15),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            color: AppColors.doveGray,
                            child: clickToUpload(28, 10, 20, 40, () {
                              if (controller.aditionalImages.length >= 3) {
                                Utils.showSnackbar("Max 3 images is allowed");
                              } else {
                                controller.getAdditionalImage();
                              }
                            }),
                          ),
                        ],
                      )
                    ],
                  ),

                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: controller.aditionalImages
                              .map(
                                (e) => clickToUpload2(40, 40, 10, 76, () {
                                  Utils.showImagePicker(onGetImage: (image) {
                                    controller.productImage = image.path;
                                    controller.uploadProductImage();
                                    dprint(image.path);
                                  });
                                }, e),
                              )
                              .toList()),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Text("Product Infomation",
                      style: beVietnamProExtraBold.copyWith(
                          color: AppColors.appTheme, fontSize: 22)),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: AppColors.lightGreen),
                      child: productInformation()),
                  // productVariants(),
                  // recommendedProducts(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DefaultButton(
                        onTap: () {
                          controller.foodSave();
                        },
                        width: Get.width * .45,
                        buttonText: 'Save',
                      ),
                      DefaultButton(
                        onTap: () {
                          controller.published = true;
                          controller.foodSave();
                        },
                        width: Get.width * .45,
                        buttonText: 'Save & Publish',
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget clickToUpload(
      double height, double width, double radius, double imageSize, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height, horizontal: width),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: AppColors.grey),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/upload.svg", height: imageSize),
            const SizedBox(height: 10),
            SizedBox(
              width: 120,
              child: Text(
                "Click To Upload",
                style: beVietnamProExtraBold.copyWith(
                    color: AppColors.appTheme, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clickToUpload1(
      double height, double width, double radius, double imageSize, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 200,
          width: 200,
          // padding: EdgeInsets.symmetric(vertical: height, horizontal: width),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image:
                      CachedNetworkImageProvider(controller.productImageUrl)),
              borderRadius: BorderRadius.circular(radius),
              color: AppColors.grey),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppIcons.uploadSmallSvg),
                const SizedBox(width: 10),
                SvgPicture.asset(AppIcons.deleteSvg)
              ],
            ),
          )),
    );
  }

  Widget clickToUpload2(double height, double width, double radius,
      double imageSize, onTap, imgUrl) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: 120,
        // padding: EdgeInsets.symmetric(vertical: height, horizontal: width),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(Constants.imgUrl + imgUrl)),
            borderRadius: BorderRadius.circular(radius),
            color: AppColors.grey),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [SvgPicture.asset(AppIcons.deleteSvg)],
          ),
        ),
      ),
    );
  }

  Widget productInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(Strings.productName),
          textField("Insert Name", controller.editControllerName),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.price),
                    textField("£30", controller.editControllerPrice)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.discountPrice),
                    textField("£30", controller.editControllerDiscountPrice)
                  ],
                ),
              ),
            ],
          ),
          text(Strings.category),
          textField("Select Product Category", controller.editControllerName),
          text(Strings.ingredients),
          customTextArea(
              "Insert ingredients", controller.editControllerIngredients),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.unit),
                    textField(
                        "(ex: L, ml, Kg, g)", controller.editControllerUnit)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.weight),
                    textField("Insert Weight", controller.editControllerWeight)
                  ],
                ),
              ),
            ],
          ),
          text(Strings.package),
          textField("Item per package (ex: 1, 6, 10)",
              controller.editControllerPackageCount),
          text(Strings.description),
          customTextArea("Insert Descrption", controller.editControllerDesc),
        ],
      ),
    );
  }

  Widget productVariants() {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text('Product Variants'),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(Strings.remove),
                  SvgPicture.asset("assets/images/delete.svg")
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: productVariantsItems(),
              ),
              Text("Add New",
                  style: beVietnamProExtraBold.copyWith(
                      fontSize: 18, color: AppColors.appTheme)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(Strings.productName),
                        textField("Insert Name",
                            controller.editControllerVariantsName),
                        Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(Strings.price),
                                  textField("£30",
                                      controller.editControllerVariantsPrice)
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  text(Strings.discountPrice),
                                  textField(
                                      "£30",
                                      controller
                                          .editControllerVariantsDiscountPrice)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(20),
                color: AppColors.doveGray,
                child: clickToUpload(28, 20, 20, 40, () {}),
              ),
              Center(
                child: DefaultButton(
                  width: Get.width * .5,
                  buttonText: 'Add Variant',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget recommendedProducts() {
    return Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            title: const Text('Recommended Products'),
            children: <Widget>[
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(Strings.remove),
                      SvgPicture.asset("assets/images/delete.svg")
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(15)),
                    child: recommendedProductsItems(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Add Recommended Product:",
                              style: beVietnamProExtraBold.copyWith(
                                  fontSize: 18, color: AppColors.appTheme)),
                          const SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: AppColors.doveGray.withOpacity(.2))),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              borderRadius: BorderRadius.circular(10),
                              hint: Text('Search Product',
                                  style: urbanistMedium.copyWith(fontSize: 14)),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(color: AppColors.appTheme),
                              items: ['One', 'Two', 'Three'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                controller.dropDownValue = val.toString();
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: DefaultButton(
                              width: Get.width * .3,
                              buttonText: 'Add',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }

  Widget recommendedProductsItems() {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
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
                    child: Checkbox(
                      value: false,
                      onChanged: (v) {},
                      activeColor: AppColors.white,
                      checkColor: AppColors.appTheme,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Image.asset("assets/images/milk_logo.png"),
                      const SizedBox(height: 8),
                      Text(
                        "ID 156",
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
                                  "Cravendale Yeo Valley fresh whole milk 1 litre",
                                  style: urbanistMedium.copyWith(fontSize: 14),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Price:",
                                      style: urbanistMedium.copyWith(
                                          fontSize: 14)),
                                  const SizedBox(width: 5),
                                  Text(" £1.10",
                                      style: urbanistMedium.copyWith(
                                          fontSize: 16)),
                                ],
                              ),
                            ),
                          ],
                        ),
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

  Widget textField(hintText, textController) {
    return CustomTextFieldWidget(
      // maxLength: 6,
      controller: textController,
      fillColor: AppColors.white,
      obscureText: false,
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
      maxLines: 3,
      controller: textController,
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

  text(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: urbanistRegular.copyWith(fontSize: 16)),
    );
  }

  Widget productVariantsItems() {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
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
                    child: Checkbox(
                      value: false,
                      onChanged: (v) {},
                      activeColor: AppColors.white,
                      checkColor: AppColors.appTheme,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Image.asset("assets/images/milk_logo.png"),
                      const SizedBox(height: 8),
                      Text(
                        "ID 156",
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
                                  "Cravendale Yeo Valley fresh whole milk 1 litre",
                                  style: urbanistMedium.copyWith(fontSize: 14),
                                )),
                            Container(
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
                                  color: AppColors.lightYellow),
                              child: Center(
                                  child: Text("Received",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(" £1.10",
                                    style:
                                        urbanistMedium.copyWith(fontSize: 16)),
                                const SizedBox(height: 5),
                                Text(" £1.12",
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
