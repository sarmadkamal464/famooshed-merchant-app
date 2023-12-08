import 'package:famooshed_vendor/app/modules/food_management_module/food_management_controller.dart';
import 'package:get/get.dart';

class FoodManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodManagementController(), fenix: true);
  }
}
