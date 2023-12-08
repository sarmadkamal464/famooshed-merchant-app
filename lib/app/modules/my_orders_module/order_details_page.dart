import 'package:famooshed_vendor/app/data/models/order_list_response.dart';
import 'package:famooshed_vendor/app/modules/my_orders_module/my_orders_controller.dart';
import 'package:famooshed_vendor/app/modules/my_orders_module/order_track.dart';
import 'package:famooshed_vendor/app/modules/widgets/custom_appbar_widget.dart';
import 'package:famooshed_vendor/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/util/exports.dart';
import '../../theme/size_config.dart';
import '../../utils/common_helper.dart';

class OrderDetailsPage extends GetView<MyOrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbarWidget(
            title: "Order Details",
            centerTitle: true,
            textColor: AppColors.appTheme),
        body: GetBuilder<MyOrdersController>(
          builder: (MyOrdersController controller) {
            return controller.currentOrder.id != null
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16),
                      vertical: getProportionateScreenHeight(8),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderId(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          statusInfo(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          controller.currentOrder.deliveryMethod != null &&
                                  controller.currentOrder.deliveryMethod ==
                                      'pickup'
                              ? curbSidePickUpInfo()
                              : driverInfo(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          customerInfo(),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Order Summary",
                              style: beVietnamProaBold.copyWith(
                                  color: AppColors.appTheme, fontSize: 20),
                            ),
                          ),
                          cartCard(controller.currentOrder),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: billCard(),
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox();
          },
        ));
  }

  Widget orderId() {
    String distance = '';
    if ((controller.currentOrder.lat != null &&
            controller.currentOrder.lat!.isNotEmpty) &&
        (controller.currentOrder.lng != null &&
            controller.currentOrder.lng!.isNotEmpty) &&
        (controller.currentOrder.latRest != null &&
            controller.currentOrder.latRest!.isNotEmpty) &&
        (controller.currentOrder.lngRest != null &&
            controller.currentOrder.lngRest!.isNotEmpty)) {
      var dis = calculateDistance(
          double.parse(controller.currentOrder.lat.toString()),
          double.parse(controller.currentOrder.lng.toString()),
          double.parse(controller.currentOrder.latRest.toString()),
          double.parse(controller.currentOrder.lngRest.toString()));
      dis = dis * 1000;
      double returnDouble = dis / 1609.344;
      distance = returnDouble.toStringAsFixed(2);
    }
    return Container(
      decoration: BoxDecoration(
          color: AppColors.blueColorLight,
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(
          "Order ID",
          style: beVietnamProaBold.copyWith(
              fontSize: 20, color: AppColors.appTheme),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("#${controller.currentOrder.id}",
                style: urbanistSemiBold.copyWith(
                    fontSize: 14, color: AppColors.appTheme)),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            controller.currentOrder.deliveryMethod != null &&
                    controller.currentOrder.deliveryMethod == 'pickup'
                ? SizedBox()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.black,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Expanded(
                            child: Text(
                              controller.currentOrder.address ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: urbanistSemiBold.copyWith(
                                  color: AppColors.black),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 3,
                        width: 3,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            top: getProportionateScreenHeight(5),
                            left: getProportionateScreenWidth(10)),
                        constraints: BoxConstraints(),
                        decoration: BoxDecoration(
                            color: AppColors.black, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 3,
                        width: 3,
                        margin: EdgeInsets.only(
                            top: getProportionateScreenHeight(8),
                            left: getProportionateScreenWidth(10),
                            bottom: getProportionateScreenHeight(8)),
                        decoration: BoxDecoration(
                            color: AppColors.black, shape: BoxShape.circle),
                      ),
                      Container(
                        height: 3,
                        width: 3,
                        margin: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(8),
                          left: getProportionateScreenWidth(10),
                        ),
                        decoration: BoxDecoration(
                            color: AppColors.black, shape: BoxShape.circle),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.navigation,
                            color: AppColors.black,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.currentOrder.addressDest ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: urbanistSemiBold,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(80),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      if ((controller.currentOrder.lat != null && controller.currentOrder.lat!.isNotEmpty) &&
                                          (controller.currentOrder.lng !=
                                                  null &&
                                              controller.currentOrder.lng!
                                                  .isNotEmpty) &&
                                          (controller.currentOrder.latRest !=
                                                  null &&
                                              controller.currentOrder.latRest!
                                                  .isNotEmpty) &&
                                          (controller.currentOrder.lngRest !=
                                                  null &&
                                              controller.currentOrder.lngRest!
                                                  .isNotEmpty)) {
                                        Navigator.push(Get.context!,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return OrderMapScreen(
                                                currentOrder:
                                                    controller.currentOrder);
                                          },
                                        ));
                                      } else {
                                        Utils.showSnackbar(
                                            "Address not available.");
                                      }
                                    },
                                    icon: Icon(
                                      Icons.near_me,
                                      size: 18,
                                    ),
                                    label: Text(
                                      "Map",
                                      style: urbanistSemiBold.copyWith(
                                        color: AppColors.white,
                                        fontSize: getProportionalFontSize(12),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.appTheme),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(8),
                      ),
                      Row(
                        children: [
                          Text("Distance:",
                              style: urbanistMedium.copyWith(
                                  fontSize: 14, color: AppColors.black)),
                          Text("${distance} miles",
                              style: urbanistSemiBold.copyWith(
                                  fontSize: 14, color: AppColors.appTheme)),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
        trailing: Icon(
          Icons.copy,
          color: AppColors.appTheme,
        ),
      ),
    );
  }

  Widget statusInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Status",
            style: beVietnamProaBold.copyWith(
                color: AppColors.appTheme, fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
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
                  validator: (value) {
                    if (value == null) {
                      return 'Please select status';
                    }
                    return null;
                  },
                  items: controller.orderStatus
                      .map(
                        (item) => DropdownMenuItem<OrderStatus>(
                          value: item,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.status.toString(),
                                style: TextStyle(
                                    fontSize: getProportionalFontSize(12),
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
                    controller.selectedStatus = T as OrderStatus;
                    controller.update();
                  },
                  value: controller.selectedStatus,
                  hint: const Text("Select Status"),
                  style: TextStyle(fontSize: getProportionalFontSize(12)),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(12),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.changeOrderStatus();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreen),
                child: Text(
                  "Save",
                  style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme,
                    fontSize: getProportionalFontSize(13),
                  ),
                ))
          ],
        ),
      ],
    );
  }

  Widget driverInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Driver",
            style: beVietnamProaBold.copyWith(
                color: AppColors.appTheme, fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonFormField<Driver>(
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
                  validator: (value) {
                    if (value == null) {
                      return 'Please select driver';
                    }
                    return null;
                  },
                  items: controller.drivers
                      .map(
                        (item) => DropdownMenuItem<Driver>(
                          value: item,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.name.toString(),
                                style: TextStyle(
                                    fontSize: getProportionalFontSize(12),
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
                    controller.selectedDriver = T as Driver;
                    controller.update();
                  },
                  value: controller.selectedDriver,
                  hint: const Text("Select Driver"),
                  style: TextStyle(fontSize: getProportionalFontSize(12)),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(12),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.changeDriverStatus();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreen),
                child: Text(
                  "Save",
                  style: beVietnamProaBold.copyWith(
                    color: AppColors.appTheme,
                    fontSize: getProportionalFontSize(13),
                  ),
                ))
          ],
        ),
      ],
    );
  }

  Widget curbSidePickUpInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Curbside Pickup",
            style: beVietnamProaBold.copyWith(
                color: AppColors.appTheme, fontSize: 20),
          ),
        ),
        Container(
          margin:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ]),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Arrival Date :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.arrivalDate ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Arrival Date :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.arrivalTime ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Comments :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.comment ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget customerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Customer Info",
            style: beVietnamProaBold.copyWith(
                color: AppColors.appTheme, fontSize: 20),
          ),
        ),
        Container(
          margin:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                )
              ]),
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Client :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.userName ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Client Phone :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.phone ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Client Address :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.address ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Details :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.method ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Comments :",
                          style: beVietnamProSemiBold.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${controller.currentOrder.comment ?? '-'}",
                          style: urbanistMedium.copyWith(
                              fontSize: 14, color: AppColors.appTheme),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ],
    );
  }

  Widget cartCard(Order orderDetails) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ]),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "${orderDetails.userName ?? '-'}",
                  style: beVietnamProaBold.copyWith(
                      fontSize: 20, color: AppColors.appTheme),
                ),
                trailing: Text(
                  "${orderDetails.ordersData != null && orderDetails.ordersData!.isNotEmpty ? orderDetails.ordersData!.length : 0} Items",
                  style: urbanistMedium.copyWith(
                      fontSize: 16, color: AppColors.appTheme),
                ),
              ),
              const Divider(thickness: 2),
              orderDetails.ordersData != null &&
                      orderDetails.ordersData!.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: orderDetails.ordersData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = orderDetails.ordersData![index];
                        return cartItem(data);
                      },
                    )
                  : SizedBox(),
            ],
          )),
    );
  }

  Widget cartItem(OrdersDatum detail) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(detail.image.toString()),
      ),
      title: Text(
        "${detail.food ?? '-'}".capitalize.toString(),
        style: beVietnamProSemiBold.copyWith(
            fontSize: 18, color: AppColors.appTheme),
      ),
      subtitle: Text(
        "Price : £${detail.foodprice}",
        style:
            urbanistSemiBold.copyWith(fontSize: 14, color: AppColors.greyText),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // InkWell(
          //   onTap: () {
          //     controller.decrement(detail);
          //   },
          //   child: const Icon(
          //     Icons.remove_circle_outline,
          //     color: AppColors.appTheme,
          //     size: 18,
          //   ),
          // ),
          // const SizedBox(width: 10),
          Text('${detail.count}',
              style: beVietnamProaBold24.copyWith(
                  fontSize: 16, color: AppColors.appTheme)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget billCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: HexColor('EBF9DC').withOpacity(.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          billItems("Subtotal", "£${controller.currentOrder.subTotal ?? ''}"),
          const Divider(
            thickness: 2,
          ),
          billItems(
              "Discount", "£${controller.currentOrder.discountAmount ?? ''}"),
          const Divider(
            thickness: 2,
          ),
          billItems("Shipping", "£${controller.currentOrder.fee ?? ''}"),
          const Divider(
            thickness: 2,
          ),
          // billItems("Tax ", "${controller.taxAmount}"),
          // const Divider(
          //   thickness: 2,
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          style: urbanistSemiBold.copyWith(
                              color: AppColors.appTheme, fontSize: 16),
                          text: "Total ",
                          children: [
                            TextSpan(
                              text:
                                  "(${controller.currentOrder.ordersData != null ? controller.currentOrder.ordersData!.length : 0} Items)",
                              style: urbanistBold.copyWith(
                                  fontSize: 16,
                                  color: "#215034".fromHex.withOpacity(.5)),
                            )
                          ])
                    ])),
                Text(
                  "£${controller.currentOrder.total ?? ''}",
                  style: urbanistBold.copyWith(color: HexColor("#215034")),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  billItems(title, value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: urbanistSemiBold.copyWith(
                color: AppColors.appTheme, fontSize: 16),
          ),
          Text(
            value,
            style: urbanistBold.copyWith(
                fontSize: 16, color: HexColor("215034").withOpacity(.5)),
          ),
        ],
      ),
    );
  }
}
