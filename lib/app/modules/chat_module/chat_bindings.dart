import 'package:famooshed_vendor/app/modules/chat_module/chat_controller.dart';
import 'package:get/get.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController(), fenix: true);
  }
}
