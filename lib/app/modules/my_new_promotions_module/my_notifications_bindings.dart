import 'package:famooshed_vendor/app/modules/my_new_promotions_module/my_notifications_controller.dart';
import 'package:get/get.dart';

class MyNotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyNotificationsController(),
    );
  }
}
