import 'package:famooshed_vendor/app/modules/add_new_driver_module/add_new_driver_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class AddNewDriverPage extends GetView<AddNewDriverController> {
  AddNewDriverPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "Add / Edit Driver",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder(
            builder: (AddNewDriverController addNewDriverController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Driver Information",
                      style: beVietnamProExtraBold.copyWith(
                          color: AppColors.appTheme, fontSize: 22)),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(color: AppColors.lightGreen),
                      child: productInformation()),
                  // productVariants(),
                  // recommendedProducts(),
                  DefaultButton(
                    onTap: () {
                      if (fKey.currentState!.validate()) {
                        controller.addNewDriver();
                        // if (controller.selected != "bicycle") {
                        //   if (controller.editImageId.isNotEmpty) {
                        //     controller.addNewDriver();
                        //   } else {
                        //     Utils.showSnackbar(
                        //         "Please upload Proof od Document");
                        //   }
                        // } else {
                        //   controller.addNewDriver();
                        // }
                      }
                    },
                    width: Get.width * .9,
                    buttonText: 'Save ',
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

  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  Widget productInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Form(
        key: fKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       text("Select Area of Work"),
                //       ButtonTheme(
                //         alignedDropdown: true,
                //         child: DropdownButtonFormField<Areawork>(
                //           isExpanded: true,
                //           isDense: true,
                //           alignment: Alignment.bottomLeft,
                //           icon: Icon(Icons.keyboard_arrow_down),
                //           borderRadius: BorderRadius.circular(8),
                //           decoration: InputDecoration(
                //             fillColor: Colors.white,
                //             filled: true,
                //             contentPadding: EdgeInsets.only(
                //               top: getProportionateScreenHeight(4),
                //               bottom: getProportionateScreenHeight(4),
                //               left: getProportionateScreenWidth(0),
                //               right: getProportionateScreenWidth(6),
                //             ),
                //             border: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide: BorderSide.none),
                //             focusedBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide: BorderSide.none),
                //             enabledBorder: OutlineInputBorder(
                //                 borderRadius: BorderRadius.circular(8),
                //                 borderSide: BorderSide.none),
                //           ),
                //           validator: (value) {
                //             if (value == null) {
                //               return 'Please select Areawork';
                //             }
                //             return null;
                //           },
                //           items: controller.areaWorkList
                //               .map(
                //                 (item) => DropdownMenuItem<Areawork>(
                //                   value: item,
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Text(
                //                         item.areaName.toString(),
                //                         maxLines: 1,
                //                         overflow: TextOverflow.ellipsis,
                //                         style: TextStyle(
                //                             fontSize:
                //                                 getProportionalFontSize(12),
                //                             overflow: TextOverflow.visible,
                //                             color: Colors.black),
                //                         textAlign: TextAlign.start,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               )
                //               .toList(),
                //           onChanged: (T) {
                //             controller.selectedAreaWork = T as Areawork;
                //             controller.update();
                //           },
                //           value: controller.selectedAreaWork,
                //           hint: const Text("Select Area of Work"),
                //           style:
                //               TextStyle(fontSize: getProportionalFontSize(12)),
                //         ),
                //       ),
                //       // textField("Select Area of Work", controller.areaOfWork),
                //     ],
                //   ),
                // ),
                // const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Full Name"),
                      textField("Full Name", controller.nameController),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text("Email Address"),
                      textField("Email Address", controller.emailController),
                    ],
                  ),
                ),
                // const SizedBox(width: 10),
                // Flexible(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       text("Phone Number"),
                //       textField("Phone Number", controller.phoneController),
                //     ],
                //   ),
                // ),
              ],
            ),
            text("Password"),
            textField("Create Password", controller.passwordController,
                obsecure: true),
            text("Address"),
            textField("Address", controller.address1Controller),
            text("Phone Number"),
            textField("Phone Number", controller.phoneController),
            // Row(
            //   children: [
            //     Flexible(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Country"),
            //           textField("Country", controller.countryController,
            //               readOnly: false)
            //         ],
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Flexible(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Address Line 1"),
            //           textField("Address Line 1", controller.address1Controller)
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Flexible(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Address Line 2"),
            //           textField(
            //               "Address Line 2", controller.address2Controller),
            //         ],
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Flexible(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Town or City"),
            //           textField("Town or City", controller.townCityController),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Flexible(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Postal Code"),
            //           textField("Postal Code", controller.postalCode),
            //         ],
            //       ),
            //     ),
            //     // const SizedBox(width: 10),
            //     // Flexible(
            //     //   child: Column(
            //     //     crossAxisAlignment: CrossAxisAlignment.start,
            //     //     children: [
            //     //       text("Date Of Birth"),
            //     //       textField("Date Of Birth", controller.dobController),
            //     //     ],
            //     //   ),
            //     // ),
            //   ],
            // ),
            //
            // text("Please Select Vehicle type:"),
            // Row(
            //   children: [
            //     Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //       Radio(
            //           activeColor: AppColors.appTheme,
            //           value: "bicycle",
            //           groupValue: controller.selected,
            //           onChanged: (val) {
            //             controller.selected = val as String;
            //             controller.update();
            //           }),
            //       SizedBox(
            //         height: 32,
            //         width: 32,
            //         child: Image.asset(
            //           controller.checkListItems[0]["title"],
            //           color: AppColors.appTheme,
            //         ),
            //       )
            //     ]),
            //     Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //       Radio(
            //           activeColor: AppColors.appTheme,
            //           value: "scooter",
            //           groupValue: controller.selected,
            //           onChanged: (val) {
            //             controller.selected = val as String;
            //             controller.update();
            //           }),
            //       SizedBox(
            //         height: 32,
            //         width: 32,
            //         child: Image.asset(
            //           controller.checkListItems[1]["title"],
            //           color: AppColors.appTheme,
            //         ),
            //       )
            //     ]),
            //     Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //       Radio(
            //           activeColor: AppColors.appTheme,
            //           value: "car",
            //           groupValue: controller.selected,
            //           onChanged: (val) {
            //             controller.selected = val as String;
            //             controller.update();
            //           }),
            //       SizedBox(
            //         height: 32,
            //         width: 32,
            //         child: Image.asset(
            //           controller.checkListItems[2]["title"],
            //           color: AppColors.appTheme,
            //         ),
            //       )
            //     ]),
            //   ],
            // ),
            // controller.selected != "bicycle" && controller.selected.isNotEmpty
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           text("Please Upload Proof Document(RC, DL):"),
            //           controller.editImageUrl.isNotEmpty
            //               ? GestureDetector(
            //                   onTap: () async {
            //                     File? selectedFile =
            //                         await Utils.getImage(source: 0);
            //                     if (selectedFile != null) {
            //                       // controller.addNewFile = File(selectedFile.path);
            //                       controller
            //                           .uploadProductImage(selectedFile.path);
            //                     }
            //                   },
            //                   child: Container(
            //                     width: Get.width * .9,
            //                     height: Get.height * .18,
            //                     padding: EdgeInsets.symmetric(
            //                         vertical: 28, horizontal: 10),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(20),
            //                         image: DecorationImage(
            //                           fit: BoxFit.contain,
            //                           image: CachedNetworkImageProvider(
            //                             Constants.imgUrl +
            //                                 controller.editImageUrl,
            //                           ),
            //                         ),
            //                         color: AppColors.grey),
            //                   ),
            //                 )
            //               : GestureDetector(
            //                   onTap: () async {
            //                     File? selectedFile =
            //                         await Utils.getImage(source: 0);
            //                     if (selectedFile != null) {
            //                       // controller.addNewFile = File(selectedFile.path);
            //                       controller
            //                           .uploadProductImage(selectedFile.path);
            //                     }
            //                   },
            //                   child: Container(
            //                     width: Get.width * .9,
            //                     height: Get.height * .18,
            //                     padding: EdgeInsets.symmetric(
            //                         vertical: 28, horizontal: 10),
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(20),
            //                         color: AppColors.grey),
            //                     child: Column(
            //                       children: [
            //                         SvgPicture.asset(
            //                             "assets/images/imageplace.svg",
            //                             height: 48),
            //                         const SizedBox(height: 10),
            //                         Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           children: [
            //                             SvgPicture.asset(
            //                                 "assets/images/upload.svg",
            //                                 height: 22),
            //                             const SizedBox(width: 8),
            //                             Text(
            //                               "Click here to Upload",
            //                               style: beVietnamProExtraBold.copyWith(
            //                                   color: AppColors.appTheme,
            //                                   fontSize: 13),
            //                               textAlign: TextAlign.start,
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 )
            //         ],
            //       )
            //     : const SizedBox()
            // Column(
            //   children: List.generate(
            //     controller.checkListItems.length,
            //     (index) => CheckboxListTile(
            //       controlAffinity: ListTileControlAffinity.leading,
            //       contentPadding: EdgeInsets.zero,
            //       dense: true,
            // title: SizedBox(
            //   height: 32,
            //   width: 32,
            //   child: Image.asset(
            //     controller.checkListItems[index]["title"],
            //     color: AppColors.appTheme,
            //   ),
            // ),
            //       value: controller.checkListItems[index]["value"],
            //       onChanged: (value) {},
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget textField(hintText, textController,
      {readOnly = false, obsecure = false}) {
    return CustomTextFieldWidget(
      // maxLength: 6,
      readOnly: readOnly,
      controller: textController,
      fillColor: AppColors.white,
      obscureText: obsecure,
      hintText: hintText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
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
}
