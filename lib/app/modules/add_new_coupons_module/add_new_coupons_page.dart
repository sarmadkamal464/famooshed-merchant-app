import 'package:famooshed_vendor/app/modules/add_new_coupons_module/add_new_coupons_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../libraries/custom_dropdown/dropdown_textfield.dart';
import '../../common/util/exports.dart';
import '../../theme/size_config.dart';

class AddNewCouponsPage extends GetView<AddNewCouponsController> {
  const AddNewCouponsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
          title: "Add New Coupon",
          centerTitle: true,
          textColor: AppColors.appTheme),
      body: GetBuilder<AddNewCouponsController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Coupon Information",
                      style: beVietnamProExtraBold.copyWith(
                          color: AppColors.appTheme, fontSize: 22)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(color: AppColors.lightGreen),
                    child: productInformation(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          text(Strings.code),
          textField("Insert Name", controller.promoCodeController, () {}, false,
              TextInputType.text),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.start),
                    textField(
                        "dd-MM-yyyy, --:-- --", controller.startController,
                        () async {
                      DateTime currentDateTime = DateTime.now().toLocal();
                      if (controller.startController.text.isNotEmpty) {
                        currentDateTime = DateFormat('dd-MM-yyyy, hh:mm a')
                            .parse(controller.startController.text);

                        // DateTime.parse(controller.scheduleController.text).formatedDate(dateFormat: 'yyyy-MM-ddTHH:mm');
                      }
                      DateTime? dateTime = await DatePicker.showDateTimePicker(
                        Get.context!,
                        currentTime: currentDateTime,
                      );
                      if (dateTime != null) {
                        controller.startController.text =
                            DateFormat('dd-MM-yyyy, hh:mm a').format(dateTime);
                        controller.update();
                      }
                      // final DateTime? picked = await showDatePicker(
                      //   context: Get.context!,
                      //   initialDate: controller.startDate,
                      //   firstDate:
                      //       DateTime.now().subtract(const Duration(days: 0)),
                      //   lastDate: DateTime(2100),
                      //   builder: (context, child) {
                      //     return Theme(
                      //       data: Theme.of(context).copyWith(
                      //           colorScheme: ColorScheme.light(
                      //         primary: AppColors.appTheme,
                      //         onPrimary: Colors.white,
                      //         onSurface: Colors.black,
                      //       )),
                      //       child: child!,
                      //     );
                      //   },
                      // );
                      // if (picked != null && picked != controller.startDate) {
                      //   dprint(picked);
                      //   controller.startDate = picked;
                      //   controller.startController.text =
                      //       Jiffy.parse(picked.toString())
                      //           .format(pattern: 'dd MMM');
                      // }
                    }, true, TextInputType.none)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.end),
                    textField("dd-MM-yyyy, --:-- --", controller.endController,
                        () async {
                      DateTime currentDateTime = DateTime.now().toLocal();
                      if (controller.endController.text.isNotEmpty) {
                        currentDateTime = DateFormat('dd-MM-yyyy, hh:mm a')
                            .parse(controller.endController.text);

                        // DateTime.parse(controller.scheduleController.text).formatedDate(dateFormat: 'yyyy-MM-ddTHH:mm');
                      }
                      DateTime? dateTime = await DatePicker.showDateTimePicker(
                        Get.context!,
                        currentTime: currentDateTime,
                      );
                      if (dateTime != null) {
                        controller.endController.text =
                            DateFormat('dd-MM-yyyy, hh:mm a').format(dateTime);
                        controller.update();
                      }
                      // final DateTime? picked = await showDatePicker(
                      //   context: Get.context!,
                      //   initialDate: controller.startDate,
                      //   firstDate: controller.startDate
                      //       .subtract(const Duration(days: 0)),
                      //   lastDate: DateTime(2100),
                      //   builder: (context, child) {
                      //     return Theme(
                      //       data: Theme.of(context).copyWith(
                      //           colorScheme: ColorScheme.light(
                      //         primary: AppColors.appTheme,
                      //         onPrimary: Colors.white,
                      //         onSurface: Colors.black,
                      //       )),
                      //       child: child!,
                      //     );
                      //   },
                      // );
                      // if (picked != null && picked != controller.endDate) {
                      //   dprint(picked);
                      //   controller.endDate = picked;
                      //   controller.endController.text =
                      //       Jiffy.parse(picked.toString())
                      //           .format(pattern: 'dd MMM');
                      // }
                    }, true, TextInputType.none),
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
                    text(Strings.discount),
                    textField("30", controller.discountController, () {}, false,
                        TextInputType.number)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(Strings.per),
                    CheckboxListTile(
                        activeColor: AppColors.appTheme,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Discount In percents",
                          style: urbanistMedium.copyWith(
                              fontSize: getProportionalFontSize(16)),
                        ),
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                        value: controller.inPercent.value,
                        onChanged: (v) {
                          controller.inPercent.value = v!;
                          controller.update();
                        }),
                    // textField("%  Percentage", controller.percentageController,
                    //     () {}, false)
                  ],
                ),
              ),
            ],
          ),
          text(Strings.amount),

          text('Minimum purchase amount'),
          textField("Enter amount", controller.minAmountController, () {},
              false, TextInputType.number),
          Transform.scale(
            scale: 1.08,
            child: CheckboxListTile(
                activeColor: AppColors.appTheme,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "Coupon for All categories",
                  style: urbanistMedium.copyWith(
                      fontSize: getProportionalFontSize(16)),
                ),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
                value: controller.allCategory.value,
                onChanged: (v) {
                  controller.allCategory.value = v!;
                  controller.update();
                }),
          ),
          Visibility(
              visible: !controller.allCategory.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('Coupon for Category'),
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
                            bottom: getProportionateScreenHeight(16),
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
                        hintText: "Select Category"),
                    displayCompleteItem: true,
                    submitButtonColor: AppColors.appTheme,
                    submitButtonTextStyle: TextStyle(color: Colors.white),
                    listPadding: ListPadding(
                        top: getProportionateScreenHeight(7),
                        bottom: getProportionateScreenHeight(7)),
                    submitButtonText: "Okay",

                    dropDownList: controller.categoryList
                        .map((e) => DropDownValueModel(value: e, name: e.name))
                        .toList(),

                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedCategoryList.clear();
                        List<DropDownValueModel> result = value;
                        if (result.isNotEmpty) {
                          result.forEach((element) {
                            controller.selectedCategoryList.add(element.value);
                          });
                        }
                        controller.update();
                      }
                    },
                    checkBoxProperty: CheckBoxProperty(
                      checkColor: AppColors.appTheme,
                      fillColor: MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateBorderSide.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return BorderSide(
                                color: AppColors.appTheme, width: 1.3);
                          }
                          return const BorderSide(
                              color: Colors.grey, width: 1.3);
                        },
                      ),
                    ),
                    textStyle: urbanistRegular.copyWith(
                        fontSize: getProportionalFontSize(14),
                        letterSpacing: .3),
                    listTextStyle: urbanistRegular.copyWith(
                        fontSize: getProportionalFontSize(13),
                        letterSpacing: .2),
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
                ],
              )),

          Transform.scale(
            scale: 1.08,
            child: CheckboxListTile(
                activeColor: AppColors.appTheme,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  "Coupon for All products",
                  style: urbanistMedium.copyWith(
                      fontSize: getProportionalFontSize(16)),
                ),
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
                value: controller.allFoods.value,
                onChanged: (v) {
                  controller.allFoods.value = v!;
                  controller.update();
                }),
          ),
          Visibility(
              visible: !controller.allFoods.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('Coupon for Products'),
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
                            bottom: getProportionateScreenHeight(16),
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
                        hintText: "Select Foods"),
                    displayCompleteItem: true,
                    submitButtonColor: AppColors.appTheme,
                    submitButtonTextStyle: TextStyle(color: Colors.white),
                    listPadding: ListPadding(
                        top: getProportionateScreenHeight(7),
                        bottom: getProportionateScreenHeight(7)),
                    submitButtonText: "Okay",

                    dropDownList: controller.foodList
                        .map((e) => DropDownValueModel(value: e, name: e.name))
                        .toList(),

                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedFoodList.clear();
                        List<DropDownValueModel> result = value;
                        if (result.isNotEmpty) {
                          result.forEach((element) {
                            controller.selectedFoodList.add(element.value);
                          });
                        }
                        controller.update();
                      }
                    },
                    checkBoxProperty: CheckBoxProperty(
                      checkColor: AppColors.appTheme,
                      fillColor: MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateBorderSide.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return BorderSide(
                                color: AppColors.appTheme, width: 1.3);
                          }
                          return const BorderSide(
                              color: Colors.grey, width: 1.3);
                        },
                      ),
                    ),
                    textStyle: urbanistRegular.copyWith(
                        fontSize: getProportionalFontSize(14),
                        letterSpacing: .3),
                    listTextStyle: urbanistRegular.copyWith(
                        fontSize: getProportionalFontSize(13),
                        letterSpacing: .2),
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
                ],
              )),

          // text(Strings.onProduct),
          // textField("All", controller.prouctController, () {}, true),
          text(Strings.shortDescription),
          customTextArea("Insert description.\nMax 250 symbols"),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultButton(
                onTap: () {
                  controller.addNewCoupon(0);
                },
                width: Get.width * .4,
                buttonText: 'Save',
              ),
              DefaultButton(
                onTap: () {
                  controller.addNewCoupon(1);
                },
                width: Get.width * .4,
                buttonText: 'Save & Publish',
              ),
            ],
          )
          // customTextArea("Insert Descrption"),
        ],
      ),
    );
  }

  Widget textField(hintText, controller, onTap, readOnly, TextInputType type) {
    return CustomTextFieldWidget(
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      fillColor: AppColors.white,
      obscureText: false,
      hintText: hintText,
      keyboardType: type,
      hintStyle:
          urbanistRegular.copyWith(fontSize: 14, color: AppColors.doveGray),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.white)),
    );
  }

  text(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: urbanistRegular.copyWith(fontSize: 16)),
    );
  }

  Widget customTextArea(hintText) {
    return TextFormField(
      controller: controller.desController,
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
}
