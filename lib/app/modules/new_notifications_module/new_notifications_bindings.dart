import 'package:famooshed_vendor/app/modules/new_notifications_module/new_notifications_controller.dart';
import 'package:get/get.dart';

class NewNotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewNotificationsController(), fenix: true);
  }
}
