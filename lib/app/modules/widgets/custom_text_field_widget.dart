import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? labelText, hintText;
  final String? initialValue, prefixText, suffixText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged, onSaved;
  final int? maxLength, maxLines;
  final int minLines;
  final bool readOnly, addHint, enabled;
  final bool? isDense, obscureText;
  final Function()? onTap;
  final InputBorder? border;
  final TextStyle? hintStyle;
  final AutovalidateMode autovalidateMode;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? prefixIconPadding;
  final Color? fillColor;
  final TextAlign? textAlign;

  const CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.initialValue,
    this.readOnly = false,
    this.onTap,
    this.border,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.addHint = false,
    this.suffixIconConstraints,
    this.prefixText,
    this.suffixText,
    this.isDense,
    this.prefixIconPadding,
    this.fillColor,
    this.hintStyle,
    this.obscureText,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle.regularStyle.copyWith(
      color: AppColors.mineShaft,
      fontSize: Dimens.fontSize15,
    );

    return TextFormField(
      // textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign!,
      obscureText: obscureText!,
      onTap: onTap,
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      onSaved: onSaved,
      enabled: enabled,
      inputFormatters: maxLength == null
          ? null
          : [
              LengthLimitingTextInputFormatter(maxLength),
              if (keyboardType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly,
            ],

      decoration: InputDecoration(
        hintStyle: hintStyle,

        fillColor: fillColor,
        filled: fillColor != null,
        isDense: isDense,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        // alignLabelWithHint: maxLines == null,
        labelText: addHint
            ? null
            : ((controller?.text != null || !readOnly) ? labelText : null),
        hintText: hintText,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40.h,
          maxWidth: 40.w,
        ),
        prefixIcon: prefixIcon == null
            ? null
            : Padding(
                padding: prefixIconPadding ?? EdgeInsets.only(right: 10.w),
                child: prefixIcon,
              ),
        prefixText: prefixText,
        suffixText: suffixText,
        prefixStyle: textStyle,
        suffixStyle: textStyle,
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: suffixIcon,
              ),
        suffixIconConstraints: suffixIconConstraints ??
            BoxConstraints(
              maxHeight: 44.h,
              maxWidth: 40.w,
            ),
      ),
    );
  }
}
