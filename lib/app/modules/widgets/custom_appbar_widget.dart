import 'package:famooshed_vendor/app/modules/widgets/custom_back_button.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/util/exports.dart';

class CustomAppbarWidget extends PreferredSize {
  final String? title;
  final Color? backgroundColor, backbuttonColor, textColor, statusBarColor;
  final TextStyle? textStyle;
  final List<Widget>? actions;
  final Function()? onActionButtonTap, onBackPress;
  final double? actionButtonWidth;
  final Widget? titleWidget, leading, bottom;
  final bool addBackButton;
  final bool? centerTitle;

  CustomAppbarWidget(
      {Key? key,
      this.title,
      this.titleWidget,
      this.leading,
      this.addBackButton = true,
      this.onBackPress,
      this.backgroundColor,
      this.backbuttonColor = Colors.white,
      this.textColor,
      this.textStyle,
      this.actions,
      this.onActionButtonTap,
      this.actionButtonWidth = 100,
      this.bottom,
      this.centerTitle,
      this.statusBarColor})
      : assert(
          textColor == null || textStyle == null,
          'Cannot provide both a textColor and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(color: color)".',
        ),
        super(
          key: key,
          child: const SizedBox.shrink(),
          preferredSize:
              Size.fromHeight(bottom == null ? kToolbarHeight : 98.h),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: centerTitle,
      elevation: 0,
      actions: actions,
      actionsIconTheme: IconThemeData(size: 20.w, color: AppColors.appTheme),
      bottom: bottom == null
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: bottom!,
            ),
      leading: addBackButton
          ? CustomBackButton(
              leading: leading,
              onBackTap: onBackPress,
              backbuttonColor: AppColors.appTheme,
            )
          : leading,
      leadingWidth: 45.w,
      backgroundColor: backgroundColor ?? AppColors.white,
      title: title == null
          ? (titleWidget ?? const SizedBox.shrink())
          : Text(
              title!,
              style: beVietnamProBold.copyWith(
                  color: AppColors.appTheme, fontSize: 24),
            ),
    );
  }
}
