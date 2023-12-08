import 'package:famooshed_vendor/app/modules/add_product_module/add_product_controller.dart';
import 'package:get/get.dart';

class AddProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}
