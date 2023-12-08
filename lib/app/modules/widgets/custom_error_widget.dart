import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;

  const CustomErrorWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: kDebugMode
            ? Text(
                message ?? Strings.somethingWentWrong,
                style: Get.textTheme.headlineSmall,
              )
            : SizedBox(),
      ),
    );
  }
}
