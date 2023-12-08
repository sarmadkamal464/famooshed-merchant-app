import 'package:get/get.dart';

import 'add_edit_food_management_controller.dart';

class AddEditFoodManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEditFoodManagementController());
  }
}
