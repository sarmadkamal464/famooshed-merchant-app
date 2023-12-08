import 'package:famooshed_vendor/app/modules/over_view_module/over_view_controller.dart';
import 'package:get/get.dart';

class OverViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OverViewController(), fenix: true);
  }
}
