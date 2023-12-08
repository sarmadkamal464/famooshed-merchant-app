import 'package:famooshed_vendor/app/common/values/app_icons.dart';
import 'package:famooshed_vendor/app/modules/my_orders_module/my_orders_controller.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_text_field_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../data/models/order_list_response.dart';
import '../../routes/app_pages.dart';
import '../../theme/size_config.dart';

class MyOrdersPage extends GetView<MyOrdersController> {
  MyOrdersPage({required this.isHideAppBar});
  bool isHideAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isHideAppBar
            ? null
            : CustomAppbarWidget(
                title: "My Orders",
                centerTitle: true,
                textColor: AppColors.appTheme),
        body: GetBuilder<MyOrdersController>(
          builder: (MyOrdersController controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * .02, horizontal: Get.width * .05),
                child: Column(children: [
                  const SizedBox(width: 12),
                  CustomTextFieldWidget(
                    controller: controller.searchController,
                    prefixIconPadding:
                        const EdgeInsets.only(left: 15, right: 10),
                    prefixIcon: SvgPicture.asset(AppIcons.search),
                    obscureText: false,
                    onChanged: (value) {
                      controller.filterOrderList();
                      // if (value == null || value.isEmpty) {
                      //   controller.isSearch.value = false;
                      // } else {
                      //   controller.isSearch.value = true;
                      // }
                      // controller.update();
                      // controller.getResultList(value);
                    },
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: AppColors.appTheme)),
                  ),
                  const Divider(thickness: 1, height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "List",
                        style: beVietnamProExtraBold.copyWith(
                            fontSize: 24, color: AppColors.appTheme),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(160),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButtonFormField<OrderStatus>(
                            isExpanded: false,
                            isDense: true,
                            alignment: Alignment.bottomLeft,
                            icon: Icon(Icons.keyboard_arrow_down),
                            borderRadius: BorderRadius.circular(8),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                top: getProportionateScreenHeight(4),
                                bottom: getProportionateScreenHeight(4),
                                left: getProportionateScreenWidth(0),
                                right: getProportionateScreenWidth(6),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                            ),
                            items: controller.filterOrderStatusList
                                .map(
                                  (item) => DropdownMenuItem<OrderStatus>(
                                    value: item,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.status.toString(),
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionalFontSize(12),
                                              overflow: TextOverflow.visible,
                                              color: Colors.black),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (T) {
                              controller.filterStatus = T as OrderStatus;
                              // if (controller.filterStatus.id != null &&
                              //     controller.filterStatus.id == -1) {
                              //   controller.isSearch.value = false;
                              // } else {
                              //   controller.isSearch.value = true;
                              // }
                              // controller.update();
                              // if (controller.isSearch.value) {
                              //   controller.searchOrderList = controller.order
                              //       .where((element) =>
                              //           element.status ==
                              //           controller.filterStatus.id)
                              //       .toList();
                              // }
                              // else {
                              //   controller.order = controller.order
                              //       .where((element) =>
                              //           element.status ==
                              //           controller.filterStatus.id)
                              //       .toList();
                              // }
                              controller.update();
                              // if (controller.filterStatus.id != null &&
                              //     controller.filterStatus.id == -1) {
                              //   controller.orderList();
                              // } else {
                              controller.filterOrderList();
                              // }
                            },
                            value: controller.filterStatus,
                            hint: const Text("Select Status"),
                            style: TextStyle(
                                fontSize: getProportionalFontSize(12)),
                          ),
                        ),
                      ),

                      // CircleAvatar(
                      //     radius: 25,
                      //     backgroundColor: AppColors.appTheme,
                      //     child: SvgPicture.asset(AppIcons.filter))
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.black.withOpacity(.02)),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.order.length,
                        itemBuilder: (BuildContext context, int index) {
                          return orderItem(controller.order[index]);
                        },
                      ))
                ]),
              ),
            );
          },
        ));
  }

  Widget orderItem(Order order) {
    return InkWell(
      onTap: () {
        controller.currentOrder = order;
        if (controller.orderStatus.isNotEmpty) {
          controller.selectedStatus = controller.orderStatus
              .where((element) => element.id == order.status)
              .first;
          if (controller.selectedStatus.id == null) {
            controller.selectedStatus = controller.orderStatus[0];
          }
        }

        if (controller.drivers.isNotEmpty) {
          controller.selectedDriver = controller.drivers
              .where((element) =>
                  element.id ==
                  (order.driver != null && order.driver != 0
                      ? order.driver
                      : 191))
              .first;
          if (controller.selectedDriver.id == null) {
            controller.selectedDriver = controller.drivers[0];
          }
        }
        controller.update();
        Get.toNamed(Routes.ORDER_DETAILS);
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${order.userName ?? '-'}'.capitalize.toString(),
                  style: urbanistSemiBold.copyWith(
                      height: .25, fontSize: 16, color: AppColors.appTheme)),
              Text('£${order.total}',
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
                Text("${Utils.getLocalDate(order.updatedAt.toString())}"
                    // DateFormat('d MMMM, yyyy hh:mm:ss')
                    //     .format((DateTime.parse(order.createdAt.toString()))),
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
                                style:
                                    urbanistSemiBold.copyWith(fontSize: 14))),
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
      ),
    );
  }
  // Widget orderItem(Order order) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //       vertical: getProportionateScreenHeight(8),
  //       horizontal: getProportionateScreenWidth(8),
  //     ),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("${order.name ?? '-'}",
  //                 style: urbanistSemiBold.copyWith(
  //                     fontSize: 16, color: AppColors.appTheme)),
  //             Text("£${order.total}",
  //                 style: urbanistSemiBold.copyWith(
  //                     fontSize: 16, color: AppColors.appTheme)),
  //           ],
  //         ),
  //         SizedBox(height: Get.height * .02),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("ID ${order.orderid}",
  //                 style: urbanistExtraBold.copyWith(
  //                     fontSize: 16, color: AppColors.doveGray)),
  //             Text("${order.date}",
  //                 style: urbanistExtraBold.copyWith(
  //                     fontSize: 16, color: AppColors.doveGray)),
  //           ],
  //         ),
  //         SizedBox(height: Get.height * .02),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               // height: 23,
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: getProportionateScreenWidth(10),
  //                 vertical: getProportionateScreenHeight(5),
  //               ),
  //               margin: EdgeInsets.symmetric(
  //                 horizontal: getProportionateScreenWidth(3),
  //               ),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(8),
  //                   color: AppColors.lightYellow),
  //               child: Center(
  //                 child: Text(
  //                   "${order.statusName}",
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 1,
  //                   style: urbanistSemiBold.copyWith(
  //                     fontSize: getProportionalFontSize(13),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: getProportionateScreenWidth(8),
  //                   vertical: getProportionateScreenHeight(5),
  //                 ),
  //                 margin: EdgeInsets.symmetric(
  //                   horizontal: getProportionateScreenWidth(3),
  //                 ),
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8),
  //                     color: AppColors.lightPink.withOpacity(.24)),
  //                 child: Center(
  //                     child: Text("Curbside Pickup",
  //                         overflow: TextOverflow.ellipsis,
  //                         maxLines: 1,
  //                         style: urbanistSemiBold.copyWith(
  //                           fontSize: getProportionalFontSize(13),
  //                         ))),
  //               ),
  //             ),
  //             Expanded(
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: getProportionateScreenWidth(8),
  //                   vertical: getProportionateScreenHeight(5),
  //                 ),
  //                 margin: EdgeInsets.symmetric(
  //                   horizontal: getProportionateScreenWidth(3),
  //                 ),
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(8),
  //                     color: AppColors.lightGreen),
  //                 child: Center(
  //                     child: Text(
  //                   "Cash on Delivery",
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 1,
  //                   style: urbanistSemiBold.copyWith(
  //                     fontSize: getProportionalFontSize(13),
  //                   ),
  //                 )),
  //               ),
  //             )
  //           ],
  //         ),
  //         SizedBox(height: Get.height * .02),
  //         const Divider(
  //           thickness: 1,
  //         )
  //       ],
  //     ),
  //   );
  // }
}
