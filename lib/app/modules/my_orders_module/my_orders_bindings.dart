import 'package:famooshed_vendor/app/modules/my_orders_module/my_orders_controller.dart';
import 'package:get/get.dart';

class MyOrdersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrdersController());
  }
}
