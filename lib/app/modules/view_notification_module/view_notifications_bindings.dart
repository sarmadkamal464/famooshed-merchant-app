import 'package:famooshed_vendor/app/modules/view_notification_module/view_notifications_controller.dart';
import 'package:get/get.dart';

class ViewNotificationsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ViewNotificationsController(),
    );
  }
}
