import 'package:famooshed_vendor/app/modules/my_drivers_module/my_drivers_controller.dart';
import 'package:get/get.dart';

class MyDriversBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyDriversController());
  }
}
