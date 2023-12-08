import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed_vendor/app/data/models/analytics_model.dart';
import 'package:famooshed_vendor/app/modules/my_analytics_module/my_analytics_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/routes/app_pages.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/constants.dart';
import '../../common/util/exports.dart';
import '../../theme/size_config.dart';
import '../over_view_module/over_view_page.dart';

class MyAnalyticsPage extends GetView<MyAnalyticsController> {
  const MyAnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<MyAnalyticsController>(
        builder: (controller) {
          return NumberPaginator(
            config: NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: AppColors.appTheme,
                buttonUnselectedBackgroundColor: Colors.transparent,
                buttonSelectedForegroundColor: AppColors.white,
                buttonUnselectedForegroundColor: AppColors.appTheme,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                ),
                height: getProportionateScreenHeight(48),
                buttonShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                mode: ContentDisplayMode.numbers,
                mainAxisAlignment: MainAxisAlignment.spaceBetween),
            numberPages: controller.lastPageIndex.value,
            onPageChange: (int index) {
              // controller.currentIndex.value = index;
              controller.pageNo.value = index + 1;
              controller.update();
              controller.getAnalyticsData();
            },
          );
        },
      ),
      appBar: CustomAppbarWidget(
          title: "My Analytics",
          centerTitle: true,
          textColor: AppColors.appTheme),
      body: GetBuilder<MyAnalyticsController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * .02, horizontal: Get.width * .04),
              child: Column(
                children: [
                  topProduct(),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      totals(
                          'assets/images/order.svg',
                          (controller.analyticsModel.ordersCount ?? 0)
                              .toString(),
                          (controller.analyticsModel.totalOrderPercnt ?? 0)
                              .toString(),
                          "Total Orders"),
                      totals(
                          'assets/images/user.svg',
                          (controller.analyticsModel.totalUser ?? 0).toString(),
                          (controller.analyticsModel.totalPricePercnt ?? 0)
                              .toString(),
                          "Total Customers"),
                      totals(
                          'assets/images/user.svg',
                          (controller.analyticsModel.returnCustmr ?? 0)
                              .toString(),
                          (controller.analyticsModel.totalPercntReturn ?? 0)
                              .toString(),
                          "Returning Customers")
                    ],
                  ),
                  earningCard(),
                  // CustomTextFieldWidget(
                  //     prefixIconPadding:
                  //         const EdgeInsets.only(left: 15, right: 10),
                  //     prefixIcon: SvgPicture.asset(AppIcons.search),
                  //     obscureText: false,
                  //     hintText: "Search",
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(11),
                  //         borderSide: BorderSide(color: AppColors.appTheme))),
                  SizedBox(height: Get.height * .02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Top Selling Products",
                          style: beVietnamProExtraBold.copyWith(
                              fontSize: 24, color: AppColors.appTheme)),
                      // CircleAvatar(
                      //     radius: 25,
                      //     backgroundColor: AppColors.appTheme,
                      //     child: SvgPicture.asset(AppIcons.filter))
                    ],
                  ),
                  sellingProductItems(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget chart() {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          clipData:
              FlClipData(bottom: true, left: true, right: true, top: true),
          lineBarsData: [
            LineChartBarData(
                // spots: controller.data
                //     .map((point) => const FlSpot(1, 20))
                //     .toList(),
                isCurved: true,
                dotData: FlDotData(show: true),
                color: Colors.red),
          ],
          borderData: FlBorderData(
              show: true,
              border: const Border(bottom: BorderSide(), left: BorderSide())),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          ),
        ),
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'Jan';
              break;
            case 3:
              text = 'Mar';
              break;
            case 5:
              text = 'May';
              break;
            case 7:
              text = 'Jul';
              break;
            case 9:
              text = 'Sep';
              break;
            case 11:
              text = 'Nov';
              break;
          }

          return Text(text);
        },
      );

  Widget topProduct() {
    return controller.topSell.foodid != null
        ? Container(
            padding: EdgeInsets.symmetric(vertical: Get.height * .01),
            decoration: BoxDecoration(
                color: AppColors.grey, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.only(left: Get.width * .04),
              child: Column(
                children: [
                  Text("Top Product",
                      style: beVietnamProExtraBold.copyWith(
                          fontSize: 24, color: AppColors.appTheme)),
                  SizedBox(height: Get.height * .02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        child: CachedNetworkImage(
                          imageUrl:
                              Constants.imgUrl + controller.topSell.image!,
                          height: getProportionateScreenHeight(150),
                          width: getProportionateScreenWidth(130),
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              AppImages.blankImage,
                              fit: BoxFit.cover,
                              height: getProportionateScreenHeight(150),
                              width: getProportionateScreenWidth(130),
                            );
                          },
                          placeholder: (context, url) {
                            return Container(
                              height: getProportionateScreenHeight(150),
                              width: getProportionateScreenWidth(130),
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      // Image.asset(AppImages.bigMilkBottleImg),
                      SizedBox(width: Get.width * .05),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Get.width * .45,
                              child: Text(
                                "${controller.topSell.name ?? '-'}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: urbanistSemiBold.copyWith(
                                    color: AppColors.appTheme, fontSize: 16),
                              ),
                            ),
                            SizedBox(height: Get.height * .02),
                            Row(
                              children: [
                                Text(
                                  "Total Sells:",
                                  style: totalStyle(),
                                ),
                                Text("  ${controller.topSell.totalSell ?? '-'}",
                                    style: textStyle()),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total Earnings:", style: totalStyle()),
                                Text(
                                    "  £${controller.topSell.totalEarning ?? '-'}",
                                    style: textStyle()),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total Customers:", style: totalStyle()),
                                Text(
                                  "  ${controller.topSell.totalCustomer ?? '-'}",
                                  style: textStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(18),
                  ),
                  Text("Last 3 months", style: totalStyle()),
                  SizedBox(
                    height: getProportionateScreenHeight(200),
                    child: controller.analyticsModel.monthlyEarning != null &&
                            controller.analyticsModel.monthlyEarning!.isNotEmpty
                        ? SfCartesianChart(
                            borderColor: AppColors.appTheme,
                            primaryXAxis: CategoryAxis(),
                            margin: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(0),
                              vertical: getProportionateScreenHeight(12),
                            ),
                            primaryYAxis: NumericAxis(
                                maximum: double.parse(
                                    controller.analyticsModel.earning ??
                                        100.toString())),
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
                                  dataSource:
                                      controller.analyticsModel.monthlyEarning!
                                          .map(
                                            (e) => ChartData(
                                              (e.month ?? '-').capitalize!,
                                              double.parse(
                                                  e.earning ?? 0.toString()),
                                            ),
                                          )
                                          .toList(),

                                  //     [
                                  //   ChartData('Jan', 98),
                                  //   ChartData('Feb', 50),
                                  //   ChartData('Mar', 50),
                                  //   ChartData('Apr', 60),
                                  //   ChartData('May', 220),
                                  //   ChartData('Jun', 260),
                                  //   ChartData('Jul', 300),
                                  //   ChartData('Aug', 300),
                                  //   ChartData('Sep', 300),
                                  //   ChartData('Oct', 300),
                                  //   ChartData('Nov', 300),
                                  //   ChartData('Dec', 300),
                                  // ],
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                )
                              ])
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          )
        : SizedBox();
  }

  totalStyle() {
    return beVietnamProExtraBold.copyWith(
        fontSize: 14, color: AppColors.appThemeDark);
  }

  textStyle() {
    return urbanistSemiBold.copyWith(fontSize: 14, color: AppColors.appTheme);
  }

  Widget totals(
    String image,
    String value,
    String percentage,
    String name,
  ) {
    return Container(
      width: getProportionateScreenWidth(110),
      height: getProportionateScreenHeight(180),
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.lightGreen),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 30,
              child: SvgPicture.asset("${image}")
              // Image.asset("assets/images/order.png"),
              ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(color: AppColors.white),
              // backgroundColor: AppColors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/Activity.png",
                    color: int.parse(percentage) < 0
                        ? AppColors.redColor
                        : AppColors.appTheme,
                  ),
                  Text(
                    " ${percentage}%",
                    style: beVietnamProMedium.copyWith(
                      fontSize: getProportionalFontSize(12),
                      color: int.parse(percentage) < 0
                          ? AppColors.redColor
                          : AppColors.black,
                    ),
                  )
                ],
              )),
          Text(
            "${value}",
            style: beVietnamProExtraBold.copyWith(
                fontSize: 22, color: AppColors.appTheme),
          ),
          Flexible(
            child: Text("${name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: urbanistRegular.copyWith(
                    fontSize: getProportionalFontSize(13),
                    color: AppColors.appTheme)),
          ),
        ]),
      ),
    );
  }

  Widget earningCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.width * .05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.cardColor),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * .03),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppImages.coin),
              const SizedBox(width: 15),
              Column(
                children: [
                  Text(
                    "£${(controller.analyticsModel.earning ?? 0)}",
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
              buttonText: Strings.goToWallet)
          // walletCard(),
        ]),
      ),
    );
  }

  Widget sellingProductItems() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * .02),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: AppColors.grey),
        child: controller.topSellingProducts.isNotEmpty
            ? ListView.builder(
                itemCount: controller.topSellingProducts.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  TopSellingProductModel topSellingProductModel =
                      controller.topSellingProducts[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(12),
                      horizontal: getProportionateScreenWidth(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(
                            //   height: 24,
                            //   width: 24,
                            //   child: Checkbox(
                            //     value: false,
                            //     onChanged: (v) {},
                            //     activeColor: AppColors.white,
                            //     checkColor: AppColors.appTheme,
                            //   ),
                            // ),
                            Column(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  child: CachedNetworkImage(
                                    imageUrl: Constants.imgUrl +
                                        topSellingProductModel.image!,
                                    height: getProportionateScreenHeight(80),
                                    width: getProportionateScreenWidth(80),
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        AppImages.blankImage,
                                        fit: BoxFit.cover,
                                        height:
                                            getProportionateScreenHeight(80),
                                        width: getProportionateScreenWidth(80),
                                      );
                                    },
                                    placeholder: (context, url) {
                                      return Container(
                                        height:
                                            getProportionateScreenHeight(80),
                                        width: getProportionateScreenWidth(80),
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                                // Image.asset(AppImages.milkBottle),
                                const SizedBox(height: 8),
                                Text(
                                  "ID ${topSellingProductModel.foodid ?? '-'}",
                                  style: urbanistExtraBold.copyWith(
                                      fontSize: 14, color: AppColors.doveGray),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                            // width: 140,
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${topSellingProductModel.name ?? '-'}",
                                                style: urbanistMedium.copyWith(
                                                    fontSize: 14)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * .04),
                                              child: Container(
                                                width:
                                                    getProportionateScreenWidth(
                                                        100),
                                                height:
                                                    getProportionateScreenHeight(
                                                        24),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getProportionateScreenWidth(
                                                            10)),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: controller
                                                      .getProductColor(
                                                          topSellingProductModel),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${controller.getProductStatus(topSellingProductModel)}",
                                                    style: urbanistSemiBold
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(16),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Month Earnings",
                                            style: urbanistMedium.copyWith(
                                                fontSize:
                                                    getProportionalFontSize(
                                                        13)),
                                          ),
                                          Text(
                                            "£${topSellingProductModel.totalEarning ?? '0'}",
                                            style: urbanistBold.copyWith(
                                                fontSize:
                                                    getProportionalFontSize(
                                                        14)),
                                          ),
                                          SizedBox(height: Get.height * .02),
                                          Text("Customers",
                                              style: urbanistMedium.copyWith(
                                                  fontSize:
                                                      getProportionalFontSize(
                                                          13))),
                                          Text(
                                            "${topSellingProductModel.totalCustomer ?? '0'}",
                                            style: urbanistBold.copyWith(
                                                fontSize:
                                                    getProportionalFontSize(
                                                        14)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * .02),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    ),
                  );
                },
              )
            : SizedBox(),
      ),
    );
  }
}
