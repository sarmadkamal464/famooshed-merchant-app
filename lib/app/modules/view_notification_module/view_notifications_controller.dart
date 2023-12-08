import 'package:famooshed_vendor/app/data/models/get_notification_response.dart';
import 'package:get/get.dart';

class ViewNotificationsController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  NotoficationDataItem notificationDataItem = NotoficationDataItem();

  @override
  void onInit() {
    var args = Get.arguments as NotoficationDataItem;
    notificationDataItem = args;
    update();
    super.onInit();
  }
}
