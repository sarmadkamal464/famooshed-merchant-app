import 'package:famooshed_vendor/app/modules/wallet_module/wallet_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_button_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:famooshed_vendor/app/theme/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../common/util/exports.dart';
import '../../data/models/wallet_response.dart';
import '../../utils/common_helper.dart';

/// GetX Template Generator - fb.com/htngu.99
///

class WalletPage extends GetView<WalletController> {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbarWidget(
          title: "My Wallet",
          centerTitle: true,
        ),
        body: GetBuilder<WalletController>(
            builder: (WalletController walletController) {
          if (walletController.isLoading.value) {
            return const Center(
              child: Loader(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  earningCard(walletController.lastWeek.value),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          earningDetailsCard(
                            bgColor: AppColors.lightGreen,
                            text: "This Week’s Earnings",
                            value: getPrice(walletController.thisWeek.value),
                          ),
                          earningDetailsCard(
                            bgColor: AppColors.lightGrey,
                            text: "Last Week’s Earnings",
                            value: getPrice(walletController.lastWeek.value),
                          )
                        ],
                      ),
                      totals(value: walletController.totalEarning.value),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Daily Transaction History",
                            style: urbanistExtraBold.copyWith(
                                fontSize: 24, color: AppColors.appTheme)),
                        // CircleAvatar(
                        //     radius: 25,
                        //     backgroundColor: AppColors.appTheme,
                        //     child: SvgPicture.asset(AppIcons.filter))
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: Get.height * .02,
                          horizontal: Get.width * .04),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.black.withOpacity(.02)),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: walletController.orderList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = walletController.orderList[index];
                          return orderItem(data);
                        },
                      ))
                ],
              ),
            );
          }
        }));
  }

  Widget earningCard(String amount) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: AppColors.appTheme),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * .03),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
              Text(
                "Total Balance",
                style: urbanistMedium.copyWith(
                    color: AppColors.white, fontSize: 24),
              ),
              Text(
                getPrice(amount),
                style: beVietnamProExtraBold.copyWith(
                    color: AppColors.white, fontSize: 33),
              ),
            ],
          ),
          SizedBox(height: Get.height * .02),
          DefaultButton(
            onTap: () {
              controller.withdrawalRequest();
              // Get.toNamed(Routes.MY_STALL);
            },
            width: Get.width * .7,
            backgroundColor: AppColors.buttonColor,
            buttonText: 'Get Paid Now',
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

  Widget totals({required String value}) {
    return Container(
      width: 160,
      height: 174,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: "#217041".fromHex),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 35,
              child: SvgPicture.asset("assets/images/coin.svg")
              // Image.asset("assets/images/order.png"),
              ),
          const SizedBox(
            height: 20,
          ),
          Text(
            getPrice(value),
            style: beVietnamProExtraBold.copyWith(
                fontSize: 18, color: AppColors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text("Total Earnings",
              style: urbanistRegular.copyWith(
                  fontSize: 14, color: AppColors.white)),
        ]),
      ),
    );
  }

  Widget earningDetailsCard(
      {required Color bgColor, required String text, required String value}) {
    return Container(
      height: 82,
      width: 200,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: bgColor),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: beVietnamProExtraBold.copyWith(
                      fontSize: 22, color: AppColors.appTheme),
                ),
              ),
              Text(text,
                  style: urbanistRegular.copyWith(
                      fontSize: 14, color: AppColors.appTheme)),
            ]),
      ),
    );
  }

  Widget orderItem(Iorder order) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.name.capitalize.toString(),
                  style: urbanistSemiBold.copyWith(
                    height: .22,
                    fontSize: 16,
                    color: "#053518".fromHex,
                  )),
              Text(getPrice(order.total),
                  style: urbanistExtraBold.copyWith(
                    fontSize: 16,
                    color: AppColors.appTheme,
                  )),
            ],
          ),
          SizedBox(height: Get.height * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("ID ${order.id}",
                  style: urbanistExtraBold.copyWith(
                      fontSize: 16, color: AppColors.doveGray)),
              Text(
                  Jiffy.parse(order.createdAt.toString())
                      .format(pattern: 'dd MMMM, yyyy h:mm:ss'),
                  style: urbanistSemiBold.copyWith(
                      fontSize: 16, color: AppColors.doveGray)),
            ],
          ),
          SizedBox(height: Get.height * .01),
          Container(
            width: 100,
            height: 23,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: order.status == "Delivered"
                    ? AppColors.lightGreen
                    : AppColors.lightYellow),
            child: Center(
                child: Text(order.status,
                    style: urbanistSemiBold.copyWith(
                        fontSize: 14, color: "#1D2C23".fromHex))),
          ),
          SizedBox(height: Get.height * .02),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
