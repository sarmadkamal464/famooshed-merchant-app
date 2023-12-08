import 'package:get/get.dart';

import 'my_profile_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyProfileController(), fenix: true);
  }
}
