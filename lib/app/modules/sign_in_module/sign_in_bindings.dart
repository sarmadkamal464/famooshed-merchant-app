import 'package:famooshed_vendor/app/modules/sign_in_module/sign_in_controller.dart';
import 'package:get/get.dart';

import '../../data/api_helper.dart';
import '../../data/api_helper_impl.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut<ApiHelper>(
      () => ApiHelperImpl(),
    );
  }
}
