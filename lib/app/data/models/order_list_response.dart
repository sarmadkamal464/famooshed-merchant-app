// // // To parse this JSON data, do
// // //
// // //     final orderResponse = orderResponseFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // OrderResponse orderResponseFromJson(String str) =>
// //     OrderResponse.fromJson(json.decode(str));
// //
// // String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());
// //
// // class OrderResponse {
// //   String error;
// //   String id;
// //   double earning;
// //   int ordersCount;
// //   int userCount;
// //   List<Order> orders;
// //   List<OrderStatus> orderStatus;
// //   String currency;
// //   String rightSymbol;
// //   String distanceUnit;
// //   String googleApiKey;
// //   List<DriverInfo> drivers;
// //   List<ImageList> images;
// //
// //   OrderResponse({
// //     required this.error,
// //     required this.id,
// //     required this.earning,
// //     required this.ordersCount,
// //     required this.userCount,
// //     required this.orders,
// //     required this.orderStatus,
// //     required this.currency,
// //     required this.rightSymbol,
// //     required this.distanceUnit,
// //     required this.googleApiKey,
// //     required this.drivers,
// //     required this.images,
// //   });
// //
// //   factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
// //         error: json["error"],
// //         id: json["id"],
// //         earning: json["earning"]?.toDouble(),
// //         ordersCount: json["ordersCount"],
// //         userCount: json["userCount"],
// //         orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
// //         orderStatus: List<OrderStatus>.from(
// //             json["orderStatus"].map((x) => OrderStatus.fromJson(x))),
// //         currency: json["currency"],
// //         rightSymbol: json["rightSymbol"],
// //         distanceUnit: json["distanceUnit"],
// //         googleApiKey: json["googleApiKey"],
// //         drivers: List<DriverInfo>.from(
// //             json["drivers"].map((x) => DriverInfo.fromJson(x))),
// //         images: List<ImageList>.from(
// //             json["images"].map((x) => ImageList.fromJson(x))),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "error": error,
// //         "id": id,
// //         "earning": earning,
// //         "ordersCount": ordersCount,
// //         "userCount": userCount,
// //         "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
// //         "orderStatus": List<dynamic>.from(orderStatus.map((x) => x.toJson())),
// //         "currency": currency,
// //         "rightSymbol": rightSymbol,
// //         "distanceUnit": distanceUnit,
// //         "googleApiKey": googleApiKey,
// //         "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())),
// //         "images": List<dynamic>.from(images.map((x) => x.toJson())),
// //       };
// // }
// //
// // class DriverInfo {
// //   int id;
// //   String name;
// //   String email;
// //   dynamic emailVerifiedAt;
// //   dynamic isAdmin;
// //   String password;
// //   String? rememberToken;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   int? areain;
// //   String? vehicle;
// //   int role;
// //   int? imageid;
// //   String? address;
// //   String phone;
// //   dynamic token;
// //   String? fcbToken;
// //   int? active;
// //   String typeReg;
// //   String lat;
// //   String lng;
// //   String speed;
// //   dynamic stripeId;
// //   String? stripeAccId;
// //   String? bankId;
// //   dynamic driveFor;
// //   int? driverCommission;
// //   DateTime? dateOfBirth;
// //   String? idDocs;
// //   String? addiDocs;
// //   String? city;
// //   String? zipcode;
// //   String? country;
// //   dynamic cardBrand;
// //   dynamic cardLastFour;
// //   dynamic trialEndsAt;
// //
// //   DriverInfo({
// //     required this.id,
// //     required this.name,
// //     required this.email,
// //     this.emailVerifiedAt,
// //     this.isAdmin,
// //     required this.password,
// //     this.rememberToken,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     this.areain,
// //     this.vehicle,
// //     required this.role,
// //     this.imageid,
// //     this.address,
// //     required this.phone,
// //     this.token,
// //     this.fcbToken,
// //     this.active,
// //     required this.typeReg,
// //     required this.lat,
// //     required this.lng,
// //     required this.speed,
// //     this.stripeId,
// //     this.stripeAccId,
// //     this.bankId,
// //     this.driveFor,
// //     this.driverCommission,
// //     this.dateOfBirth,
// //     this.idDocs,
// //     this.addiDocs,
// //     this.city,
// //     this.zipcode,
// //     this.country,
// //     this.cardBrand,
// //     this.cardLastFour,
// //     this.trialEndsAt,
// //   });
// //
// //   factory DriverInfo.fromJson(Map<String, dynamic> json) => DriverInfo(
// //         id: json["id"],
// //         name: json["name"],
// //         email: json["email"] ?? "",
// //         emailVerifiedAt: json["email_verified_at"],
// //         isAdmin: json["is_admin"],
// //         password: json["password"] ?? '',
// //         rememberToken: json["remember_token"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //         areain: json["areain"],
// //         vehicle: json["vehicle"],
// //         role: json["role"],
// //         imageid: json["imageid"],
// //         address: json["address"],
// //         phone: json["phone"],
// //         token: json["_token"],
// //         fcbToken: json["fcbToken"],
// //         active: json["active"],
// //         typeReg: json["typeReg"],
// //         lat: json["lat"],
// //         lng: json["lng"],
// //         speed: json["speed"],
// //         stripeId: json["stripe_id"],
// //         stripeAccId: json["stripe_acc_id"],
// //         bankId: json["bank_id"],
// //         driveFor: json["drive_for"],
// //         driverCommission: json["driver_commission"],
// //         dateOfBirth: json["date_of_birth"] == null
// //             ? null
// //             : DateTime.parse(json["date_of_birth"]),
// //         idDocs: json["id_docs"],
// //         addiDocs: json["addi_docs"],
// //         city: json["city"],
// //         zipcode: json["zipcode"],
// //         country: json["country"],
// //         cardBrand: json["card_brand"],
// //         cardLastFour: json["card_last_four"],
// //         trialEndsAt: json["trial_ends_at"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "name": name,
// //         "email": email,
// //         "email_verified_at": emailVerifiedAt,
// //         "is_admin": isAdmin,
// //         "password": password,
// //         "remember_token": rememberToken,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //         "areain": areain,
// //         "vehicle": vehicle,
// //         "role": role,
// //         "imageid": imageid,
// //         "address": address,
// //         "phone": phone,
// //         "_token": token,
// //         "fcbToken": fcbToken,
// //         "active": active,
// //         "typeReg": typeReg,
// //         "lat": lat,
// //         "lng": lng,
// //         "speed": speed,
// //         "stripe_id": stripeId,
// //         "stripe_acc_id": stripeAccId,
// //         "bank_id": bankId,
// //         "drive_for": driveFor,
// //         "driver_commission": driverCommission,
// //         "date_of_birth":
// //             "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
// //         "id_docs": idDocs,
// //         "addi_docs": addiDocs,
// //         "city": city,
// //         "zipcode": zipcode,
// //         "country": country,
// //         "card_brand": cardBrand,
// //         "card_last_four": cardLastFour,
// //         "trial_ends_at": trialEndsAt,
// //       };
// // }
// //
// // class ImageList {
// //   int id;
// //   String filename;
// //
// //   ImageList({
// //     required this.id,
// //     required this.filename,
// //   });
// //
// //   factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
// //         id: json["id"],
// //         filename: json["filename"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "filename": filename,
// //       };
// // }
// //
// // class OrderStatus {
// //   int id;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   String status;
// //
// //   OrderStatus({
// //     required this.id,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.status,
// //   });
// //
// //   factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
// //         id: json["id"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //         status: json["status"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //         "status": status,
// //       };
// // }
// //
// // class Order {
// //   int id;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   int user;
// //   int driver;
// //   int status;
// //   String pstatus;
// //   String tax;
// //   String hint;
// //   int active;
// //   int restaurant;
// //   String method;
// //   String total;
// //   String fee;
// //   int send;
// //   String address;
// //   String phone;
// //   String lat;
// //   String lng;
// //   int percent;
// //   String curbsidePickup;
// //   dynamic arrived;
// //   String couponName;
// //   int commissionPay;
// //   dynamic imageProof;
// //   int perkm;
// //   int driverCommissionPay;
// //   String refundStatus;
// //   int refundAmount;
// //   String userName;
// //   List<OrdersDatum> ordersData;
// //   String addressDest;
// //   String latRest;
// //   String lngRest;
// //
// //   Order({
// //     required this.id,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.user,
// //     required this.driver,
// //     required this.status,
// //     required this.pstatus,
// //     required this.tax,
// //     required this.hint,
// //     required this.active,
// //     required this.restaurant,
// //     required this.method,
// //     required this.total,
// //     required this.fee,
// //     required this.send,
// //     required this.address,
// //     required this.phone,
// //     required this.lat,
// //     required this.lng,
// //     required this.percent,
// //     required this.curbsidePickup,
// //     this.arrived,
// //     required this.couponName,
// //     required this.commissionPay,
// //     this.imageProof,
// //     required this.perkm,
// //     required this.driverCommissionPay,
// //     required this.refundStatus,
// //     required this.refundAmount,
// //     required this.userName,
// //     required this.ordersData,
// //     required this.addressDest,
// //     required this.latRest,
// //     required this.lngRest,
// //   });
// //
// //   factory Order.fromJson(Map<String, dynamic> json) => Order(
// //         id: json["id"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //         user: json["user"],
// //         driver: json["driver"],
// //         status: json["status"],
// //         pstatus: json["pstatus"],
// //         tax: json["tax"],
// //         hint: json["hint"],
// //         active: json["active"],
// //         restaurant: json["restaurant"],
// //         method: json["method"],
// //         total: json["total"],
// //         fee: json["fee"],
// //         send: json["send"],
// //         address: json["address"],
// //         phone: json["phone"],
// //         lat: json["lat"],
// //         lng: json["lng"],
// //         percent: json["percent"],
// //         curbsidePickup: json["curbsidePickup"],
// //         arrived: json["arrived"],
// //         couponName: json["couponName"],
// //         commissionPay: json["commission_pay"],
// //         imageProof: json["image_proof"],
// //         perkm: json["perkm"],
// //         driverCommissionPay: json["driver_commission_pay"] ?? 0,
// //         refundStatus: json["refund_status"],
// //         refundAmount: json["refund_amount"],
// //         userName: json["userName"],
// //         ordersData: List<OrdersDatum>.from(
// //             json["ordersData"].map((x) => OrdersDatum.fromJson(x))),
// //         addressDest: json["addressDest"],
// //         latRest: json["latRest"],
// //         lngRest: json["lngRest"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //         "user": user,
// //         "driver": driver,
// //         "status": status,
// //         "pstatus": pstatus,
// //         "tax": tax,
// //         "hint": hint,
// //         "active": active,
// //         "restaurant": restaurant,
// //         "method": method,
// //         "total": total,
// //         "fee": fee,
// //         "send": send,
// //         "address": address,
// //         "phone": phone,
// //         "lat": lat,
// //         "lng": lng,
// //         "percent": percent,
// //         "curbsidePickup": curbsidePickup,
// //         "arrived": arrived,
// //         "couponName": couponName,
// //         "commission_pay": commissionPay,
// //         "image_proof": imageProof,
// //         "perkm": perkm,
// //         "driver_commission_pay": driverCommissionPay,
// //         "refund_status": refundStatus,
// //         "refund_amount": refundAmount,
// //         "userName": userName,
// //         "ordersData": List<dynamic>.from(ordersData.map((x) => x.toJson())),
// //         "addressDest": addressDest,
// //         "latRest": latRest,
// //         "lngRest": lngRest,
// //       };
// // }
// //
// // class OrdersDatum {
// //   int id;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   int order;
// //   String food;
// //   int count;
// //   String foodprice;
// //   String extras;
// //   int extrascount;
// //   String extrasprice;
// //   int foodid;
// //   int extrasid;
// //   String image;
// //
// //   OrdersDatum({
// //     required this.id,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.order,
// //     required this.food,
// //     required this.count,
// //     required this.foodprice,
// //     required this.extras,
// //     required this.extrascount,
// //     required this.extrasprice,
// //     required this.foodid,
// //     required this.extrasid,
// //     required this.image,
// //   });
// //
// //   factory OrdersDatum.fromJson(Map<String, dynamic> json) => OrdersDatum(
// //         id: json["id"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //         order: json["order"],
// //         food: json["food"],
// //         count: json["count"],
// //         foodprice: json["foodprice"],
// //         extras: json["extras"],
// //         extrascount: json["extrascount"],
// //         extrasprice: json["extrasprice"],
// //         foodid: json["foodid"],
// //         extrasid: json["extrasid"],
// //         image: json["image"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //         "order": order,
// //         "food": food,
// //         "count": count,
// //         "foodprice": foodprice,
// //         "extras": extras,
// //         "extrascount": extrascount,
// //         "extrasprice": extrasprice,
// //         "foodid": foodid,
// //         "extrasid": extrasid,
// //         "image": image,
// //       };
// // }
//
// // To parse this JSON data, do
// //
// //     final orderResponse = orderResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// OrderResponse orderResponseFromJson(String str) =>
//     OrderResponse.fromJson(json.decode(str));
//
// String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());
//
// class OrderResponse {
//   String? error;
//   String? id;
//   double? earning;
//   double? e1;
//   double? e2;
//   double? e3;
//   double? e4;
//   double? e5;
//   double? e6;
//   double? e7;
//   double? e8;
//   double? e9;
//   double? e10;
//   double? e11;
//   double? e12;
//   int? ordersCount;
//   int? userCount;
//   List<Order>? orders;
//   List<OrderStatus>? orderStatus;
//   String? currency;
//   String? rightSymbol;
//   String? distanceUnit;
//   String? googleApiKey;
//   List<Driver>? drivers;
//   List<Image>? images;
//
//   OrderResponse({
//     this.error,
//     this.id,
//     this.earning,
//     this.e1,
//     this.e2,
//     this.e3,
//     this.e4,
//     this.e5,
//     this.e6,
//     this.e7,
//     this.e8,
//     this.e9,
//     this.e10,
//     this.e11,
//     this.e12,
//     this.ordersCount,
//     this.userCount,
//     this.orders,
//     this.orderStatus,
//     this.currency,
//     this.rightSymbol,
//     this.distanceUnit,
//     this.googleApiKey,
//     this.drivers,
//     this.images,
//   });
//
//   factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
//         error: json["error"],
//         id: json["id"],
//         earning: (json["earning"] ?? 0).toDouble(),
//         e1: (json["e1"] ?? 0).toDouble(),
//         e2: (json["e2"] ?? 0).toDouble(),
//         e3: (json["e3"] ?? 0).toDouble(),
//         e4: (json["e4"] ?? 0).toDouble(),
//         e5: (json["e5"] ?? 0).toDouble(),
//         e6: (json["e6"] ?? 0).toDouble(),
//         e7: (json["e7"] ?? 0).toDouble(),
//         e8: (json["e8"] ?? 0).toDouble(),
//         e9: (json["e9"] ?? 0).toDouble(),
//         e10: (json["e10"] ?? 0).toDouble(),
//         e11: (json["e11"] ?? 0).toDouble(),
//         e12: (json["e12"] ?? 0).toDouble(),
//         ordersCount: json["ordersCount"],
//         userCount: json["userCount"],
//         orders: json["orders"] == null
//             ? []
//             : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
//         orderStatus: json["orderStatus"] == null
//             ? []
//             : List<OrderStatus>.from(
//                 json["orderStatus"]!.map((x) => OrderStatus.fromJson(x))),
//         currency: json["currency"],
//         rightSymbol: json["rightSymbol"],
//         distanceUnit: json["distanceUnit"],
//         googleApiKey: json["googleApiKey"],
//         drivers: json["drivers"] == null
//             ? []
//             : List<Driver>.from(
//                 json["drivers"]!.map((x) => Driver.fromJson(x))),
//         images: json["images"] == null
//             ? []
//             : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "id": id,
//         "earning": earning,
//         "ordersCount": ordersCount,
//         "userCount": userCount,
//         "orders": orders == null
//             ? []
//             : List<dynamic>.from(orders!.map((x) => x.toJson())),
//         "orderStatus": orderStatus == null
//             ? []
//             : List<dynamic>.from(orderStatus!.map((x) => x.toJson())),
//         "currency": currency,
//         "rightSymbol": rightSymbol,
//         "distanceUnit": distanceUnit,
//         "googleApiKey": googleApiKey,
//         "drivers": drivers == null
//             ? []
//             : List<dynamic>.from(drivers!.map((x) => x.toJson())),
//         "images": images == null
//             ? []
//             : List<dynamic>.from(images!.map((x) => x.toJson())),
//       };
// }
//
// class Driver {
//   int? id;
//   String? name;
//   int? imageid;
//   String? phone;
//   int? active;
//
//   Driver({
//     this.id,
//     this.name,
//     this.imageid,
//     this.phone,
//     this.active,
//   });
//
//   factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//         id: json["id"],
//         name: json["name"],
//         imageid: json["imageid"],
//         phone: json["phone"],
//         active: json["active"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "imageid": imageid,
//         "phone": phone,
//         "active": active,
//       };
// }
//
// class Image {
//   int? id;
//   String? filename;
//
//   Image({
//     this.id,
//     this.filename,
//   });
//
//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         filename: json["filename"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "filename": filename,
//       };
// }
//
// class OrderStatus {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? status;
//
//   OrderStatus({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.status,
//   });
//
//   factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
//         id: json["id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "status": status,
//       };
// }
//
// class Order {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? user;
//   int? driver;
//   int? status;
//   Pstatus? pstatus;
//   String? tax;
//   String? hint;
//   int? active;
//   int? restaurant;
//   String? method;
//   String? total;
//   String? fee;
//   int? send;
//   String? address;
//   String? phone;
//   String? lat;
//   String? lng;
//   int? percent;
//   String? curbsidePickup;
//   String? arrived;
//   CouponName? couponName;
//   int? commissionPay;
//   dynamic imageProof;
//   int? perkm;
//   int? driverCommissionPay;
//   String? refundStatus;
//   int? refundAmount;
//   OrderInPerson? orderInPerson;
//   String? vehiclename;
//   String? vehicalColor;
//   String? vehicalNumber;
//   OrderInPerson? pikFromMarket;
//   dynamic arrivalDate;
//   String? arrivalTime;
//   UserName? userName;
//   List<OrdersDatum>? ordersData;
//   AddressDest? addressDest;
//   String? latRest;
//   String? lngRest;
//
//   Order({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//     this.driver,
//     this.status,
//     this.pstatus,
//     this.tax,
//     this.hint,
//     this.active,
//     this.restaurant,
//     this.method,
//     this.total,
//     this.fee,
//     this.send,
//     this.address,
//     this.phone,
//     this.lat,
//     this.lng,
//     this.percent,
//     this.curbsidePickup,
//     this.arrived,
//     this.couponName,
//     this.commissionPay,
//     this.imageProof,
//     this.perkm,
//     this.driverCommissionPay,
//     this.refundStatus,
//     this.refundAmount,
//     this.orderInPerson,
//     this.vehiclename,
//     this.vehicalColor,
//     this.vehicalNumber,
//     this.pikFromMarket,
//     this.arrivalDate,
//     this.arrivalTime,
//     this.userName,
//     this.ordersData,
//     this.addressDest,
//     this.latRest,
//     this.lngRest,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         id: json["id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         user: json["user"],
//         driver: json["driver"],
//         status: json["status"],
//         pstatus: pstatusValues.map[json["pstatus"]]!,
//         tax: json["tax"],
//         hint: json["hint"],
//         active: json["active"],
//         restaurant: json["restaurant"],
//         method: json["method"],
//         total: json["total"],
//         fee: json["fee"],
//         send: json["send"],
//         address: json["address"],
//         phone: json["phone"],
//         lat: json["lat"],
//         lng: json["lng"],
//         percent: json["percent"],
//         curbsidePickup: json["curbsidePickup"],
//         arrived: json["arrived"],
//         couponName: couponNameValues.map[json["couponName"]]!,
//         commissionPay: json["commission_pay"],
//         imageProof: json["image_proof"],
//         perkm: json["perkm"],
//         driverCommissionPay: json["driver_commission_pay"],
//         refundStatus: json["refund_status"],
//         refundAmount: json["refund_amount"],
//         orderInPerson: orderInPersonValues.map[json["orderInPerson"]]!,
//         vehiclename: json["vehiclename"],
//         vehicalColor: json["vehicalColor"],
//         vehicalNumber: json["vehicalNumber"],
//         pikFromMarket: orderInPersonValues.map[json["pikFromMarket"]]!,
//         arrivalDate: json["arrivalDate"],
//         arrivalTime: json["arrivalTime"],
//         userName: userNameValues.map[json["userName"]]!,
//         ordersData: json["ordersData"] == null
//             ? []
//             : List<OrdersDatum>.from(
//                 json["ordersData"]!.map((x) => OrdersDatum.fromJson(x))),
//         addressDest: addressDestValues.map[json["addressDest"]]!,
//         latRest: json["latRest"],
//         lngRest: json["lngRest"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "user": user,
//         "driver": driver,
//         "status": status,
//         "pstatus": pstatusValues.reverse[pstatus],
//         "tax": tax,
//         "hint": hint,
//         "active": active,
//         "restaurant": restaurant,
//         "method": method,
//         "total": total,
//         "fee": fee,
//         "send": send,
//         "address": address,
//         "phone": phone,
//         "lat": lat,
//         "lng": lng,
//         "percent": percent,
//         "curbsidePickup": curbsidePickup,
//         "arrived": arrived,
//         "couponName": couponNameValues.reverse[couponName],
//         "commission_pay": commissionPay,
//         "image_proof": imageProof,
//         "perkm": perkm,
//         "driver_commission_pay": driverCommissionPay,
//         "refund_status": refundStatus,
//         "refund_amount": refundAmount,
//         "orderInPerson": orderInPersonValues.reverse[orderInPerson],
//         "vehiclename": vehiclename,
//         "vehicalColor": vehicalColor,
//         "vehicalNumber": vehicalNumber,
//         "pikFromMarket": orderInPersonValues.reverse[pikFromMarket],
//         "arrivalDate": arrivalDate,
//         "arrivalTime": arrivalTime,
//         "userName": userNameValues.reverse[userName],
//         "ordersData": ordersData == null
//             ? []
//             : List<dynamic>.from(ordersData!.map((x) => x.toJson())),
//         "addressDest": addressDestValues.reverse[addressDest],
//         "latRest": latRest,
//         "lngRest": lngRest,
//       };
// }
//
// enum AddressDest {
//   BINTON_HALL_BINTON_LANE_GU10_1_LG,
//   EMPTY,
//   FAMOOSHED_LINSTED_FARM_LINSTED_LANE_HEADLEY_GU35_8_SD_UK,
//   LINSTED_FARM_LINSTED_LANE_HEADLEY_GU35_8_SD_UK,
//   THE_1_WALL_STREET_LONDON,
//   THE_307_UXBRIDGE_RD_LONDON_W3_9_QU_UNITED_KINGDOM
// }
//
// final addressDestValues = EnumValues({
//   "Binton Hall, Binton Lane, GU10 1LG":
//       AddressDest.BINTON_HALL_BINTON_LANE_GU10_1_LG,
//   "": AddressDest.EMPTY,
//   "Famooshed, Linsted Farm, Linsted Lane, Headley, GU35 8SD,UK":
//       AddressDest.FAMOOSHED_LINSTED_FARM_LINSTED_LANE_HEADLEY_GU35_8_SD_UK,
//   "Linsted Farm,Linsted Lane, Headley, GU35 8SD,UK":
//       AddressDest.LINSTED_FARM_LINSTED_LANE_HEADLEY_GU35_8_SD_UK,
//   "1 Wall Street, London": AddressDest.THE_1_WALL_STREET_LONDON,
//   "307 Uxbridge Rd, London W3 9QU, United Kingdom":
//       AddressDest.THE_307_UXBRIDGE_RD_LONDON_W3_9_QU_UNITED_KINGDOM
// });
//
// enum ArrivalDateEnum { THE_00000000 }
//
// final arrivalDateEnumValues =
//     EnumValues({"0000-00-00": ArrivalDateEnum.THE_00000000});
//
// enum CouponName { EMPTY, SWEET20 }
//
// final couponNameValues =
//     EnumValues({"": CouponName.EMPTY, "sweet20": CouponName.SWEET20});
//
// enum OrderInPerson { EMPTY, NO, YES }
//
// final orderInPersonValues = EnumValues({
//   "": OrderInPerson.EMPTY,
//   "No": OrderInPerson.NO,
//   "Yes": OrderInPerson.YES
// });
//
// class OrdersDatum {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? order;
//   String? food;
//   int? count;
//   String? foodprice;
//   String? extras;
//   int? extrascount;
//   String? extrasprice;
//   int? foodid;
//   int? extrasid;
//   String? image;
//
//   OrdersDatum({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.order,
//     this.food,
//     this.count,
//     this.foodprice,
//     this.extras,
//     this.extrascount,
//     this.extrasprice,
//     this.foodid,
//     this.extrasid,
//     this.image,
//   });
//
//   factory OrdersDatum.fromJson(Map<String, dynamic> json) => OrdersDatum(
//         id: json["id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         order: json["order"],
//         food: json["food"],
//         count: json["count"],
//         foodprice: json["foodprice"],
//         extras: json["extras"],
//         extrascount: json["extrascount"],
//         extrasprice: json["extrasprice"],
//         foodid: json["foodid"],
//         extrasid: json["extrasid"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "order": order,
//         "food": food,
//         "count": count,
//         "foodprice": foodprice,
//         "extras": extras,
//         "extrascount": extrascount,
//         "extrasprice": extrasprice,
//         "foodid": foodid,
//         "extrasid": extrasid,
//         "image": image,
//       };
// }
//
// enum Pstatus { EMPTY, PAID, WAITING_FOR_CLIENT }
//
// final pstatusValues = EnumValues({
//   "": Pstatus.EMPTY,
//   "paid": Pstatus.PAID,
//   "Waiting for client": Pstatus.WAITING_FOR_CLIENT
// });
//
// enum UserName {
//   CODER_DEV,
//   CODER_DEVV,
//   FAMOOSHED,
//   MANDEEP_SINGH,
//   NIGHT_CODE,
//   S_IMON_FRANCE,
//   TRIDENT_SOLUTIONS,
//   WHOLE_MILK
// }
//
// final userNameValues = EnumValues({
//   "Coder Dev": UserName.CODER_DEV,
//   "Coder Devv": UserName.CODER_DEVV,
//   "famooshed": UserName.FAMOOSHED,
//   "Mandeep Singh": UserName.MANDEEP_SINGH,
//   "Night Code": UserName.NIGHT_CODE,
//   "SImon France": UserName.S_IMON_FRANCE,
//   "Trident Solutions": UserName.TRIDENT_SOLUTIONS,
//   "Whole Milk": UserName.WHOLE_MILK
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  String? error;
  String? id;
  double? earning;
  double? e1;
  double? e2;
  double? e3;
  double? e4;
  double? e5;
  double? e6;
  double? e7;
  double? e8;
  double? e9;
  double? e10;
  double? e11;
  double? e12;
  int? ordersCount;
  int? userCount;
  List<Order>? orders;
  List<OrderStatus>? orderStatus;
  String? currency;
  String? rightSymbol;
  String? distanceUnit;
  String? googleApiKey;
  List<Driver>? drivers;
  List<Image>? images;

  OrderResponse({
    this.error,
    this.id,
    this.earning,
    this.e1,
    this.e2,
    this.e3,
    this.e4,
    this.e5,
    this.e6,
    this.e7,
    this.e8,
    this.e9,
    this.e10,
    this.e11,
    this.e12,
    this.ordersCount,
    this.userCount,
    this.orders,
    this.orderStatus,
    this.currency,
    this.rightSymbol,
    this.distanceUnit,
    this.googleApiKey,
    this.drivers,
    this.images,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        error: json["error"],
        id: json["id"],
        earning: json["earning"]?.toDouble(),
        e1: (json["e1"] ?? 0)?.toDouble(),
        e2: (json["e2"] ?? 0).toDouble(),
        e3: (json["e3"] ?? 0)?.toDouble(),
        e4: (json["e4"] ?? 0).toDouble(),
        e5: (json["e5"] ?? 0).toDouble(),
        e6: (json["e6"] ?? 0)?.toDouble(),
        e7: (json["e7"] ?? 0)?.toDouble(),
        e8: (json["e8"] ?? 0)?.toDouble(),
        e9: (json["e9"] ?? 0).toDouble(),
        e10: (json["e10"] ?? 0).toDouble(),
        e11: (json["e11"] ?? 0).toDouble(),
        e12: (json["e12"] ?? 0).toDouble(),
        ordersCount: json["ordersCount"],
        userCount: json["userCount"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
        orderStatus: json["orderStatus"] == null
            ? []
            : List<OrderStatus>.from(
                json["orderStatus"]!.map((x) => OrderStatus.fromJson(x))),
        currency: json["currency"],
        rightSymbol: json["rightSymbol"],
        distanceUnit: json["distanceUnit"],
        googleApiKey: json["googleApiKey"],
        drivers: json["drivers"] == null
            ? []
            : List<Driver>.from(
                json["drivers"]!.map((x) => Driver.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "id": id,
        "earning": earning,
        "e1": e1,
        "e2": e2,
        "e3": e3,
        "e4": e4,
        "e5": e5,
        "e6": e6,
        "e7": e7,
        "e8": e8,
        "e9": e9,
        "e10": e10,
        "e11": e11,
        "e12": e12,
        "ordersCount": ordersCount,
        "userCount": userCount,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
        "orderStatus": orderStatus == null
            ? []
            : List<dynamic>.from(orderStatus!.map((x) => x.toJson())),
        "currency": currency,
        "rightSymbol": rightSymbol,
        "distanceUnit": distanceUnit,
        "googleApiKey": googleApiKey,
        "drivers": drivers == null
            ? []
            : List<dynamic>.from(drivers!.map((x) => x.toJson())),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Driver {
  int? id;
  String? name;
  int? imageid;
  String? phone;
  int? active;

  Driver({
    this.id,
    this.name,
    this.imageid,
    this.phone,
    this.active,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        imageid: json["imageid"],
        phone: json["phone"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageid": imageid,
        "phone": phone,
        "active": active,
      };
}

class Image {
  int? id;
  String? filename;

  Image({
    this.id,
    this.filename,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        filename: json["filename"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
      };
}

class OrderStatus {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  OrderStatus({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
      };
}

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? user;
  int? driver;
  int? driverAccepted;
  int? status;
  String? pstatus;
  String? tax;
  String? hint;
  int? active;
  int? restaurant;
  String? method;
  String? total;
  String? fee;
  int? send;
  String? address;
  String? phone;
  String? lat;
  String? lng;
  int? percent;
  String? curbsidePickup;
  dynamic arrived;
  String? couponName;
  String? discountAmount;
  int? commissionPay;
  dynamic imageProof;
  int? perkm;
  int? driverCommissionPay;
  String? refundStatus;
  int? refundAmount;
  String? orderInPerson;
  String? vehiclename;
  String? vehicalColor;
  String? vehicalNumber;
  String? pikFromMarket;
  String? arrivalDate;
  String? arrivalTime;
  dynamic comment;
  String? userName;
  List<OrdersDatum>? ordersData;
  String? addressDest;
  String? latRest;
  String? lngRest;
  String? subTotal;
  String? deliveryMethod;

  Order({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.driver,
    this.driverAccepted,
    this.status,
    this.pstatus,
    this.tax,
    this.hint,
    this.active,
    this.restaurant,
    this.method,
    this.total,
    this.fee,
    this.send,
    this.address,
    this.phone,
    this.lat,
    this.lng,
    this.percent,
    this.curbsidePickup,
    this.arrived,
    this.couponName,
    this.discountAmount,
    this.commissionPay,
    this.imageProof,
    this.perkm,
    this.driverCommissionPay,
    this.refundStatus,
    this.refundAmount,
    this.orderInPerson,
    this.vehiclename,
    this.vehicalColor,
    this.vehicalNumber,
    this.pikFromMarket,
    this.arrivalDate,
    this.arrivalTime,
    this.comment,
    this.userName,
    this.ordersData,
    this.addressDest,
    this.latRest,
    this.lngRest,
    this.subTotal,
    this.deliveryMethod,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"],
        driver: json["driver"],
        driverAccepted: json["driver_accepted"],
        status: json["status"],
        pstatus: json["pstatus"],
        tax: json["tax"],
        hint: json["hint"],
        active: json["active"],
        restaurant: json["restaurant"],
        method: json["method"],
        total: json["total"],
        fee: json["fee"],
        send: json["send"],
        address: json["address"],
        phone: json["phone"],
        lat: json["lat"],
        lng: json["lng"],
        percent: json["percent"],
        curbsidePickup: json["curbsidePickup"],
        arrived: json["arrived"],
        couponName: json["couponName"],
        discountAmount: json["discount_amount"],
        commissionPay: json["commission_pay"],
        imageProof: json["image_proof"],
        perkm: json["perkm"],
        driverCommissionPay: json["driver_commission_pay"],
        refundStatus: json["refund_status"],
        refundAmount: json["refund_amount"],
        orderInPerson: json["orderInPerson"],
        vehiclename: json["vehiclename"],
        vehicalColor: json["vehicalColor"],
        vehicalNumber: json["vehicalNumber"],
        pikFromMarket: json["pikFromMarket"],
        arrivalDate: json["arrivalDate"],
        arrivalTime: json["arrivalTime"],
        comment: json["comment"],
        userName: json["userName"],
        ordersData: json["ordersData"] == null
            ? []
            : List<OrdersDatum>.from(
                json["ordersData"]!.map((x) => OrdersDatum.fromJson(x))),
        addressDest: json["addressDest"],
        latRest: json["latRest"],
        lngRest: json["lngRest"],
        subTotal: json["subtotal"],
        deliveryMethod: json["delivery_method"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "driver": driver,
        "driver_accepted": driverAccepted,
        "status": status,
        "pstatus": pstatus,
        "tax": tax,
        "hint": hint,
        "active": active,
        "restaurant": restaurant,
        "method": method,
        "total": total,
        "fee": fee,
        "send": send,
        "address": address,
        "phone": phone,
        "lat": lat,
        "lng": lng,
        "percent": percent,
        "curbsidePickup": curbsidePickup,
        "arrived": arrived,
        "couponName": couponName,
        "discount_amount": discountAmount,
        "commission_pay": commissionPay,
        "image_proof": imageProof,
        "perkm": perkm,
        "driver_commission_pay": driverCommissionPay,
        "refund_status": refundStatus,
        "refund_amount": refundAmount,
        "orderInPerson": orderInPerson,
        "vehiclename": vehiclename,
        "vehicalColor": vehicalColor,
        "vehicalNumber": vehicalNumber,
        "pikFromMarket": pikFromMarket,
        "arrivalDate": arrivalDate,
        "arrivalTime": arrivalTime,
        "comment": comment,
        "userName": userName,
        "ordersData": ordersData == null
            ? []
            : List<dynamic>.from(ordersData!.map((x) => x.toJson())),
        "addressDest": addressDest,
        "latRest": latRest,
        "lngRest": lngRest,
        "subtotal": subTotal,
        "delivery_method": deliveryMethod,
      };
}

class OrdersDatum {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? order;
  String? food;
  int? count;
  String? foodprice;
  String? extras;
  int? extrascount;
  String? extrasprice;
  int? foodid;
  int? extrasid;
  String? image;

  OrdersDatum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.order,
    this.food,
    this.count,
    this.foodprice,
    this.extras,
    this.extrascount,
    this.extrasprice,
    this.foodid,
    this.extrasid,
    this.image,
  });

  factory OrdersDatum.fromJson(Map<String, dynamic> json) => OrdersDatum(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        order: json["order"],
        food: json["food"],
        count: json["count"],
        foodprice: json["foodprice"],
        extras: json["extras"],
        extrascount: json["extrascount"],
        extrasprice: json["extrasprice"],
        foodid: json["foodid"],
        extrasid: json["extrasid"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order": order,
        "food": food,
        "count": count,
        "foodprice": foodprice,
        "extras": extras,
        "extrascount": extrascount,
        "extrasprice": extrasprice,
        "foodid": foodid,
        "extrasid": extrasid,
        "image": image,
      };
}
