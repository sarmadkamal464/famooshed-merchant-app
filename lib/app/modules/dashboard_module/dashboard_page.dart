import 'dart:ui';

import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/modules/dashboard_module/dashboard_controller.dart';
import 'package:famooshed_vendor/app/modules/food_management_module/food_management_controller.dart';
import 'package:famooshed_vendor/app/modules/my_categories_module/my_categories_controller.dart';
import 'package:famooshed_vendor/app/modules/my_new_promotions_module/my_notifications_controller.dart';
import 'package:famooshed_vendor/app/modules/my_stall_module/my_stall_controller.dart';
import 'package:famooshed_vendor/app/modules/over_view_module/over_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../libraries/sweet_nav_bar/src/sweet_nav_bar.dart';
import '../../common/values/app_icons.dart';
import '../../routes/app_pages.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/size_config.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/custom_button_widget.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});

//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   final _advancedDrawerController = AdvancedDrawerController();

//   @override
//   Widget build(BuildContext context) {
//     return AdvancedDrawer(
//       backdrop: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Colors.white, Colors.white],
//           ),
//         ),
//       ),
//       controller: _advancedDrawerController,
//       animationCurve: Curves.easeInOut,
//       animationDuration: const Duration(milliseconds: 300),
//       animateChildDecoration: true,
//       rtlOpening: false,
//       disabledGestures: false,
//       childDecoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(16)),
//       ),
//       drawer: SafeArea(
//         child: SizedBox(
//           child: ListTileTheme(
//             textColor: AppColors.appTheme,
//             iconColor: AppColors.appTheme,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const SizedBox(
//                   height: 24,
//                 ),
//                 SvgPicture.asset(
//                   AppImages.famooshedLogo,
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: const Icon(Icons.home),
//                   title: const Text('Home'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: const Icon(Icons.account_circle_rounded),
//                   title: const Text('Profile'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: const Icon(Icons.favorite),
//                   title: const Text('Favourites'),
//                 ),
//                 ListTile(
//                   onTap: () {},
//                   leading: const Icon(Icons.settings),
//                   title: const Text('Settings'),
//                 ),
//                 const Spacer(),
//                 DefaultTextStyle(
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.white54,
//                   ),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 16.0,
//                     ),
//                     child: const Text('Terms of Service | Privacy Policy'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Advanced Drawer Example'),
//           leading: IconButton(
//             onPressed: _handleMenuButtonPressed,
//             icon: ValueListenableBuilder<AdvancedDrawerValue>(
//               valueListenable: _advancedDrawerController,
//               builder: (_, value, __) {
//                 return AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 250),
//                   child: Icon(
//                     value.visible ? Icons.clear : Icons.menu,
//                     key: ValueKey<bool>(value.visible),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         body: Container(),
//       ),
//     );
//   }

//   void _handleMenuButtonPressed() {
//     _advancedDrawerController.showDrawer();
//   }
// }

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GetBuilder(
      builder: (DashboardController dashboardController) {
        return SafeArea(
          child: Scaffold(
              key: controller.scaffoldKey,
              resizeToAvoidBottomInset: true,
              // appBar: AppBar(
              //   foregroundColor: AppColors.appTheme,
              //   centerTitle: true,
              //   backgroundColor: AppColors.white,
              //   elevation: 0,
              //   title: Text(
              //     dashboardController.getAppTitle(),
              //     style: beVietnamProExtraBold.copyWith(
              //         fontSize: 24, color: AppColors.appTheme),
              //   ),
              // ),
              appBar: CustomAppbarWidget(
                title: dashboardController.getAppTitle(),
                centerTitle: true,
                backgroundColor: AppColors.white,
                actions: [
                  IconButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(12)),
                      onPressed: () {
                        Get.toNamed(Routes.MAP_SCREEN);
                      },
                      icon: Icon(
                        Icons.near_me_outlined,
                        color: AppColors.appTheme,
                      ))
                ],
                statusBarColor: AppColors.white,
                leading: GestureDetector(
                  onTap: () =>
                      controller.scaffoldKey.currentState!.openDrawer(),
                  child: SizedBox(
                      child: SvgPicture.asset(
                    AppIcons.drawer,
                    fit: BoxFit.cover,
                    width: getProportionateScreenWidth(50),
                    height: getProportionateScreenHeight(50),
                  )).paddingOnly(left: 10.w),
                ),
                // leading: GestureDetector(
                //   onTap: () {
                //     controller.scaffoldKey.currentState!.openDrawer();
                //   },
                //   child: SvgPicture.asset(AppIcons.drawer),
                // ),
              ),
              // drawer: _drawer(),
              drawer: Drawer(
                width: Get.width,
                backgroundColor: AppColors.appTheme.withOpacity(.4),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(
                    width: Get.width * .8,
                    height: Get.height,
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10),
                        vertical: getProportionateScreenHeight(10)),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/drawerbg.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                'assets/logo/app_logo_name.svg',
                                width: getProportionateScreenWidth(55),
                                height: getProportionateScreenHeight(50),
                                fit: BoxFit.cover,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(20),
                                      vertical:
                                          getProportionateScreenHeight(10)),
                                  child: SvgPicture.asset(
                                    'assets/icons/cancel.svg',
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.home,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      'Home'.tr,
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.OVER_VIEW);
                                      bool isRegistered = Get.isRegistered<
                                          OverViewController>();
                                      if (isRegistered) {
                                        OverViewController().onReady();
                                      } else {
                                        Get.find()<OverViewController>()
                                            .onReady();
                                      }
                                    },
                                  ),
                                  ExpansionTile(
                                      leading: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: AppColors.appTheme,
                                      ),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: AppColors.appTheme,
                                      ),
                                      title: Text(
                                        'Manage My Stall'.tr,
                                        style: urbanistSemiBold.copyWith(
                                          fontSize: getProportionalFontSize(16),
                                          color: AppColors.appTheme,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      children: [
                                        ListTile(
                                          dense: true,
                                          title: Text(
                                            'Overview'.tr,
                                            style: urbanistSemiBold.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(14),
                                              color: AppColors.appTheme,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          onTap: () {
                                            Get.back();

                                            Get.toNamed(Routes.MY_STALL);
                                            bool isRegistered =
                                                Get.isRegistered<
                                                    MyStallController>();
                                            if (isRegistered) {
                                              MyStallController().onReady();
                                            } else {
                                              Get.find()<MyStallController>()
                                                  .onReady();
                                            }
                                          },
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text(
                                            'Settings'.tr,
                                            style: urbanistSemiBold.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(14),
                                              color: AppColors.appTheme,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          onTap: () {
                                            Get.back();
                                            bool isRegistered =
                                                Get.isRegistered<
                                                    MyStallController>();
                                            if (isRegistered) {
                                              MyStallController()
                                                  .goToSettings();
                                            } else {
                                              Get.find()<MyStallController>()
                                                  .goToSettings();
                                            }
                                          },
                                        ),
                                      ]),
                                  ExpansionTile(
                                      leading: Icon(
                                        Icons.food_bank,
                                        color: AppColors.appTheme,
                                      ),
                                      expandedCrossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                        color: AppColors.appTheme,
                                      ),
                                      title: Text(
                                        'Products'.tr,
                                        style: urbanistSemiBold.copyWith(
                                          fontSize: getProportionalFontSize(16),
                                          color: AppColors.appTheme,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                      children: [
                                        ListTile(
                                          title: Text(
                                            'Add/Edit'.tr,
                                            style: urbanistSemiBold.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(14),
                                              color: AppColors.appTheme,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          onTap: () {
                                            Get.back();
                                            Get.toNamed(Routes.FOOD_MANAGEMENT);
                                            bool isRegistered =
                                                Get.isRegistered<
                                                    FoodManagementController>();
                                            if (isRegistered) {
                                              FoodManagementController()
                                                  .onReady();
                                            } else {
                                              Get.find()<
                                                      FoodManagementController>()
                                                  .onReady();
                                            }
                                          },
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text(
                                            'My Categories'.tr,
                                            style: urbanistSemiBold.copyWith(
                                              fontSize:
                                                  getProportionalFontSize(14),
                                              color: AppColors.appTheme,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          onTap: () {
                                            Get.back();

                                            Get.toNamed(Routes.MY_CATEGORIES);
                                            bool isRegistered =
                                                Get.isRegistered<
                                                    MyCategoriesController>();
                                            if (isRegistered) {
                                              MyCategoriesController()
                                                  .onReady();
                                            } else {
                                              Get.find()<
                                                      MyCategoriesController>()
                                                  .onReady();
                                            }
                                          },
                                        ),
                                      ]),
                                  ListTile(
                                    leading: Icon(
                                      Icons.history_edu,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      'My Orders'.tr,
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MY_ORDERS);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.wallet,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      'My Wallet'.tr,
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.WALLET);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.analytics_outlined,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      'My Analytics'.tr,
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MY_ANALYTICS);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.card_giftcard,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      "My Promotions",
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MY_PROMOTIONS);
                                      // Get.toNamed(Routes.MY_STALL);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.notifications,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      'My Notifications'.tr,
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MY_NEW_PROMOTIONS);
                                      bool isRegistered = Get.isRegistered<
                                          MyNotificationsController>();
                                      if (isRegistered) {
                                        MyNotificationsController().onReady();
                                      } else {
                                        Get.find()<MyNotificationsController>()
                                            .onReady();
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.account_circle_outlined,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      "My Profile",
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MY_PROFILE);
                                      // Get.toNamed(Routes.MY_STALL);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.drive_eta_rounded,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      "My Drivers",
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.MY_DRIVERS);
                                      // Get.toNamed(Routes.MY_STALL);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.chat,
                                      color: AppColors.appTheme,
                                    ),
                                    title: Text(
                                      "Chat",
                                      style: urbanistSemiBold.copyWith(
                                        fontSize: getProportionalFontSize(16),
                                        color: AppColors.appTheme,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.CHAT_SCREEN);
                                      // Get.toNamed(Routes.MY_STALL);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(10),
                                top: getProportionateScreenHeight(10),
                                bottom: getProportionateScreenHeight(40)),
                            child: DefaultButton(
                                buttonText: Strings.logOut,
                                backgroundColor: AppColors.appTheme,
                                onTap: () async {
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Logout'),
                                          content: Text(
                                              'Are you sure you want to logout?'
                                                  .tr),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text(
                                                  'No'.tr,
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                            TextButton(
                                              onPressed: () async {
                                                // SharedPreferences prefs =
                                                //     await SharedPreferences.getInstance();

                                                // var groupId = prefs.getString('groupId') ?? '';
                                                // var userId = prefs.getString('userId') ?? '';
                                                // var password = prefs.getString('password') ?? '';

                                                // await prefs.remove("accountId");
                                                // await prefs.remove("AccountName");

                                                // Navigator.pushAndRemoveUntil(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (BuildContext context) =>
                                                //             LoginNewPro(groupId, userId, password)),
                                                //     ModalRoute.withName('/'));

                                                Storage.clearStorage();
                                                Get.offAllNamed(Routes.SIGN_IN);
                                              },
                                              child: Text(
                                                'Yes'.tr,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                height: getProportionateScreenHeight(46),
                                width: getProportionateScreenWidth(145)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Follow Us",
                                      style: beVietnamProaBold.copyWith(
                                          color: AppColors.darkGreenColor,
                                          fontSize: 16)),
                                  SizedBox(
                                      height: getProportionateScreenHeight(10)),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse(
                                                  "https://www.facebook.com/famooshed"),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/facebook.svg'),
                                      ),
                                      // SizedBox(width: Get.width * .03),
                                      // SvgPicture.asset(AppIcons.twitter),
                                      SizedBox(width: Get.width * .03),
                                      GestureDetector(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse(
                                                  "https://www.instagram.com/famooshed/"),
                                              mode: LaunchMode
                                                  .externalApplication);
                                        },
                                        child: SvgPicture.asset(
                                            'assets/icons/insta.svg'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]

                        // ListTile(
                        //   leading: SvgPicture.asset(AppLogo.appLogoNameImage),
                        // )
                        ),
                  ),
                ),
              ),
              body: SafeArea(
                child: Navigator(
                    key: Get.nestedKey(1),
                    initialRoute: '/overview',
                    onGenerateRoute: dashboardController.onGenerateRoute),
              ),
              bottomNavigationBar: Obx(
                () => Theme(
                  data: ThemeData(
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        unselectedItemColor: AppColors.appTheme),
                  ),
                  child: SweetNavBar(
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    currentIndex: dashboardController.currentIndex.value,
                    items: [
                      SweetNavBarItem(
                        sweetActive: SvgPicture.asset(AppIcons.home),
                        sweetIcon: SvgPicture.asset(AppIcons.home),
                        sweetLabel: 'Home',

                        // iconColors: dashboardController.iconLinearGradiant,
                      ),
                      SweetNavBarItem(
                        sweetActive: SvgPicture.asset(AppIcons.account),
                        sweetIcon: SvgPicture.asset(AppIcons.account),
                        sweetLabel: 'Products',
                      ),
                      SweetNavBarItem(
                          sweetActive: SvgPicture.asset(AppIcons.notification),
                          sweetIcon: SvgPicture.asset(AppIcons.notification),
                          sweetLabel: 'Notifications'),
                      SweetNavBarItem(
                          // sweetActive: SvgPicture.asset(AppIcons.filter),
                          sweetActive: SvgPicture.asset(
                            AppIcons.filterDashboard,
                          ),
                          // sweetIcon: SvgPicture.asset(AppIcons.filter),
                          sweetIcon: SvgPicture.asset(
                            AppIcons.filterDashboard,
                          ),
                          sweetLabel: 'Orders'),
                      SweetNavBarItem(
                          sweetActive: SvgPicture.asset(AppIcons.chat),
                          sweetIcon: SvgPicture.asset(AppIcons.chat),
                          sweetLabel: 'Chat'),
                    ],
                    onTap: dashboardController.changePage,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //------------user image section  and other deatils //
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.appTheme,
            ),
            accountName: Obx(() => InkWell(
                  onTap: () {},
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: controller.userName.value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                        TextSpan(text: ' '),
                      ],
                    ),
                  ),
                )),
            accountEmail: Obx(() => Text(controller.email.value)),
            currentAccountPicture: InkWell(
              onTap: () {
                //-your action
              },
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Obx(() => CircleAvatar(
                          radius: 43,
                          child: ClipOval(
                            child: FadeInImage(
                              fadeInDuration: Duration(milliseconds: 500),
                              placeholder: AssetImage(AppImages.merchantLogo),
                              image: NetworkImage(controller.image.value),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error);
                              },
                              fit: BoxFit.cover,
                              height: 70,
                              width: 70,
                            ),
                          ),
                        )),
                  ),
                  // Positioned(
                  //     bottom: 1,
                  //     right: 1,
                  //     child: Container(
                  //       height: 35,
                  //       width: 35,
                  //       decoration:  BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius:
                  //               BorderRadius.all(Radius.circular(20))),
                  //       child:  InkWell(
                  //         //  onTap: _onAlertPress,
                  //         child: Icon(
                  //           Icons.add_a_photo,
                  //           size: 15.0,
                  //           color: Color(0xFF404040),
                  //         ),
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),

          //--------menu list ------------------//

          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home'.tr,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.OVER_VIEW);
              bool isRegistered = Get.isRegistered<OverViewController>();
              if (isRegistered) {
                OverViewController().onReady();
              } else {
                Get.find()<OverViewController>().onReady();
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'Manage My Stall'.tr,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();

              Get.toNamed(Routes.MY_STALL);
              bool isRegistered = Get.isRegistered<MyStallController>();
              if (isRegistered) {
                MyStallController().onReady();
              } else {
                Get.find()<MyStallController>().onReady();
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank),
            title: Text(
              'Products'.tr,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.FOOD_MANAGEMENT);
              bool isRegistered = Get.isRegistered<FoodManagementController>();
              if (isRegistered) {
                FoodManagementController().onReady();
              } else {
                Get.find()<FoodManagementController>().onReady();
              }
            },
          ),

          ListTile(
            leading: Icon(Icons.category),
            title: Text(
              'Categories'.tr,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.MY_CATEGORIES);
              bool isRegistered = Get.isRegistered<MyCategoriesController>();
              if (isRegistered) {
                MyCategoriesController().onReady();
              } else {
                Get.find()<MyCategoriesController>().onReady();
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.history_edu),
            title: Text(
              'Orders'.tr,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.MY_ORDERS);
            },
          ),

          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text(
              "Coupons",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.MY_PROMOTIONS);
              // Get.toNamed(Routes.MY_STALL);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(
              "Account",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.MY_PROFILE);
              // Get.toNamed(Routes.MY_STALL);
            },
          ),

          // ListTile(
          //   leading: Image.asset(
          //     AppImages.appleLogo,
          //     width: 25,
          //     height: 25,
          //     fit: BoxFit.fill,
          //     color: Colors.black54,
          //   ),
          //   title:  Text(
          //     "Chat",
          //     style: TextStyle(
          //       fontSize: 15.0,
          //       color: Colors.black,
          //       letterSpacing: 0,
          //     ),
          //   ),
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
          //  Divider(
          //   color: Colors.black38,
          // ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              'Notifications'.tr,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.MY_NEW_PROMOTIONS);
              bool isRegistered = Get.isRegistered<MyNotificationsController>();
              if (isRegistered) {
                MyNotificationsController().onReady();
              } else {
                Get.find()<MyNotificationsController>().onReady();
              }
            },
          ),

          ListTile(
            leading: Icon(Icons.drive_eta_rounded),
            title: Text(
              "Drivers",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.MY_DRIVERS);
              // Get.toNamed(Routes.MY_STALL);
            },
          ),

          Divider(
            color: Colors.black38,
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'.tr),
            onTap: () async {
              showDialog(
                  context: Get.context!,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'.tr),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'No'.tr,
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                          onPressed: () async {
                            // SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();

                            // var groupId = prefs.getString('groupId') ?? '';
                            // var userId = prefs.getString('userId') ?? '';
                            // var password = prefs.getString('password') ?? '';

                            // await prefs.remove("accountId");
                            // await prefs.remove("AccountName");

                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) =>
                            //             LoginNewPro(groupId, userId, password)),
                            //     ModalRoute.withName('/'));

                            Storage.clearStorage();
                            Get.offAllNamed(Routes.SIGN_IN);
                          },
                          child: Text(
                            'Yes'.tr,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  });
            },
          ),

//----------------------end code-------------------//
        ],
      ),
    );
  }
}
