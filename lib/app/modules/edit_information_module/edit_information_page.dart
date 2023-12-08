import 'package:famooshed_vendor/app/modules/edit_information_module/edit_information_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../libraries/custom_dropdown/dropdown_textfield.dart';
import '../../common/util/exports.dart';

class EditInformationPage extends GetView<EditInformationController> {
  const EditInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "My Stall Settings",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder<EditInformationController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  children: [
                    freeDelivery(),
                    Obx(
                      () => controller.famooshedDeliveryDriver.value
                          ? important()
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.grey),
                        child: card(
                            "Minimum purchase amount",
                            "For ex: 100. If 0 - no Minimum purchase amount",
                            controller.minFeeController)),
                    const SizedBox(height: 15),
                    // Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         color: AppColors.grey),
                    //     child: card(
                    //         "Minimum purchase amount",
                    //         "For ex: 100. If 0 - no Minimum purchase amount",
                    //         controller.minFeeController)),
                    // const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.grey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Business Categories",
                              style: beVietnamProExtraBold.copyWith(
                                  fontSize: 22, color: AppColors.appTheme),
                            ),
                            const SizedBox(height: 8),
                            DropDownTextField.multiSelection(
                              clearOption: false,
                              textFieldDecoration: InputDecoration(
                                  hintStyle: AppTextStyle.regularStyle.copyWith(
                                    color: AppColors.mineShaft,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      top: getProportionateScreenHeight(8),
                                      bottom: getProportionateScreenHeight(8),
                                      left: getProportionateScreenWidth(16)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide.none),
                                  hintText: "Select stall category"),
                              displayCompleteItem: true,
                              submitButtonColor: AppColors.appTheme,
                              submitButtonTextStyle:
                                  TextStyle(color: Colors.white),
                              listPadding: ListPadding(
                                  top: getProportionateScreenHeight(7),
                                  bottom: getProportionateScreenHeight(7)),
                              submitButtonText: "Okay",
                              dropDownList: controller.stallCatList
                                  .map((e) => DropDownValueModel(
                                      value: e, name: e.name ?? '-'))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedStallList.clear();
                                  List<DropDownValueModel> result = value;
                                  if (result.isNotEmpty) {
                                    result.forEach((element) {
                                      controller.selectedStallList
                                          .add(element.value);
                                    });
                                  }
                                  controller.update();
                                }
                                print(controller.selectedStallList);
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
                              textStyle: AppTextStyle.regularStyle.copyWith(
                                color: AppColors.mineShaft,
                                fontSize: Dimens.fontSize14,
                              ),
                              listTextStyle: AppTextStyle.regularStyle.copyWith(
                                color: AppColors.mineShaft,
                                fontSize: Dimens.fontSize14,
                              ),
                              dropDownIconProperty: IconProperty(
                                  icon: Icons.arrow_drop_down,
                                  color: Colors.grey,
                                  size: 25),
                              dropdownColor: Colors.white,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select stall category';
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                    const SizedBox(height: 15),
                    DefaultButton(
                        onTap: () {
                          controller.saveSetting();
                        },
                        width: Get.width * .5,
                        buttonText: "Save Changes")
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget important() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Theme(
        data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
        child: ListTileTheme(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          tileColor: AppColors.expansionCardRedColor,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.amaranth)),
            child: ExpansionTile(
              clipBehavior: Clip.hardEdge,
              collapsedShape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              collapsedBackgroundColor: AppColors.expansionCardRedColor,
              title: Text(
                'Important!',
                style: beVietnamProExtraBold.copyWith(
                    fontSize: 22, color: AppColors.redColor),
              ),
              subtitle: Text(
                "Exclusive to Famooshed Only",
                style: beVietnamProMedium.copyWith(
                    fontSize: 18, color: AppColors.redColor),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Strings.deliveryPer,
                                style: urbanistRegular.copyWith(fontSize: 14)),
                            const SizedBox(height: 10),
                            Text(Strings.percentage,
                                style: urbanistRegular.copyWith(fontSize: 14)),
                            const SizedBox(height: 10),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Current :',
                                  style: urbanistBold.copyWith(
                                      fontSize: 14, color: AppColors.black)),
                              TextSpan(
                                  text:
                                      ' £${controller.deliverFeeController.text}',
                                  style: urbanistBold.copyWith(
                                      fontSize: 14, color: AppColors.black)),
                            ]))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget freeDelivery() {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.lightGreen),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * .06, vertical: Get.width * .05),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              Strings.freeDelivery,
              style: beVietnamProExtraBold.copyWith(
                fontSize: getProportionalFontSize(22),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            AbsorbPointer(
              absorbing: true,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8),
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Transform.scale(
                      scale: 1.08,
                      child: CheckboxListTile(
                          activeColor: AppColors.appTheme,
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Famooshed delivery driver"),
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                          value: controller.famooshedDeliveryDriver.value,
                          onChanged: (v) {
                            controller.famooshedDeliveryDriver.value = v!;
                            controller.update();
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: SizedBox(
                          child: CustomTextFieldWidget(
                            controller: controller.deliverFeeController,
                            fillColor: AppColors.white,
                            keyboardType: TextInputType.number,
                            prefixIconPadding:
                                const EdgeInsets.only(left: 15, right: 10),
                            obscureText: false,
                            hintText: "£ 30",
                            onChanged: (value) {
                              if (value != null) {
                                controller.deliverFeeController.text = value;
                                controller.update();
                              }
                            },
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide:
                                    const BorderSide(color: AppColors.white)),
                          ),
                        )),
                        SizedBox(
                          width: getProportionateScreenWidth(8),
                        ),
                        Text(
                          "Insert Delivery Fee",
                          style: urbanistRegular.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Transform.scale(
                            scale: 0.8,
                            alignment: Alignment.centerLeft,
                            child: CheckboxListTile(
                                activeColor: AppColors.appTheme,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: const Text("Percents"),
                                value: controller
                                    .famooshedDeliveryDriverPercentValue.value,
                                onChanged: (v) {
                                  if (v != null && v == true) {
                                    controller.famooshedDeliveryDriverPerKmValue
                                        .value = false;
                                  } else {
                                    controller.famooshedDeliveryDriverPerKmValue
                                        .value = true;
                                  }
                                  controller.famooshedDeliveryDriverPercentValue
                                      .value = v!;

                                  controller.update();
                                }),
                          ),
                        ),
                        Expanded(
                          child: Transform.scale(
                            scale: 0.8,
                            alignment: Alignment.centerLeft,
                            child: CheckboxListTile(
                                activeColor: AppColors.appTheme,
                                visualDensity: VisualDensity.compact,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: const Text("Per Mile"),
                                value: controller
                                    .famooshedDeliveryDriverPerKmValue.value,
                                onChanged: (v) {
                                  if (v != null && v == true) {
                                    controller
                                        .famooshedDeliveryDriverPercentValue
                                        .value = false;
                                  } else {
                                    controller
                                        .famooshedDeliveryDriverPercentValue
                                        .value = true;
                                  }
                                  controller.famooshedDeliveryDriverPerKmValue
                                      .value = v!;
                                  controller.update();
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "Pick-up",
              style: TextStyle(
                  fontSize: getProportionalFontSize(15),
                  fontWeight: FontWeight.w500),
            ),
            // Transform.scale(
            //   scale: 1.08,
            //   child: CheckboxListTile(
            //       checkColor: AppColors.white,
            //       activeColor: AppColors.appTheme,
            //       contentPadding: EdgeInsets.zero,
            //       checkboxShape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(3),
            //       ),
            //       controlAffinity: ListTileControlAffinity.leading,
            //       title: const Text("Pick-up"),
            //       value: controller.pickUp.value,
            //       onChanged: (v) {
            //         controller.pickUp.value = v!;
            //       }),
            // ),
            Transform.scale(
              scale: 0.8,
              alignment: Alignment.centerLeft,
              child: CheckboxListTile(
                  activeColor: AppColors.appTheme,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                      "Customer can select a date and time to collect their order from your chosen pick-up point"),
                  value: controller.pickUpSub1.value,
                  onChanged: (v) {
                    controller.pickUpSub1.value = v!;
                    controller.update();
                  }),
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Text(
              "Next Day National Courier Delivery",
              style: TextStyle(
                  fontSize: getProportionalFontSize(15),
                  fontWeight: FontWeight.w500),
            ),
            // Transform.scale(
            //   scale: 1.08,
            //   child: CheckboxListTile(
            //       checkColor: AppColors.white,
            //       activeColor: AppColors.appTheme,
            //       contentPadding: EdgeInsets.zero,
            //       checkboxShape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(3),
            //       ),
            //       controlAffinity: ListTileControlAffinity.leading,
            //       title: const Text("Next Day National Courier Delivery"),
            //       value: controller.nextDay.value,
            //       onChanged: (v) {
            //         controller.nextDay.value = v!;
            //       }),
            // ),
            Transform.scale(
              scale: 0.8,
              alignment: Alignment.centerLeft,
              child: CheckboxListTile(
                  activeColor: AppColors.appTheme,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                      "Customer can select to have their order delevered to their home via a national courier service"),
                  value: controller.nextDaySub1.value,
                  onChanged: (v) {
                    controller.nextDaySub1.value = v!;
                    controller.update();
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: SizedBox(
                  child: CustomTextFieldWidget(
                    controller: controller.nextDayFeeController,
                    fillColor: AppColors.white,
                    prefixIconPadding:
                        const EdgeInsets.only(left: 15, right: 10),
                    obscureText: false,
                    hintText: "£ 30",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: AppColors.white)),
                  ),
                )),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                Text(
                  "Insert Delivery Fee",
                  style: urbanistRegular.copyWith(fontSize: 14),
                )
              ],
            ),

            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Text(
              "Home Delivery",
              style: TextStyle(
                  fontSize: getProportionalFontSize(15),
                  fontWeight: FontWeight.w500),
            ),
            // Transform.scale(
            //   scale: 1.08,
            //   child: CheckboxListTile(
            //       checkColor: AppColors.white,
            //       activeColor: AppColors.appTheme,
            //       contentPadding: EdgeInsets.zero,
            //       checkboxShape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(3),
            //       ),
            //       controlAffinity: ListTileControlAffinity.leading,
            //       title: const Text("Next Day National Courier Delivery"),
            //       value: controller.nextDay.value,
            //       onChanged: (v) {
            //         controller.nextDay.value = v!;
            //       }),
            // ),
            Transform.scale(
              scale: 0.8,
              alignment: Alignment.centerLeft,
              child: CheckboxListTile(
                  activeColor: AppColors.appTheme,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                      "Customer can opt to have their their order delivered to their home via your own delivery service"),
                  value: controller.homeDeliverySub1.value,
                  onChanged: (v) {
                    controller.homeDeliverySub1.value = v!;
                    controller.update();
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: SizedBox(
                  child: CustomTextFieldWidget(
                    controller: controller.homeDeliveryFeeController,
                    fillColor: AppColors.white,
                    prefixIconPadding:
                        const EdgeInsets.only(left: 15, right: 10),
                    obscureText: false,
                    hintText: "£ 30",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(color: AppColors.white)),
                  ),
                )),
                SizedBox(
                  width: getProportionateScreenWidth(8),
                ),
                Text(
                  "Insert Delivery Fee",
                  style: urbanistRegular.copyWith(fontSize: 14),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: CheckboxListTile(
                        activeColor: AppColors.appTheme,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Percents"),
                        value: controller.homeDeliveryPercentValue.value,
                        onChanged: (v) {
                          if (v != null && v == true) {
                            controller.homeDeliveryPerKmValue.value = false;
                          } else {
                            controller.homeDeliveryPerKmValue.value = false;
                          }
                          controller.homeDeliveryPercentValue.value = v!;
                          controller.update();
                        }),
                  ),
                ),
                Expanded(
                  child: Transform.scale(
                    scale: 0.8,
                    alignment: Alignment.centerLeft,
                    child: CheckboxListTile(
                        activeColor: AppColors.appTheme,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: const Text("Per Mile"),
                        value: controller.homeDeliveryPerKmValue.value,
                        onChanged: (v) {
                          if (v != null && v == true) {
                            controller.homeDeliveryPercentValue.value = false;
                          } else {
                            controller.homeDeliveryPercentValue.value = false;
                          }
                          controller.homeDeliveryPerKmValue.value = v!;
                          controller.update();
                        }),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget card(labelText, text, textController) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          labelText,
          style: beVietnamProExtraBold.copyWith(
              fontSize: 22, color: AppColors.appTheme),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: SizedBox(
              width: 120,
              child: CustomTextFieldWidget(
                controller: textController,
                fillColor: AppColors.white,
                prefixIconPadding: const EdgeInsets.only(left: 15, right: 10),
                obscureText: false,
                hintText: "£ 30",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: const BorderSide(color: AppColors.white)),
              ),
            )),
            SizedBox(
              width: 180,
              child: Text(
                text,
                style: urbanistRegular.copyWith(fontSize: 14),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
