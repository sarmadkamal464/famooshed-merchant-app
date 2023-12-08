import 'package:famooshed_vendor/app/modules/my_promotions_module/my_promotions_controller.dart';
import 'package:get/get.dart';

class MyPromotionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPromotionsController());
  }
}
