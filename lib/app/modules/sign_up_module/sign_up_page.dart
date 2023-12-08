import 'package:famooshed_vendor/app/common/util/validators.dart';
import 'package:famooshed_vendor/app/modules/sign_up_module/sign_up_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../libraries/custom_dropdown/dropdown_textfield.dart';
import '../../common/util/exports.dart';
import '../../theme/size_config.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: AppColors.appTheme))),
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder(
        builder: (SignUpController signUpController) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .01),
                child: Form(
                  key: signUpController.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(AppImages.famooshedLogo),
                      SizedBox(height: Get.height * .01),
                      Text("Sign Up",
                          style: beVietnamProBold.copyWith(
                              fontSize: getProportionalFontSize(25),
                              color: AppColors.appTheme)),
                      SizedBox(height: Get.height * .02),
                      Container(
                        // margin:
                        //     EdgeInsets.symmetric(horizontal: Get.width * .02),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.appTheme),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(18),
                              vertical: getProportionateScreenHeight(32)),
                          child: Column(children: [
                            customInputField(
                                "Full Name",
                                "Michal Johnson",
                                false,
                                signUpController.nameController,
                                (value) => Validators.validateEmpty(value)
                                // Validators.validateEmail,
                                ),
                            SizedBox(height: Get.height * .03),
                            customInputField(
                                "Phone Number",
                                "0000 000 0000",
                                false,
                                signUpController.phoneController,
                                (value) => Validators.validatePhone(value)
                                // Validators.validatePassword,
                                ),
                            SizedBox(height: Get.height * .03),
                            customInputField(
                                "Email",
                                "michal@domain.com",
                                false,
                                signUpController.emailController,
                                (value) => Validators.validateEmail(value)
                                // Validators.validatePassword,
                                ),
                            SizedBox(height: Get.height * .03),
                            customInputField(
                                "Password",
                                "Enter Password",
                                true,
                                signUpController.passController,
                                (value) => Validators.validatePassword(value)
                                // Validators.validatePassword,
                                ),
                            SizedBox(height: Get.height * .03),
                            customInputField(
                                "Confirm Password",
                                "Enter Password",
                                true,
                                signUpController.confirmController,
                                (value) => Validators.validatePassword(value)
                                // Validators.validatePassword,
                                ),
                            SizedBox(height: Get.height * .03),
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
                                      top: getProportionateScreenHeight(25),
                                      bottom: getProportionateScreenHeight(25),
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
                              dropDownList: signUpController.stallCategoryList
                                  .map((e) =>
                                      DropDownValueModel(value: e, name: e))
                                  .toList(),
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
                            SizedBox(height: Get.height * .04),
                            DefaultButton(
                              buttonText: Strings.createAcc,
                              width: 180,
                              height: 50,
                              onTap: () {
                                signUpController.register();
                              },
                            )
                          ]),
                        ),
                      ),
                      SizedBox(height: Get.height * .03),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                style: urbanistMedium.copyWith(
                                    fontSize: getProportionalFontSize(14),
                                    color: "#697A70".fromHex),
                                text:
                                    "By Clicking “Sign Up” You certify that you agree to our ",
                                children: [
                                  TextSpan(
                                      text: "Privacy Policy ",
                                      style: urbanistBold.copyWith(
                                          fontSize: getProportionalFontSize(14),
                                          color: "#215034".fromHex),
                                      children: [
                                        TextSpan(
                                            text: "and",
                                            style: urbanistMedium.copyWith(
                                                fontSize:
                                                    getProportionalFontSize(14),
                                                color: "#697A70".fromHex),
                                            children: [
                                              TextSpan(
                                                text: " Terms & Conditions",
                                                style: urbanistBold.copyWith(
                                                    fontSize:
                                                        getProportionalFontSize(
                                                            14),
                                                    color: "#215034".fromHex),
                                              )
                                            ])
                                      ])
                                ])
                          ])),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget customInputField(text, hintText, obscureText, textContoller,
      FormFieldValidator<String?>? validator) {
    return Container(
      height: getProportionateScreenHeight(72),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0), color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(5),
                  left: getProportionateScreenWidth(10),
                  bottom: 0.0),
              child: Text(text,
                  style: urbanistSemiBold.copyWith(
                      fontSize: getProportionalFontSize(16),
                      color: AppColors.appTheme))),
          ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: CustomTextFieldWidget(
                obscureText: obscureText,
                controller: textContoller,
                hintText: hintText,
                validator: validator,
                hintStyle: urbanistMedium.copyWith(
                    fontSize: getProportionalFontSize(14),
                    color: AppColors.appThemeGrey),
                fillColor: AppColors.white,
                border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
