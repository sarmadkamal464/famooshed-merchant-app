import 'package:flutter/cupertino.dart';
import 'package:famooshed_vendor/app/data/errors/api_error.dart';
import 'package:get/get.dart';

class ApiInterfaceController extends GetxController {
  ApiError? error;

  VoidCallback? retry;

  void onRetryTap() {
    error = null;
    retry?.call();
    update();
  }
}
