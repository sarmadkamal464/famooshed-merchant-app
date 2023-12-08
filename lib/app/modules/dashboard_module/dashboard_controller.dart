import 'dart:developer';

import 'package:famooshed_vendor/app/modules/chat_module/chat_controller.dart';
import 'package:famooshed_vendor/app/modules/food_management_module/food_management_bindings.dart';
import 'package:famooshed_vendor/app/modules/food_management_module/food_management_page.dart';
import 'package:famooshed_vendor/app/modules/my_new_promotions_module/my_notifications_bindings.dart';
import 'package:famooshed_vendor/app/modules/my_new_promotions_module/my_notifications_controller.dart';
import 'package:famooshed_vendor/app/modules/my_new_promotions_module/my_notifications_page.dart';
import 'package:famooshed_vendor/app/modules/my_orders_module/my_orders_bindings.dart';
import 'package:famooshed_vendor/app/modules/my_orders_module/my_orders_controller.dart';
import 'package:famooshed_vendor/app/modules/over_view_module/over_view_bindings.dart';
import 'package:famooshed_vendor/app/modules/over_view_module/over_view_controller.dart';
import 'package:famooshed_vendor/app/modules/over_view_module/over_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';
import '../../common/util/exports.dart';
import '../../common/values/app_url.dart';
import '../../data/api_helper.dart';
import '../../data/models/my_stall_response.dart';
import '../chat_module/chat_bindings.dart';
import '../chat_module/chat_page.dart';
import '../food_management_module/food_management_controller.dart';
import '../my_orders_module/my_orders_page.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class DashboardController extends GetxController {
  @override
  void onReady() {
    getMyStall();
    super.onReady();
  }

  var currentIndex = 0.obs;
  RxString appBarTitle = "".obs;
  getAppTitle() {
    return pagesTitle[currentIndex.value];
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/overview') {
      return GetPageRoute(
        settings: settings,
        // transition: Transition.fadeIn,
        page: () => OverViewPage(isHideAppBar: true),
        binding: OverViewBinding(),
      );
    }

    if (settings.name == '/food management') {
      return GetPageRoute(
        settings: settings,
        page: () => FoodManagementPage(isHideAppBar: true),
        binding: FoodManagementBinding(),
      );
    }

    if (settings.name == '/notification') {
      return GetPageRoute(
        settings: settings,
        page: () => MyNotificationsPage(isHideAppBar: true),
        binding: MyNotificationsBinding(),
      );
    }

    if (settings.name == '/orders') {
      return GetPageRoute(
        settings: settings,
        // parameter: {"isShoAppBar": "Yes"},
        // page: () => MyCategoriesPage(isHideAppBar: true),
        // binding: MyCategoriesBinding(),
        page: () => MyOrdersPage(isHideAppBar: true),
        binding: MyOrdersBinding(),
      );
    }
    if (settings.name == '/chat') {
      return GetPageRoute(
        settings: settings,
        page: () => ChatPage(isHideAppBar: true),
        binding: ChatBinding(),
      );
    }

    return null;
  }

  void changePage(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
      if (index == 0) {
        OverViewController().onReady();
      } else if (index == 1) {
        FoodManagementController().onReady();
      } else if (index == 2) {
        MyNotificationsController().onReady();
      } else if (index == 3) {
        MyOrdersController().onReady();
      } else if (index == 4) {
        ChatController().onReady();
      }
      Get.toNamed(
        pages[index],
        id: 1,
      );
      update();
    }
  }

  final iconLinearGradiant = List<Color>.from([
    const Color.fromARGB(255, 251, 2, 197),
    const Color.fromARGB(255, 72, 3, 80)
  ]);

  final pages = <String>[
    '/overview',
    '/food management',
    '/notification',
    '/orders',
    '/chat'
  ];
  final pagesTitle = <String>[
    'Overview',
    'My Products',
    'Notifications',
    'My Orders',
    'Chat'
  ];

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  final _apiHelper = ApiHelper.to;
  RxString userName = "".obs;
  RxString email = "".obs;
  RxString image = "".obs;

  getMyStall() {
    _apiHelper.postApi(AppUrl.restaurantsList, {}).futureValue(
      (value) {
        try {
          var response = GetMyStallResponse.fromJson(value);

          if (response.restaurants.isNotEmpty) {
            Storage.saveValue(Constants.restId, response.restaurants[0].id);
            userName.value = response.restaurants[0].name ?? '-';
            email.value = response.restaurants[0].email ?? '-';
            image.value = (response.restaurants[0].images != null
                ? Constants.imgUrl + response.restaurants[0].images!
                : 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80');
          }
        } catch (e, trace) {
          log(e.toString(), stackTrace: trace);
        }

        update();
      },
      retryFunction: getMyStall,
    );
  }
}
