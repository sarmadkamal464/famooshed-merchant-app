import 'package:famooshed_vendor/app/modules/my_categories_module/my_categories_controller.dart';
import 'package:get/get.dart';

class MyCategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyCategoriesController(), fenix: true);
  }
}
