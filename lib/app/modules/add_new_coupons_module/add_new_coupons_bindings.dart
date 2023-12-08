import 'package:famooshed_vendor/app/modules/add_new_coupons_module/add_new_coupons_controller.dart';
import 'package:get/get.dart';

class AddNewCouponsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewCouponsController());
  }
}
