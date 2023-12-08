import 'package:famooshed_vendor/app/common/util/exports.dart';
import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/data/models/order_list_response.dart';
import 'package:famooshed_vendor/app/modules/over_view_module/over_view_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/sales_data.dart';

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double? y;
}

class OverViewPage extends GetView<OverViewController> {
  OverViewPage({required this.isHideAppBar});

  bool isHideAppBar;
  List<SalesData> data = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];
  var scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // drawer: _drawer(),
      backgroundColor: AppColors.white,
      appBar: isHideAppBar
          ? null
          : AppBar(
              iconTheme: IconThemeData(color: AppColors.appTheme),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              // leading: GestureDetector(
              //   onTap: () => scaffoldKey.currentState!.openDrawer(),
              //   child: SizedBox(
              //           width: 24, child: SvgPicture.asset(AppIcons.drawer))
              //       .paddingOnly(left: 10.w),
              // ),
              centerTitle: true,
              title: Text(
                "Overview",
                style: beVietnamProBold.copyWith(
                    color: AppColors.appTheme, fontSize: 24),
              ),
            ),
      body: SingleChildScrollView(
        child: GetBuilder(
          builder: (OverViewController overViewController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                earningCard(overViewController),
                // LineChartSample8(),
                // const LineChartSample2(),

                SizedBox(
                  height: getProportionateScreenHeight(280),
                  child: SfCartesianChart(
                      // plotAreaBackgroundColor: Colors.red,
                      // backgroundColor: Colors.black,
                      borderColor: Colors.tealAccent,
                      primaryXAxis: CategoryAxis(),
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16),
                        vertical: getProportionateScreenHeight(20),
                      ),
                      primaryYAxis: NumericAxis(
                          maximum: double.parse(
                              controller.earning.value.isNotEmpty
                                  ? controller.earning.value
                                  : 500.toString())),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        // Initialize line series
                        AreaSeries<ChartData, String>(
                          color: AppColors.lightGreen,
                          isVisibleInLegend: true,
                          isVisible: true,
                          borderColor: AppColors.appTheme,
                          borderWidth: 2.5,
                          dataLabelSettings:
                              DataLabelSettings(useSeriesColor: true),
                          enableTooltip: true,
                          markerSettings: MarkerSettings(
                              isVisible: true,
                              color: AppColors.appTheme,
                              height: 8,
                              width: 8),
                          dataSource: [
                            ChartData('Jan', controller.e1),
                            ChartData('Feb', controller.e2),
                            ChartData('Mar', controller.e3),
                            ChartData('Apr', controller.e4),
                            ChartData('May', controller.e5),
                            ChartData('Jun', controller.e6),
                            ChartData('Jul', controller.e7),
                            ChartData('Aug', controller.e8),
                            ChartData('Sep', controller.e9),
                            ChartData('Oct', controller.e10),
                            ChartData('Nov', controller.e11),
                            ChartData('Dec', controller.e12),
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                        )
                      ]),
                ),
                // const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    totals(
                        totalOrders: controller.totalEarnings.value,
                        image: SvgPicture.asset("assets/images/coin.svg"),
                        text: "Total Earnings"),
                    totals(
                        text: "Total Users",
                        totalOrders: controller.totalUsers.value,
                        image: SvgPicture.asset(AppIcons.user)),
                    totals(
                        text: "Total Orders",
                        totalOrders: controller.totalOrders.value,
                        image: SvgPicture.asset("assets/images/order.svg")),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text("LAST 10 ORDERS",
                      style: urbanistExtraBold.copyWith(
                          fontSize: 24, color: AppColors.appTheme)),
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Get.height * .01,
                        horizontal: Get.width * .04),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.black.withOpacity(.02)),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.order.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.order[index];
                        return orderItem(data);
                      },
                    ))
              ],
            );
          },
        ),
      ),
    );
  }

  Widget earningCard(OverViewController overViewController) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.width * .03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.cardColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * .03),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/coin.svg"),
              SizedBox(width: 15),
              Column(
                children: [
                  Text(
                    controller.currency.value + controller.earning.value,
                    style: beVietnamProExtraBold.copyWith(
                        color: AppColors.white, fontSize: 33),
                  ),
                  Text(
                    "Total Earnings",
                    style: urbanistRegular.copyWith(
                        color: AppColors.white, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: Get.height * .02),
          DefaultButton(
            onTap: () {
              Get.toNamed(Routes.WALLET);
            },
            width: Get.width * .7,
            backgroundColor: AppColors.appTheme,
            buttonText: 'Go to My Wallet',
          )
          // walletCard(),
        ]),
      ),
    );
  }

  Widget walletCard() {
    return Container(
      width: Get.width * .7,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.appTheme),
      child: Center(
        child: Text(
          Strings.wallet,
          style: urbanistBold.copyWith(color: AppColors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget totals({totalOrders, Widget? image, String? text}) {
    return Container(
      width: 126,
      height: 137,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.lightGreen),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CircleAvatar(
              backgroundColor: AppColors.white, radius: 30, child: image
              // Image.asset("assets/images/order.png"),
              ),
          Text(
            totalOrders.toString(),
            style: beVietnamProExtraBold.copyWith(
                fontSize: 22, color: AppColors.appTheme),
          ),
          Text(text!,
              style: urbanistRegular.copyWith(
                  fontSize: 14, color: AppColors.appTheme)),
        ]),
      ),
    );
  }

  Widget orderItem(Order order) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('${order.userName ?? '-'}'.capitalize.toString(),
                style: urbanistSemiBold.copyWith(
                    height: .25, fontSize: 16, color: AppColors.appTheme)),
            Text(controller.currency + '${order.total}',
                style: urbanistExtraBold.copyWith(
                    height: .25, fontSize: 16, color: AppColors.appTheme))
          ]),
          SizedBox(height: Get.height * .02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ID ${order.id}",
                  style: urbanistExtraBold.copyWith(
                      fontSize: 16, color: AppColors.doveGray)),
              Text(
                DateFormat('d MMMM, yyyy hh:mm:ss')
                    .format((DateTime.parse(order.createdAt.toString()))),
              )

              // Text(order.createdAt.toString(),
              //     style: urbanistExtraBold.copyWith(
              //         fontSize: 16, color: AppColors.doveGray)),
            ],
          ),
          SizedBox(height: Get.height * .02),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8),
                  vertical: getProportionateScreenHeight(5),
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(3),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: order.status != null && order.status == 5
                        ? AppColors.lightGreen
                        : AppColors.lightYellow),
                child: Center(
                    child: Text("${controller.getStatus(order.status ?? 1)}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: urbanistSemiBold.copyWith(fontSize: 14))),
              ),
              order.curbsidePickup == "true"
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(5),
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(3),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.lightPink.withOpacity(.24)),
                      child: Center(
                          child: Text("Curbside Pickup",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: urbanistSemiBold.copyWith(fontSize: 14))),
                    )
                  : SizedBox(),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8),
                    vertical: getProportionateScreenHeight(5),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(3),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGreen),
                  child: Center(
                      child: Text(
                    "${order.method}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: urbanistSemiBold.copyWith(fontSize: 14),
                  )),
                ),
              )
            ],
          ),
          SizedBox(height: Get.height * .02),
          Divider(
            thickness: 1,
          )
        ],
      ),
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
                      content: Text('Logout Message'.tr),
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
