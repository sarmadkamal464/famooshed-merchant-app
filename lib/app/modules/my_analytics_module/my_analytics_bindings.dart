import 'package:famooshed_vendor/app/modules/my_analytics_module/my_analytics_controller.dart';
import 'package:get/get.dart';

class MyAnalyticsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => MyAnalyticsController(),
    );
  }
}
