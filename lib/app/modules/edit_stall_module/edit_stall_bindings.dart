import 'package:get/get.dart';

import 'edit_stall_controller.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class EditStallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditStallController(), fenix: true);
  }
}
