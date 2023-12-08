import 'package:famooshed_vendor/app/modules/add_edit_food_management_module/add_edit_food_management_page.dart';
import 'package:famooshed_vendor/app/modules/chat_module/chat_bindings.dart';
import 'package:famooshed_vendor/app/modules/chat_module/chat_message_page.dart';
import 'package:famooshed_vendor/app/modules/chat_module/chat_page.dart';
import 'package:famooshed_vendor/app/modules/edit_stall_module/edit_stall_bindings.dart';
import 'package:famooshed_vendor/app/modules/edit_stall_module/edit_stall_page.dart';
import 'package:famooshed_vendor/app/modules/home/bindings/home_binding.dart';
import 'package:famooshed_vendor/app/modules/home/views/home_view.dart';
import 'package:famooshed_vendor/app/modules/my_orders_module/order_details_page.dart';
import 'package:famooshed_vendor/app/modules/my_profile_module/my_profile_bindings.dart';
import 'package:famooshed_vendor/app/modules/my_profile_module/my_profile_page.dart';
import 'package:famooshed_vendor/app/modules/view_notification_module/view_notifications_bindings.dart';
import 'package:get/get.dart';

import '../../app/modules/add_categories_module/add_categories_bindings.dart';
import '../../app/modules/add_categories_module/add_categories_page.dart';
import '../../app/modules/add_new_coupons_module/add_new_coupons_bindings.dart';
import '../../app/modules/add_new_coupons_module/add_new_coupons_page.dart';
import '../../app/modules/add_new_driver_module/add_new_driver_bindings.dart';
import '../../app/modules/add_new_driver_module/add_new_driver_page.dart';
import '../../app/modules/add_product_module/add_product_bindings.dart';
import '../../app/modules/add_product_module/add_product_page.dart';
import '../../app/modules/dashboard_module/dashboard_bindings.dart';
import '../../app/modules/dashboard_module/dashboard_page.dart';
import '../../app/modules/edit_information_module/edit_information_bindings.dart';
import '../../app/modules/edit_information_module/edit_information_page.dart';
import '../../app/modules/food_management_module/food_management_bindings.dart';
import '../../app/modules/food_management_module/food_management_page.dart';
import '../../app/modules/my_analytics_module/my_analytics_bindings.dart';
import '../../app/modules/my_analytics_module/my_analytics_page.dart';
import '../../app/modules/my_categories_module/my_categories_bindings.dart';
import '../../app/modules/my_categories_module/my_categories_page.dart';
import '../../app/modules/my_drivers_module/my_drivers_bindings.dart';
import '../../app/modules/my_drivers_module/my_drivers_page.dart';
import '../../app/modules/my_new_promotions_module/my_notifications_bindings.dart';
import '../../app/modules/my_new_promotions_module/my_notifications_page.dart';
import '../../app/modules/my_orders_module/my_orders_bindings.dart';
import '../../app/modules/my_orders_module/my_orders_page.dart';
import '../../app/modules/my_promotions_module/my_promotions_bindings.dart';
import '../../app/modules/my_promotions_module/my_promotions_page.dart';
import '../../app/modules/my_stall_module/my_stall_bindings.dart';
import '../../app/modules/my_stall_module/my_stall_page.dart';
import '../../app/modules/new_notifications_module/new_notifications_bindings.dart';
import '../../app/modules/new_notifications_module/new_notifications_page.dart';
import '../../app/modules/over_view_module/over_view_bindings.dart';
import '../../app/modules/over_view_module/over_view_page.dart';
import '../../app/modules/sign_in_module/sign_in_bindings.dart';
import '../../app/modules/sign_in_module/sign_in_page.dart';
import '../../app/modules/sign_up_module/sign_up_bindings.dart';
import '../../app/modules/sign_up_module/sign_up_page.dart';
import '../../app/modules/wallet_module/wallet_bindings.dart';
import '../../app/modules/wallet_module/wallet_page.dart';
import '../modules/add_edit_food_management_module/add_edit_food_management_bindings.dart';
import '../modules/dashboard_module/order_track.dart';
import '../modules/view_notification_module/view_notification_page.dart';

part 'app_routes.dart';

abstract class AppPages {
  const AppPages._();

  // static const INITIAL = Routes.MY_ORDERS;
  static const INITIAL = Routes.SIGN_IN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.OVER_VIEW,
      page: () => OverViewPage(isHideAppBar: false),
      binding: OverViewBinding(),
    ),
    GetPage(
      name: Routes.WALLET,
      page: () => const WalletPage(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.MY_STALL,
      page: () => MyStallPage(isHideAppBar: false),
      binding: MyStallBinding(),
    ),
    GetPage(
      name: Routes.FOOD_MANAGEMENT,
      page: () => FoodManagementPage(isHideAppBar: false),
      binding: FoodManagementBinding(),
    ),
    GetPage(
      name: Routes.EDIT_FOOD_MANAGEMENT,
      page: () => AddEditFoodPage(),
      binding: AddEditFoodManagementBinding(),
    ),
    GetPage(
      name: Routes.ADD_PRODUCT,
      page: () => const AddProductPage(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: Routes.MY_CATEGORIES,
      page: () => MyCategoriesPage(isHideAppBar: false),
      binding: MyCategoriesBinding(),
    ),
    GetPage(
      name: Routes.ADD_CATEGORIES,
      page: () => const AddCategoriesPage(),
      binding: AddCategoriesBinding(),
    ),
    GetPage(
      name: Routes.EDIT_INFORMATION,
      page: () => const EditInformationPage(),
      binding: EditInformationBinding(),
    ),
    GetPage(
      name: Routes.MY_ORDERS,
      page: () => MyOrdersPage(isHideAppBar: false),
      binding: MyOrdersBinding(),
    ),
    GetPage(
      name: Routes.MY_DRIVERS,
      page: () => MyDriversPage(),
      binding: MyDriversBinding(),
    ),
    GetPage(
      name: Routes.MY_ANALYTICS,
      page: () => const MyAnalyticsPage(),
      binding: MyAnalyticsBinding(),
    ),
    GetPage(
      name: Routes.MY_PROMOTIONS,
      page: () => const MyPromotionsPage(),
      binding: MyPromotionsBinding(),
    ),
    GetPage(
      name: Routes.MY_NEW_PROMOTIONS,
      page: () => MyNotificationsPage(isHideAppBar: false),
      binding: MyNotificationsBinding(),
    ),
    GetPage(
      name: Routes.ADD_NEW_COUPONS,
      page: () => const AddNewCouponsPage(),
      binding: AddNewCouponsBinding(),
    ),
    GetPage(
      name: Routes.NEW_NOTIFICATIONS,
      page: () => const NewNotificationsPage(),
      binding: NewNotificationsBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.ADD_NEW_DRIVER,
      page: () => AddNewDriverPage(),
      binding: AddNewDriverBinding(),
    ),
    GetPage(
      name: Routes.MAP_SCREEN,
      page: () => MapTrackingScreen(),
      // binding: AddNewDriverBinding(),
    ),
    GetPage(
      name: Routes.CHAT_SCREEN,
      page: () => ChatPage(isHideAppBar: false),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.CHAT_MESSAGE_SCREEN,
      page: () => ChatMessagePage(),
      // binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.MY_PROFILE,
      page: () => MyProfilePage(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS,
      page: () => OrderDetailsPage(),
      // binding: MyProfileBinding(),
    ),
    GetPage(
      name: Routes.VIEW_NOTIFICATIONS,
      page: () => ViewNotificationsPage(),
      binding: ViewNotificationsBinding(),
    ),
    GetPage(
      name: Routes.EDIT_STALL_SCREEN,
      page: () => EditStallPage(),
      binding: EditStallBinding(),
    ),
    // GetPage(
    //   name: Routes.STRIPE_WEBVIEW,
    //   page: () => StripeWebViewScreen(),
    //   // binding: MyProfileBinding(),
    // ),
  ];
}
