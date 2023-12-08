import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/common/util/validators.dart';
import 'package:famooshed_vendor/app/data/models/get_food_detail_response.dart';
import 'package:famooshed_vendor/app/data/models/get_product_category_model.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/libraries/dotted_container/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

import '../../../libraries/custom_dropdown/dropdown_textfield.dart';
import '../../common/constants.dart';
import '../../common/util/exports.dart';
import '../../common/values/app_icons.dart';
import '../../data/models/get_food_list_response.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../../utils/common_helper.dart';
import '../../utils/dprint.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_text_field.dart';
import 'add_edit_food_management_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddEditFoodPage extends GetView<AddEditFoodManagementController> {
  AddEditFoodPage({Key? key}) : super(key: key);

  GlobalKey<FormState> pKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "Add / Edit Product",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder<AddEditFoodManagementController>(
          initState: (state) {},
          init: AddEditFoodManagementController(),
          builder: (AddEditFoodManagementController
              addEditFoodManagementController) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateScreenHeight(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    uploadImageRow(addEditFoodManagementController),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    // addEditFoodManagementController.selectedFiles.isNotEmpty
                    //     ? selectedFileView(addEditFoodManagementController)
                    //     : SizedBox(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: controller.aditionalImages
                              .map(
                                (e) => clickToUpload2(40, 40, 10, 76, () {
                                  // if (controller.aditionalImages.length >= 3) {
                                  //   Utils.showSnackbar(
                                  //       "Maximum 3 images allowed");
                                  // } else {
                                  Utils.showImagePicker(
                                      onGetImage: (imageFile) {
                                    // Get.back();

                                    img.Image? image = img.decodeImage(
                                        File(imageFile.path).readAsBytesSync());

                                    // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
                                    if (image != null) {
                                      img.Image? thumbnail;
                                      if (image.height > image.width) {
                                        thumbnail = img.copyResize(image,
                                            height: 600,
                                            interpolation:
                                                img.Interpolation.average);
                                      } else {
                                        thumbnail = img.copyResize(image,
                                            width: 600,
                                            interpolation:
                                                img.Interpolation.average);
                                      }

                                      // Save the thumbnail as a PNG.
                                      if (thumbnail.data != null) {
                                        File(imageFile.path).writeAsBytesSync(
                                          img.encodePng(thumbnail),
                                        );
                                      }
                                    }
                                    controller.productImage = imageFile.path;
                                    controller.uploadSingleImage(imageFile.path,
                                        controller.aditionalImages.indexOf(e));
                                    dprint(imageFile.path);
                                  });
                                  // }
                                }, e, controller.aditionalImages.indexOf(e)),
                              )
                              .toList()),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    productInfo(addEditFoodManagementController),
                    ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        "Product Variants",
                        style: beVietnamProExtraBold.copyWith(
                            fontSize: getProportionalFontSize(22),
                            color: AppColors.appTheme),
                      ),
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (addEditFoodManagementController
                                .selectedVariant.isNotEmpty) {
                              addEditFoodManagementController
                                  .deleteProductVariant();
                            }
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
                          child: variantItems(
                              addEditFoodManagementController.variantFoodList),
                        ),
                        addNewVariant(addEditFoodManagementController),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(12),
                    ),
                    ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      tilePadding: EdgeInsets.zero,
                      title: Text(
                        "Recommended Products",
                        style: beVietnamProExtraBold.copyWith(
                            fontSize: getProportionalFontSize(22),
                            color: AppColors.appTheme),
                      ),
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (addEditFoodManagementController
                                .selectedSimilar.isNotEmpty) {
                              controller.deleteSimilarProduct();
                            }
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
                          child: similarItems(
                              addEditFoodManagementController.similarFoodList),
                        ),
                        Container(
                          width: SizeConfig.deviceWidth!,
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(16),
                            vertical: getProportionateScreenHeight(10),
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(10),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFFEBF9DC),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Add Recommended Product:",
                                  textAlign: TextAlign.center,
                                  style: beVietnamProExtraBold.copyWith(
                                      fontSize: getProportionalFontSize(19),
                                      color: AppColors.appTheme)),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              DropDownTextField.multiSelection(
                                clearOption: false,
                                textFieldDecoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      fontSize: getProportionalFontSize(12),
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: getProportionateScreenHeight(16),
                                        bottom:
                                            getProportionateScreenHeight(16),
                                        left: getProportionateScreenWidth(16)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none),
                                    hintText: "Search Product"),
                                displayCompleteItem: true,
                                submitButtonColor: AppColors.appTheme,
                                submitButtonTextStyle:
                                    TextStyle(color: Colors.white),
                                listPadding: ListPadding(
                                    top: getProportionateScreenHeight(7),
                                    bottom: getProportionateScreenHeight(7)),
                                submitButtonText: "Okay",

                                dropDownList: controller.foodList
                                    .map((e) => DropDownValueModel(
                                        value: e, name: e.name))
                                    .toList(),

                                onChanged: (value) {
                                  if (value != null) {
                                    controller.selectedFoodList.clear();
                                    List<DropDownValueModel> result = value;
                                    if (result.isNotEmpty) {
                                      result.forEach((element) {
                                        controller.selectedFoodList
                                            .add(element.value);
                                      });
                                    }
                                    controller.update();
                                  }
                                  print(controller.selectedFoodList);
                                },
                                checkBoxProperty: CheckBoxProperty(
                                  checkColor: AppColors.appTheme,
                                  fillColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return BorderSide(
                                            color: AppColors.appTheme,
                                            width: 1.3);
                                      }
                                      return const BorderSide(
                                          color: Colors.grey, width: 1.3);
                                    },
                                  ),
                                ),
                                textStyle: TextStyle(
                                  fontSize: getProportionalFontSize(13),
                                  letterSpacing: .3,
                                ),
                                listTextStyle: TextStyle(
                                    fontSize: getProportionalFontSize(13),
                                    letterSpacing: .3),
                                dropDownIconProperty: IconProperty(
                                    icon: Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 25),
                                dropdownColor: Colors.white,
                                // validator: (value) {
                                //   if (value == null) {
                                //     return 'Please select stall category';
                                //   }
                                //   return null;
                                // },
                              ),
                              // ButtonTheme(
                              //   alignedDropdown: true,
                              //   child: DropdownButtonFormField<String>(
                              //     isExpanded: false,
                              //     isDense: true,
                              //     alignment: Alignment.bottomLeft,
                              //     icon: Icon(Icons.keyboard_arrow_down),
                              //     borderRadius: BorderRadius.circular(8),
                              //     decoration: InputDecoration(
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       contentPadding: EdgeInsets.only(
                              //           top: getProportionateScreenHeight(4),
                              //           bottom: getProportionateScreenHeight(4),
                              //           left: getProportionateScreenWidth(0),
                              //           right: getProportionateScreenWidth(6)),
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
                              //     // validator: (value) {
                              //     //   if (value == null) {
                              //     //     return 'Please select category';
                              //     //   }
                              //     //   return null;
                              //     // },
                              //     items: controller.foodListString
                              //         .map(
                              //           (item) => DropdownMenuItem<String>(
                              //             value: item,
                              //             child: Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               mainAxisAlignment:
                              //                   MainAxisAlignment.center,
                              //               children: [
                              //                 Text(
                              //                   item.toString(),
                              //                   style: TextStyle(
                              //                       fontSize:
                              //                           getProportionalFontSize(
                              //                               12),
                              //                       overflow:
                              //                           TextOverflow.visible,
                              //                       color: Colors.black),
                              //                   textAlign: TextAlign.start,
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         )
                              //         .toList(),
                              //     onChanged: (T) {
                              //       controller.selectedFoodForRecommand =
                              //           T as String;
                              //       controller.update();
                              //     },
                              //     value: controller
                              //             .selectedFoodForRecommand.isNotEmpty
                              //         ? controller.selectedFoodForRecommand
                              //         : controller.foodListString[0],
                              //     hint: const Text("Search Product"),
                              //     style: TextStyle(
                              //         fontSize: getProportionalFontSize(12)),
                              //   ),
                              // ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              DefaultButton(
                                  onTap: () {
                                    String rp = '';
                                    rp = controller.selectedFoodList.first.id
                                        .toString();
                                    // rp = controller.selectedFoodList
                                    //     .map((e) => e.id)
                                    //     .toString();
                                    // rp = rp.replaceAll('(', '');
                                    // rp = rp.replaceAll(')', '');
                                    print(rp);
                                    // controller.foodList.forEach((element) {
                                    //   if (element.name ==
                                    //       controller.selectedFoodForRecommand) {
                                    //     rp = element.id.toString();
                                    //   }
                                    // });
                                    controller.addRecommandedProduct(rp);
                                  },
                                  width: getProportionateScreenWidth(110),
                                  buttonText: "Add")
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DefaultButton(
                              onTap: () {
                                if (pKey.currentState!.validate()) {
                                  Food? args = Get.arguments as Food?;
                                  if (args != null &&
                                      args.id.toString().isNotEmpty) {
                                    controller.foodSave(
                                        false, true, args.id.toString());
                                  } else {
                                    controller.foodSave(false, false, '0');
                                  }
                                }
                              },
                              buttonText: "Save"),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(8),
                        ),
                        Expanded(
                          child: DefaultButton(
                              backgroundColor: Color(0xFF053518),
                              onTap: () {
                                if (pKey.currentState!.validate()) {
                                  Food? args = Get.arguments as Food?;
                                  if (args != null &&
                                      args.id.toString().isNotEmpty) {
                                    controller.foodSave(
                                        true, true, args.id.toString());
                                  } else {
                                    controller.foodSave(true, false, '0');
                                  }
                                }
                              },
                              buttonText: "Save & Publish"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
  //
  // SizedBox selectedFileView(
  //     AddEditFoodManagementController foodManagementController) {
  //   return SizedBox(
  //     height: getProportionateScreenHeight(100),
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       scrollDirection: Axis.horizontal,
  //       itemCount: foodManagementController.selectedFiles.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           padding: EdgeInsets.only(
  //               top: getProportionateScreenHeight(8),
  //               right: getProportionateScreenWidth(8)),
  //           alignment: Alignment.topRight,
  //           margin: EdgeInsets.only(left: getProportionateScreenWidth(10)),
  //           width: getProportionateScreenWidth(100),
  //           decoration: BoxDecoration(
  //               color: Color(0xFFF4F4F4),
  //               borderRadius: BorderRadius.circular(10),
  //               image: DecorationImage(
  //                   image: FileImage(
  //                       foodManagementController.selectedFiles[index]),
  //                   fit: BoxFit.fill)),
  //           child: InkWell(
  //             onTap: () {
  //               foodManagementController.selectedFiles
  //                   .remove(foodManagementController.selectedFiles[index]);
  //               foodManagementController.update();
  //             },
  //             child: Container(
  //               padding: EdgeInsets.all(3),
  //               margin: EdgeInsets.only(
  //                   left: getProportionateScreenWidth(5),
  //                   right: getProportionateScreenWidth(5)),
  //               decoration: BoxDecoration(
  //                   color: Color(0xFFEBF9DC),
  //                   borderRadius: BorderRadius.circular(3)),
  //               child: SvgPicture.asset(
  //                 AppImages.delete,
  //                 width: getProportionateScreenWidth(15),
  //                 height: getProportionateScreenHeight(15),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Row uploadImageRow(AddEditFoodManagementController foodManagementController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          onTap: () async {
            File? selectedFile = await Utils.getImage(source: 0);
            if (selectedFile != null && selectedFile.path.isNotEmpty) {
              img.Image? image =
                  img.decodeImage(File(selectedFile.path).readAsBytesSync());

              // Resize the image to a 120x? thumbnail (maintaining the aspect ratio).
              if (image != null) {
                img.Image? thumbnail;
                if (image.height > image.width) {
                  thumbnail = img.copyResize(image,
                      height: 500, interpolation: img.Interpolation.average);
                } else {
                  thumbnail = img.copyResize(image,
                      width: 500, interpolation: img.Interpolation.average);
                }

                // Save the thumbnail as a PNG.
                if (thumbnail.data != null) {
                  File(selectedFile.path).writeAsBytesSync(
                    img.encodePng(thumbnail),
                  );
                }
              }
              foodManagementController.uploadProductImage(selectedFile.path);
              // foodManagementController.mainFile = selectedFile;
              // foodManagementController.update();
            }
          },
          child: foodManagementController.getFoodDetailResponse.image != null &&
                  foodManagementController
                      .getFoodDetailResponse.image!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: getImageUrl(
                      foodManagementController.getFoodDetailResponse.image),
                  imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.topRight,
                      height: getProportionateScreenHeight(170),
                      width: getProportionateScreenWidth(175),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            margin: EdgeInsets.only(
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
                          InkWell(
                            onTap: () {
                              foodManagementController
                                  .getFoodDetailResponse.image = null;
                              foodManagementController.update();
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              margin: EdgeInsets.only(
                                  left: getProportionateScreenWidth(5),
                                  right: getProportionateScreenWidth(5)),
                              decoration: BoxDecoration(
                                  color: Color(0xFFEBF9DC),
                                  borderRadius: BorderRadius.circular(3)),
                              child: SvgPicture.asset(
                                AppImages.delete,
                                width: getProportionateScreenWidth(15),
                                height: getProportionateScreenHeight(15),
                              ),
                            ),
                          ),
                        ],
                      )),
                  placeholder: (context, url) =>
                      Center(child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              // : foodManagementController.mainFile != null
              //     ? Container(
              //         padding: EdgeInsets.only(
              //             top: getProportionateScreenHeight(8),
              //             right: getProportionateScreenWidth(8)),
              //         alignment: Alignment.topRight,
              //         height: getProportionateScreenHeight(170),
              //         width: getProportionateScreenWidth(175),
              //         decoration: BoxDecoration(
              //             color: Color(0xFFF4F4F4),
              //             borderRadius: BorderRadius.circular(10),
              //             image: DecorationImage(
              //                 image:
              //                     FileImage(foodManagementController.mainFile!),
              //                 fit: BoxFit.fill)),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             Container(
              //               padding: EdgeInsets.all(3),
              //               margin: EdgeInsets.only(
              //                   right: getProportionateScreenWidth(5)),
              //               decoration: BoxDecoration(
              //                   color: Color(0xFFEBF9DC),
              //                   borderRadius: BorderRadius.circular(3)),
              //               child: SvgPicture.asset(
              //                 AppImages.photoUpload,
              //                 width: getProportionateScreenWidth(15),
              //                 height: getProportionateScreenHeight(15),
              //               ),
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 foodManagementController.mainFile = null;
              //                 foodManagementController.update();
              //               },
              //               child: Container(
              //                 padding: EdgeInsets.all(3),
              //                 margin: EdgeInsets.only(
              //                     left: getProportionateScreenWidth(5),
              //                     right: getProportionateScreenWidth(5)),
              //                 decoration: BoxDecoration(
              //                     color: Color(0xFFEBF9DC),
              //                     borderRadius: BorderRadius.circular(3)),
              //                 child: SvgPicture.asset(
              //                   AppImages.delete,
              //                   width: getProportionateScreenWidth(15),
              //                   height: getProportionateScreenHeight(15),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              : Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  height: getProportionateScreenHeight(170),
                  width: getProportionateScreenWidth(175),
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.photoUpload,
                        fit: BoxFit.cover,
                        height: getProportionateScreenHeight(56),
                        width: getProportionateScreenWidth(50),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        "Click To \nUpload",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.appTheme,
                            height: 1.9,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Additional\nImages",
              style: TextStyle(
                  color: AppColors.appTheme,
                  fontSize: getProportionalFontSize(12),
                  fontWeight: FontWeight.w800),
            ),

            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              color: AppColors.doveGray,
              child: clickToUpload(
                28,
                10,
                20,
                40,
                () {
                  if (controller.aditionalImages.length >= 3) {
                    Utils.showSnackbar("Max 3 images is allowed");
                  } else {
                    controller.getAdditionalImage();
                  }
                },
              ),
            ),
            // InkWell(
            //   onTap: () async {
            //     File? selectedFile = await Utils.getImage(source: 0);
            //     if (selectedFile != null && selectedFile.path.isNotEmpty) {
            //       foodManagementController.selectedFiles.add(selectedFile);
            //       foodManagementController.update();
            //     }
            //   },
            //   child: Container(
            //     margin: EdgeInsets.only(
            //         right: getProportionateScreenWidth(10),
            //         top: getProportionateScreenHeight(10)),
            //     height: getProportionateScreenHeight(110),
            //     width: getProportionateScreenWidth(120),
            //     decoration:
            //         BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //     child: DottedBorder(
            //         radius: Radius.circular(10),
            //         strokeCap: StrokeCap.butt,
            //         color: AppColors.appTheme,
            //         child: Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               SvgPicture.asset(
            //                 AppImages.photoUpload,
            //                 fit: BoxFit.cover,
            //                 height: getProportionateScreenHeight(25),
            //                 width: getProportionateScreenWidth(25),
            //               ),
            //               SizedBox(
            //                 height: getProportionateScreenHeight(5),
            //               ),
            //               Text(
            //                 "Click To \nUpload",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     color: AppColors.appTheme,
            //                     height: 1.5,
            //                     fontSize: getProportionalFontSize(11),
            //                     fontWeight: FontWeight.w800),
            //               )
            //             ],
            //           ),
            //         )),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  Widget clickToUpload(
      double height, double width, double radius, double imageSize, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
            top: getProportionateScreenHeight(10)),
        height: getProportionateScreenHeight(110),
        width: getProportionateScreenWidth(120),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.photoUpload,
                fit: BoxFit.cover,
                height: getProportionateScreenHeight(25),
                width: getProportionateScreenWidth(25),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(
                "Click To \nUpload",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.appTheme,
                    height: 1.5,
                    fontSize: getProportionalFontSize(11),
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
        // child: Column(
        //   children: [
        //     SvgPicture.asset("assets/images/upload.svg", height: imageSize),
        //     const SizedBox(height: 10),
        //     SizedBox(
        //       width: 120,
        //       child: Text(
        //         "Click To Upload",
        //         style: beVietnamProExtraBold.copyWith(
        //             color: AppColors.appTheme, fontSize: 18),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  // Widget clickToUpload1(
  //     double height, double width, double radius, double imageSize, onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //         height: 200,
  //         width: 200,
  //         // padding: EdgeInsets.symmetric(vertical: height, horizontal: width),
  //         decoration: BoxDecoration(
  //             image: DecorationImage(
  //                 fit: BoxFit.fill,
  //                 image:
  //                     CachedNetworkImageProvider(controller.productImageUrl)),
  //             borderRadius: BorderRadius.circular(radius),
  //             color: AppColors.grey),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SvgPicture.asset(AppIcons.uploadSmallSvg),
  //               const SizedBox(width: 10),
  //               SvgPicture.asset(AppIcons.deleteSvg)
  //             ],
  //           ),
  //         )),
  //   );
  // }

  Widget clickToUpload2(double height, double width, double radius,
      double imageSize, onTap, imgUrl, int index) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: getProportionateScreenWidth(8)),
        height: getProportionateScreenHeight(100),
        width: getProportionateScreenWidth(100),
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
            children: [
              InkWell(
                onTap: () {
                  controller.aditionalImages.removeAt(index);
                  controller.update();
                },
                child: SvgPicture.asset(
                  AppIcons.deleteSvg,
                  width: getProportionateScreenWidth(18),
                  height: getProportionateScreenHeight(18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column productInfo(AddEditFoodManagementController foodManagementController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Product Information",
            style: beVietnamProExtraBold.copyWith(
                fontSize: getProportionalFontSize(22),
                color: AppColors.appTheme)),
        Container(
          width: SizeConfig.deviceWidth!,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(10),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xFFEBF9DC),
          ),
          child: Form(
            key: pKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  title: "Product Name",
                  hintText: "Insert Name",
                  textEditingController: controller.productNameController,
                  validator: (value) => Validators.validateEmpty(value),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "Price",
                        hintText: "£ 30",
                        textEditingController: controller.priceController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    Expanded(
                      child: CustomTextField(
                        title: "Discount Price",
                        hintText: "£ 30",
                        textEditingController:
                            controller.discountPriceController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),

                CustomTextField(
                  title: "Inventory Stock",
                  hintText: "Enter product stock",
                  textEditingController: controller.inventoryStock,
                  validator: (value) => Validators.validateEmpty(value),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text("Parent Category"),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<ProductCategoryModel>(
                    isExpanded: false,
                    isDense: true,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(Icons.keyboard_arrow_down),
                    borderRadius: BorderRadius.circular(8),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: getProportionateScreenHeight(14),
                          bottom: getProportionateScreenHeight(14),
                          left: getProportionateScreenWidth(0),
                          right: getProportionateScreenWidth(16)),
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
                    // items: foodManagementController.parentCategoryList
                    items: foodManagementController.productCategoryList
                        .map(
                          (item) => DropdownMenuItem<ProductCategoryModel>(
                            value: item,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: getProportionateScreenHeight(5),
                                ),
                                Text(
                                  item.name.toString(),
                                  style: TextStyle(
                                      fontSize: getProportionalFontSize(12),
                                      overflow: TextOverflow.visible,
                                      color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (T) {
                      // foodManagementController.selectedParentCategory =
                      //     T as String;
                      foodManagementController.selectedParentProductCat =
                          T as ProductCategoryModel;
                      if (foodManagementController
                                  .selectedParentProductCat.subCategories !=
                              null &&
                          foodManagementController.selectedParentProductCat
                              .subCategories!.isNotEmpty) {
                        foodManagementController.selectedSubProductCat =
                            foodManagementController
                                .selectedParentProductCat.subCategories![0];
                      }
                      foodManagementController.update();
                    },
                    value: foodManagementController.selectedParentProductCat,
                    // value: foodManagementController
                    //             .selectedParentCategory.isEmpty &&
                    //         foodManagementController
                    //             .parentCategoryList.isNotEmpty
                    //     ? foodManagementController.parentCategoryList[0]
                    //     : foodManagementController.selectedParentCategory,
                    hint: const Text("Choose parent category"),
                    style: TextStyle(fontSize: getProportionalFontSize(12)),
                  ),
                ),

                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                foodManagementController.selectedParentProductCat.id != null &&
                        foodManagementController
                                .selectedParentProductCat.subCategories !=
                            null &&
                        foodManagementController.selectedParentProductCat
                            .subCategories!.isNotEmpty &&
                        foodManagementController.selectedSubProductCat.id !=
                            null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Sub Category"),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          ButtonTheme(
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
                                    top: getProportionateScreenHeight(14),
                                    bottom: getProportionateScreenHeight(14),
                                    left: getProportionateScreenWidth(0),
                                    right: getProportionateScreenWidth(16)),
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
                                  return 'Please select sub category';
                                }
                                return null;
                              },
                              // items: foodManagementController.parentCategoryList
                              items: foodManagementController
                                  .selectedParentProductCat.subCategories!
                                  .map(
                                    (item) =>
                                        DropdownMenuItem<ProductCategoryModel>(
                                      value: item,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(5),
                                          ),
                                          Text(
                                            item.name.toString(),
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionalFontSize(12),
                                                overflow: TextOverflow.visible,
                                                color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (T) {
                                // foodManagementController.selectedParentCategory =
                                //     T as String;
                                foodManagementController.selectedSubProductCat =
                                    T as ProductCategoryModel;
                                foodManagementController.update();
                              },
                              value: foodManagementController
                                  .selectedSubProductCat,
                              // value: foodManagementController
                              //             .selectedParentCategory.isEmpty &&
                              //         foodManagementController
                              //             .parentCategoryList.isNotEmpty
                              //     ? foodManagementController.parentCategoryList[0]
                              //     : foodManagementController.selectedParentCategory,
                              hint: const Text("Choose sub category"),
                              style: TextStyle(
                                  fontSize: getProportionalFontSize(12)),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                // DropDownTextField.multiSelection(
                //   clearOption: false,
                //   textFieldDecoration: InputDecoration(
                //       hintStyle: TextStyle(
                //         fontSize: getProportionalFontSize(12),
                //       ),
                //       fillColor: Colors.white,
                //       filled: true,
                //       contentPadding: EdgeInsets.only(
                //           top: getProportionateScreenHeight(16),
                //           bottom: getProportionateScreenHeight(16),
                //           left: getProportionateScreenWidth(16)),
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(8),
                //           borderSide: BorderSide.none),
                //       focusedBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(8),
                //           borderSide: BorderSide.none),
                //       enabledBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(8),
                //           borderSide: BorderSide.none),
                //       hintText: "Select stall category"),
                //   displayCompleteItem: true,
                //   submitButtonColor: AppColors.appTheme,
                //   submitButtonTextStyle: TextStyle(color: Colors.white),
                //   listPadding: ListPadding(
                //       top: getProportionateScreenHeight(7),
                //       bottom: getProportionateScreenHeight(7)),
                //   submitButtonText: "Okay",
                //
                //   dropDownList: foodManagementController.stallCategoryList
                //       .map((e) => DropDownValueModel(value: e, name: e))
                //       .toList(),
                //   checkBoxProperty: CheckBoxProperty(
                //     checkColor: AppColors.appTheme,
                //     fillColor: MaterialStateProperty.all(Colors.transparent),
                //     side: MaterialStateBorderSide.resolveWith(
                //       (Set<MaterialState> states) {
                //         if (states.contains(MaterialState.selected)) {
                //           return BorderSide(
                //               color: AppColors.appTheme, width: 1.3);
                //         }
                //         return const BorderSide(color: Colors.grey, width: 1.3);
                //       },
                //     ),
                //   ),
                //   textStyle: TextStyle(
                //     fontSize: getProportionalFontSize(13),
                //     letterSpacing: .3,
                //   ),
                //   listTextStyle: TextStyle(
                //       fontSize: getProportionalFontSize(13), letterSpacing: .3),
                //   dropDownIconProperty: IconProperty(
                //       icon: Icons.keyboard_arrow_down,
                //       color: Colors.white,
                //       size: 25),
                //   dropdownColor: Colors.white,
                //   // validator: (value) {
                //   //   if (value == null) {
                //   //     return 'Please select stall category';
                //   //   }
                //   //   return null;
                //   // },
                // ),
                // CustomTextField(
                //   title: "Category",
                //   hintText: "Select Product Category",
                //   textEditingController: TextEditingController(),
                // ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                CustomTextField(
                  maxLines: 3,
                  title: "Ingredients",
                  hintText: "Insert ingredients",
                  textEditingController: controller.ingredientController,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "Unit",
                        hintText: "(ex: L, ml, Kg, g)",
                        textEditingController: controller.unitController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    Expanded(
                      child: CustomTextField(
                        title: "Weight",
                        hintText: "Insert Weight",
                        textEditingController: controller.weightController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                CustomTextField(
                  title: "Package",
                  hintText: "Item per package (ex: 1, 6, 10)",
                  textEditingController: controller.packageController,
                  validator: (value) => Validators.validateEmpty(value),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                CustomTextField(
                  maxLines: 4,
                  title: "Product Long Description",
                  hintText: "Insert Description",
                  textEditingController:
                      controller.packageDescriptionController,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget variantItems(List<Variant> foodList) {
    return ListView.builder(
      itemCount: foodList.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Variant food = foodList[index];
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
                          value: controller.selectedVariant.contains(food),
                          onChanged: (v) {
                            if (controller.selectedVariant.contains(food)) {
                              controller.selectedVariant
                                  .remove(food); // unselect
                            } else {
                              controller.selectedVariant.add(food); // select
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
                      food.image != null
                          ? CachedNetworkImage(
                              // imageUrl: Constants.imgUrl + restaurant.images,
                              imageUrl: getImageUrl(food.image),
                              fit: BoxFit.contain,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: getProportionateScreenHeight(65),
                                width: getProportionateScreenWidth(65),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
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
                                  food.name ?? '',
                                  style: urbanistMedium.copyWith(fontSize: 14),
                                )),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(" ${food.dprice ?? '-'}",
                                    style:
                                        urbanistMedium.copyWith(fontSize: 16)),
                                const SizedBox(height: 5),
                                Text(" ${food.price ?? '-'}",
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

  Widget similarItems(List<SimilarFood> foodList) {
    return ListView.builder(
      itemCount: foodList.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        SimilarFood food = foodList[index];
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
                          value: controller.selectedSimilar.contains(food),
                          onChanged: (v) {
                            if (controller.selectedSimilar.contains(food)) {
                              controller.selectedSimilar
                                  .remove(food); // unselect
                            } else {
                              controller.selectedSimilar.add(food); // select
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
                      food.image != null
                          ? CachedNetworkImage(
                              // imageUrl: Constants.imgUrl + restaurant.images,
                              imageUrl: getImageUrl(food.image),
                              fit: BoxFit.contain,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: getProportionateScreenHeight(65),
                                width: getProportionateScreenWidth(65),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fill,
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
                                  food.name ?? '',
                                  style: urbanistMedium.copyWith(fontSize: 14),
                                )),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(" ${food.discountprice ?? '-'}",
                                    style:
                                        urbanistMedium.copyWith(fontSize: 16)),
                                const SizedBox(height: 5),
                                Text(" ${food.price ?? '-'}",
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

  GlobalKey<FormState> variantFormKey = GlobalKey<FormState>();

  Column addNewVariant(
      AddEditFoodManagementController addEditFoodManagementController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add New",
          style: beVietnamProExtraBold.copyWith(
              fontSize: getProportionalFontSize(20), color: AppColors.appTheme),
        ),
        Container(
          width: SizeConfig.deviceWidth!,
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(16),
            vertical: getProportionateScreenHeight(10),
          ),
          margin: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade300,
          ),
          child: Form(
            key: variantFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  title: "Product Name",
                  hintText: "Insert Name",
                  textEditingController: addEditFoodManagementController
                      .variantProductNameController,
                  validator: (value) => Validators.validateEmpty(value),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "Price",
                        hintText: "£ 30",
                        textEditingController: addEditFoodManagementController
                            .variantPriceController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    Expanded(
                      child: CustomTextField(
                        title: "Discount Price",
                        hintText: "£ 30",
                        textEditingController: addEditFoodManagementController
                            .variantDiscountPriceController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "Unit",
                        hintText: "(ex: L, mL, Kg, g)",
                        textEditingController: addEditFoodManagementController
                            .variantProductUnitController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    ),
                    SizedBox(
                      width: getProportionateScreenWidth(8),
                    ),
                    Expanded(
                      child: CustomTextField(
                        title: "Weight",
                        hintText: "Insert Weight",
                        textEditingController: addEditFoodManagementController
                            .variantWeightController,
                        validator: (value) => Validators.validateEmpty(value),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            File? selectedFile = await Utils.getImage(source: 0);
            if (selectedFile != null && selectedFile.path.isNotEmpty) {
              addEditFoodManagementController.addNewFile = (selectedFile);
              addEditFoodManagementController.update();
            }
          },
          child: addEditFoodManagementController.addNewFile != null &&
                  addEditFoodManagementController.addNewFile!.path.isNotEmpty
              ? Container(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(8),
                      right: getProportionateScreenWidth(8)),
                  alignment: Alignment.topRight,
                  margin:
                      EdgeInsets.only(left: getProportionateScreenWidth(10)),
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenHeight(100),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: FileImage(
                              addEditFoodManagementController.addNewFile!),
                          fit: BoxFit.fill)),
                  child: InkWell(
                    onTap: () {
                      addEditFoodManagementController.addNewFile = null;
                      addEditFoodManagementController.update();
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(
                          left: getProportionateScreenWidth(5),
                          right: getProportionateScreenWidth(5)),
                      decoration: BoxDecoration(
                          color: Color(0xFFEBF9DC),
                          borderRadius: BorderRadius.circular(3)),
                      child: SvgPicture.asset(
                        AppImages.delete,
                        width: getProportionateScreenWidth(15),
                        height: getProportionateScreenHeight(15),
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(
                      right: getProportionateScreenWidth(10),
                      top: getProportionateScreenHeight(10)),
                  height: getProportionateScreenHeight(110),
                  width: getProportionateScreenWidth(120),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: DottedBorder(
                      radius: Radius.circular(10),
                      strokeCap: StrokeCap.butt,
                      color: AppColors.appTheme,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.photoUpload,
                              fit: BoxFit.cover,
                              height: getProportionateScreenHeight(25),
                              width: getProportionateScreenWidth(25),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Text(
                              "Click To\nUpload An\nImage",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.appTheme,
                                  height: 1.5,
                                  fontSize: getProportionalFontSize(11),
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      )),
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(16),
          ),
          child: Center(
            child: DefaultButton(
              onTap: () {
                if (variantFormKey.currentState!.validate()) {
                  if (addEditFoodManagementController.addNewFile != null) {
                    addEditFoodManagementController.addProductVariant(
                        addEditFoodManagementController
                                .getFoodDetailResponse.id ??
                            '0');
                  } else {
                    Utils.showSnackbar("Please upload image");
                  }
                }
              },
              width: SizeConfig.deviceWidth! * .6,
              backgroundColor: AppColors.buttonColor,
              buttonText: 'Add Variant',
            ),
          ),
        )
      ],
    );
  }
}
