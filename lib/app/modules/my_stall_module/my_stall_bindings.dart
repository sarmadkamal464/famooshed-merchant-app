import 'package:famooshed_vendor/app/modules/my_stall_module/my_stall_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class MyStallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyStallController(),
    );
  }
}
