import 'package:famooshed_vendor/app/modules/edit_information_module/edit_information_controller.dart';
import 'package:get/get.dart';

class EditInformationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditInformationController());
  }
}
