// To parse this JSON data, do
//
//     final getOwnerWalletResponse = getOwnerWalletResponseFromJson(jsonString);

import 'dart:convert';

GetOwnerWalletResponse getOwnerWalletResponseFromJson(String str) =>
    GetOwnerWalletResponse.fromJson(json.decode(str));

String getOwnerWalletResponseToJson(GetOwnerWalletResponse data) =>
    json.encode(data.toJson());

class GetOwnerWalletResponse {
  String error;
  int userscount;
  int orderscount;
  int restaurantsCount;
  double earning;
  double lastweekearning;
  double currentdayearning;
  double currentweekearning;
  String currency;
  List<Iorder> iorders;

  GetOwnerWalletResponse({
    required this.error,
    required this.userscount,
    required this.orderscount,
    required this.restaurantsCount,
    required this.earning,
    required this.lastweekearning,
    required this.currentdayearning,
    required this.currentweekearning,
    required this.currency,
    required this.iorders,
  });

  factory GetOwnerWalletResponse.fromJson(Map<String, dynamic> json) =>
      GetOwnerWalletResponse(
        error: json["error"],
        userscount: json["userscount"],
        orderscount: json["orderscount"],
        restaurantsCount: json["restaurantsCount"],
        earning: (json["earning"] ?? 0).toDouble(),
        lastweekearning: (json["lastweekearning"] ?? 0).toDouble(),
        currentdayearning: (json["currentdayearning"] ?? 0).toDouble(),
        currentweekearning: (json["currentweekearning"] ?? 0).toDouble(),
        currency: json["currency"],
        iorders:
            List<Iorder>.from(json["iorders"].map((x) => Iorder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "userscount": userscount,
        "orderscount": orderscount,
        "restaurantsCount": restaurantsCount,
        "earning": earning,
        "lastweekearning": lastweekearning,
        "currentdayearning": currentdayearning,
        "currentweekearning": currentweekearning,
        "currency": currency,
        "iorders": List<dynamic>.from(iorders.map((x) => x.toJson())),
      };
}

class Iorder {
  int id;
  String name;
  String total;
  String tax;
  String fee;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  Iorder({
    required this.id,
    required this.name,
    required this.total,
    required this.tax,
    required this.fee,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Iorder.fromJson(Map<String, dynamic> json) => Iorder(
        id: json["id"],
        name: json["name"],
        total: json["total"],
        tax: json["tax"],
        fee: json["fee"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total": total,
        "tax": tax,
        "fee": fee,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
      };
}
