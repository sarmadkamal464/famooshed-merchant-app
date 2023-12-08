import 'package:famooshed_vendor/app/modules/wallet_module/wallet_controller.dart';
import 'package:get/get.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class WalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
  }
}
