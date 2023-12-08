import 'dart:developer';

import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/api_helper.dart';
import 'package:famooshed_vendor/app/data/models/order_list_response.dart';
import 'package:get/get.dart';

class OverViewController extends GetxController {
  @override
  void onReady() {
    // getMyStall();
    orderList();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  dynamic args = Get.arguments;

  RxString earning = "".obs;
  RxString currency = "".obs;
  RxString totalEarnings = "".obs;
  RxString totalOrders = "".obs;
  RxString totalUsers = "".obs;

  final _apiHelper = ApiHelper.to;
  RxString userName = "".obs;
  RxString email = "".obs;
  RxString image = "".obs;

  final RxList<Order> _order = RxList();
  List<Order> get order => _order;
  set order(List<Order> order) => _order.addAll(order);

  double e1 = 0;
  double e2 = 0;
  double e3 = 0;
  double e4 = 0;
  double e5 = 0;
  double e6 = 0;
  double e7 = 0;
  double e8 = 0;
  double e9 = 0;
  double e10 = 0;
  double e11 = 0;
  double e12 = 0;
  List<OrderStatus> orderStatus = [];
  orderList() {
    _apiHelper.postApi(AppUrl.ordersList, {}).futureValue(
      (value) {
        try {
          var response = OrderResponse.fromJson(value);

          currency.value = response.currency ?? '£';
          earning.value = (response.earning ?? 0).toStringAsFixed(2);
          totalEarnings.value =
              currency.value + (response.earning ?? 0).toStringAsFixed(2);
          order = response.orders ?? [];
          orderStatus = response.orderStatus ?? [];
          totalOrders.value = response.ordersCount.toString();
          totalUsers.value = response.userCount.toString();
          e1 = response.e1 ?? 0;
          e2 = response.e2 ?? 0;
          e3 = response.e3 ?? 0;
          e4 = response.e4 ?? 0;
          e5 = response.e5 ?? 0;
          e6 = response.e6 ?? 0;
          e7 = response.e7 ?? 0;
          e8 = response.e8 ?? 0;
          e9 = response.e9 ?? 0;
          e10 = response.e10 ?? 0;
          e11 = response.e11 ?? 0;
          e12 = response.e12 ?? 0;
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
        update();
      },
      retryFunction: orderList,
    );
  }

  // getMyStall() {
  //   _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
  //     (value) {
  //       try {
  //         var response = GetMyStallResponse.fromJson(value);
  //
  //         Storage.saveValue(Constants.restId, response.restaurants[0].id);
  //         userName.value = response.restaurants[0].name;
  //         email.value = response.restaurants[0].email ?? "";
  //         image.value = Constants.imgUrl + response.restaurants[0].images;
  //       } catch (e, trace) {
  //         log(e.toString(), stackTrace: trace);
  //       }
  //
  //       update();
  //     },
  //     retryFunction: getMyStall,
  //   );
  // }

  getStatus(int status) {
    String statusName = 'Received';
    orderStatus.forEach((element) {
      if (element.id != null && element.id == status) {
        statusName = element.status ?? 'Received';
      }
    });

    return statusName;
  }
}
