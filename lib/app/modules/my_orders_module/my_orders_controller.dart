import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../data/models/order_list_response.dart';

class MyOrdersController extends GetxController {
  @override
  void onReady() {
    orderList();
    super.onReady();
  }

  final _apiHelper = ApiHelper.to;

  // final RxList<Orders> _ordersList = RxList();
  // List<Orders> get ordersList => _ordersList;
  // set ordersList(List<Orders> orders) => _ordersList.addAll(orders);
  // getOrders() async {
  //   LoadingDialog.showLoadingDialog();
  //   try {
  //     Response response = await _apiHelper.postApi(AppUrl.getOrders, {});
  //     if (response.statusCode == 200) {
  //       ordersList.clear();
  //       GetOrdersResponse res = GetOrdersResponse.fromJson(response.body);
  //       if (res.error != null && res.error == '0') {
  //         if (res.data != null && res.data!.isNotEmpty) {
  //           ordersList.addAll(res.data!);
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     dprint(e);
  //
  //     LoadingDialog.closeLoadingDialog();
  //   }
  //   update();
  //   LoadingDialog.closeLoadingDialog();
  // }

  final RxList<Order> _order = RxList();
  List<Order> get order => _order;
  set order(List<Order> order) => _order.addAll(order);

  List<Order> searchOrderList = [];
  Order currentOrder = Order();

  List<OrderStatus> orderStatus = [];
  OrderStatus selectedStatus = OrderStatus();
  List<Driver> drivers = [];
  Driver selectedDriver = Driver();

  orderList() {
    var body = {"orders": "all"};
    _apiHelper.postApi(AppUrl.ordersList, body).futureValue(
      (value) {
        order.clear();
        orderStatus.clear();
        filterOrderStatusList.clear();
        drivers.clear();
        try {
          var response = OrderResponse.fromJson(value);
          order = response.orders ?? [];
          orderStatus = response.orderStatus ?? [];

          filterOrderStatusList.add(OrderStatus(
            id: 0,
            status: "Select Status",
          ));
          filterOrderStatusList.addAll(response.orderStatus ?? []);
          filterStatus = filterOrderStatusList[0];
          drivers = response.drivers ?? [];
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }

        update();
      },
      retryFunction: orderList,
    );
  }

  TextEditingController searchController = TextEditingController();
  filterOrderList() async {
    Response value = await _apiHelper.postApi(AppUrl.ordersGoPage,
        {"search": searchController.text, "cat": filterStatus.id});
    print(value);
    order.clear();
    if (value.body['error'] == '0') {
      if (value.body['orders'] != null) {
        List data = value.body['orders'];
        if (data.isNotEmpty) {
          data.forEach((element) {
            order.add(Order.fromJson(element));
          });
        }
      }
    }
    update();
  }

  changeOrderStatus() {
    var body = {"id": currentOrder.id, "status": selectedStatus.id};
    _apiHelper.postApi(AppUrl.changeOrderStatus, body).futureValue(
      (value) {
        try {
          print(value);
          if (value['error'] == '0') {
            Get.back();
            orderList();
            update();
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: changeOrderStatus,
    );
  }

  changeDriverStatus() {
    var body = {"id": currentOrder.id, "driver": selectedDriver.id};
    _apiHelper.postApi(AppUrl.changeDriver, body).futureValue(
      (value) {
        try {
          print(value);
          if (value['error'] == '0') {
            Get.back();
            orderList();
            update();
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }
      },
      retryFunction: changeDriverStatus,
    );
  }

  getStatus(int status) {
    String statusName = 'Received';
    orderStatus.forEach((element) {
      if (element.id != null && element.id == status) {
        statusName = element.status ?? 'Received';
      }
    });

    return statusName;
  }

  getDriver(int id) {
    String driverName = '-';
    drivers.forEach((element) {
      if (element.id != null && element.id == id) {
        driverName = element.name ?? '-';
      }
    });

    return driverName;
  }

  List<OrderStatus> filterOrderStatusList = [];
  OrderStatus filterStatus = OrderStatus();
  //
  // RxBool isSearch = RxBool(false);
  // void getResultList(String? text) {
  //   searchOrderList.clear();
  //   if (filterStatus.id != null && filterStatus.id != -1) {
  //     List<Order> orders =
  //         order.where((element) => element.status == filterStatus.id).toList();
  //
  //     if (text != null && text.isNotEmpty) {
  //       orders.forEach((element) {
  //         if (element.userName != null && element.userName!.isNotEmpty) {
  //           if (element.userName!.toUpperCase().contains(text) ||
  //               element.userName!.toLowerCase().contains(text)) {
  //             searchOrderList.add(element);
  //           }
  //         }
  //       });
  //     } else {
  //       isSearch.value = true;
  //       searchOrderList.addAll(orders);
  //     }
  //     update();
  //   } else {
  //     if (text != null && text.isNotEmpty) {
  //       order.forEach((element) {
  //         if (element.userName != null && element.userName!.isNotEmpty) {
  //           if (element.userName!.toUpperCase().contains(text) ||
  //               element.userName!.toLowerCase().contains(text)) {
  //             searchOrderList.add(element);
  //           }
  //         }
  //       });
  //     }
  //   }
  //   update();
  // }
}
