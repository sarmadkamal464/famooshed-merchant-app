import 'package:famooshed_vendor/app/modules/add_new_driver_module/add_new_driver_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddNewDriverBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewDriverController());
  }
}