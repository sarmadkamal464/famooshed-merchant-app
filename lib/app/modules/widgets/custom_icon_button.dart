import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../../common/util/exports.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color? buttonColor;
  final double? width;
  final Widget? prefixImg;
  final Color textColor;
  final String logo;
  const CustomIconButtonWidget(
      {Key? key,
      this.prefixImg,
      required this.text,
      required this.color,
      this.buttonColor,
      this.width,
      required this.textColor,
      required this.logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: SizedBox(
        width: width,
        height: 60,
        child: Row(
          children: [
            Container(
              color: color,
              height: 60,
              width: width! * .25,
              child: Image.asset(logo),
            ),
            Container(
              color: buttonColor,
              height: 60,
              width: width! * .75,
              child: Center(
                child: Text(
                  text,
                  style: urbanistBold.copyWith(color: textColor, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  //   return Container(
  //     width: width,
  //     height: 60,
  //     decoration: BoxDecoration(
  //         color: buttonColor, borderRadius: BorderRadius.circular(30.0)),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Container(
  //             height: 60,
  //             width: 60,
  //             color: Colors.white,
  //             child: Image.asset(AppImages.googleLogo)),
  // Text(
  //   text,
  //   style: textStyle(color),
  //   textAlign: TextAlign.center,
  // ),
  //       ],
  //     ),
  //   );
  // }

  textStyle(color) {
    return TextStyle(
        color: color, fontSize: Dimens.fontSize14, fontWeight: FontWeight.w500);
  }
}
