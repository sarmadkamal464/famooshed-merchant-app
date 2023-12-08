import 'package:famooshed_vendor/app/modules/add_categories_module/add_categories_controller.dart';
import 'package:get/get.dart';

class AddCategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddCategoriesController());
  }
}
