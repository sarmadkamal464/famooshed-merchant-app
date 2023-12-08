import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../../common/util/exports.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Function()? onTap;
  const DefaultButton(
      {Key? key,
      required this.buttonText,
      this.width,
      this.height,
      this.backgroundColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: backgroundColor ?? AppColors.buttonColor),
        child: Center(
          child: Text(
            buttonText,
            style: urbanistBold.copyWith(
                fontSize: Dimens.fontSize18, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
