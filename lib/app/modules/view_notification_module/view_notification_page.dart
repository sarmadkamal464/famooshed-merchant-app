import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/modules/view_notification_module/view_notifications_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/util/exports.dart';

class ViewNotificationsPage extends GetView<ViewNotificationsController> {
  const ViewNotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "Notification",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder<ViewNotificationsController>(
          builder: (controller) => SingleChildScrollView(
            child: controller.notificationDataItem.id != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Notification ID",
                            style: beVietnamProExtraBold.copyWith(
                                color: AppColors.appTheme, fontSize: 22)),
                        Text("#${controller.notificationDataItem.id}",
                            style: urbanistSemiBold.copyWith(
                                fontSize: 14, color: AppColors.appTheme)),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(12),
                              vertical: getProportionateScreenHeight(12)),
                          decoration:
                              BoxDecoration(color: AppColors.lightGreen),
                          child: Column(
                            children: [
                              Container(
                                height: SizeConfig.deviceHeight! * .25,
                                padding: EdgeInsets.symmetric(
                                    vertical: 28, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: CachedNetworkImageProvider(
                                      Constants.imgUrl +
                                          controller
                                              .notificationDataItem.imageName!,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(16),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Title: ",
                                    style: beVietnamProExtraBold.copyWith(
                                      color: AppColors.black,
                                      fontSize: getProportionalFontSize(14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${controller.notificationDataItem.title ?? '-'}",
                                      style: beVietnamProMedium.copyWith(
                                        color: AppColors.black,
                                        fontSize: getProportionalFontSize(14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(8),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Message: ",
                                    style: beVietnamProExtraBold.copyWith(
                                      color: AppColors.black,
                                      fontSize: getProportionalFontSize(14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${controller.notificationDataItem.text ?? '-'}",
                                      style: beVietnamProMedium.copyWith(
                                        color: AppColors.black,
                                        fontSize: getProportionalFontSize(14),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
          ),
        ));
  }
}
