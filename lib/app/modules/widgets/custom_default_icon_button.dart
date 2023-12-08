import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/util/exports.dart';

class DefaultIconButton extends StatelessWidget {
  final String buttonText;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Function()? onTap;

  const DefaultIconButton(
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
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor ?? AppColors.buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/add_logo.svg"),
            const SizedBox(width: 20),
            Text(
              buttonText,
              style:
                  urbanistBold.copyWith(fontSize: 18, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
