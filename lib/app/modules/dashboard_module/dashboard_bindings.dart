import 'package:get/get.dart';

import '../../data/api_helper.dart';
import '../../data/api_helper_impl.dart';
import '../chat_module/chat_controller.dart';
import '../food_management_module/food_management_controller.dart';
import '../my_categories_module/my_categories_controller.dart';
import '../my_new_promotions_module/my_notifications_controller.dart';
import '../my_stall_module/my_stall_controller.dart';
import '../over_view_module/over_view_controller.dart';
import 'dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiHelper>(
      () => ApiHelperImpl(),
    );
    //
    // Get.lazyPut<ApiInterfaceController>(
    //   () => ApiInterfaceController(),
    // );
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => OverViewController(), fenix: true);
    Get.put(() => MyNotificationsController(), permanent: true);
    Get.lazyPut(() => FoodManagementController(), fenix: true);
    Get.lazyPut(() => MyCategoriesController(), fenix: true);
    Get.lazyPut(() => MyStallController(), fenix: true);
    Get.lazyPut(() => ChatController(), fenix: true);
  }
}
