// // // To parse this JSON data, do
// // //
// // //     final getMyDriverResponse = getMyDriverResponseFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // GetMyDriverResponse getMyDriverResponseFromJson(String str) =>
// //     GetMyDriverResponse.fromJson(json.decode(str));
// //
// // String getMyDriverResponseToJson(GetMyDriverResponse data) =>
// //     json.encode(data.toJson());
// //
// // class GetMyDriverResponse {
// //   String error;
// //   List<Driver> drivers;
// //
// //   GetMyDriverResponse({
// //     required this.error,
// //     required this.drivers,
// //   });
// //
// //   factory GetMyDriverResponse.fromJson(Map<String, dynamic> json) =>
// //       GetMyDriverResponse(
// //         error: json["error"],
// //         drivers:
// //             List<Driver>.from(json["category"].map((x) => Driver.fromJson(x))),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "error": error,
// //         "category": List<dynamic>.from(drivers.map((x) => x.toJson())),
// //       };
// // }
// //
// // class Driver {
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
// //   Driver({
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
// //   factory Driver.fromJson(Map<String, dynamic> json) => Driver(
// //         id: json["id"],
// //         name: json["name"],
// //         email: json["email"],
// //         emailVerifiedAt: json["email_verified_at"],
// //         isAdmin: json["is_admin"],
// //         password: json["password"],
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
//
// // To parse this JSON data, do
// //
// //     final getMyDriverResponse = getMyDriverResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// GetMyDriverResponse getMyDriverResponseFromJson(String str) =>
//     GetMyDriverResponse.fromJson(json.decode(str));
//
// String getMyDriverResponseToJson(GetMyDriverResponse data) =>
//     json.encode(data.toJson());
//
// class GetMyDriverResponse {
//   String? error;
//   List<Driver>? driversAll;
//
//   GetMyDriverResponse({
//     this.error,
//     this.driversAll,
//   });
//
//   factory GetMyDriverResponse.fromJson(Map<String, dynamic> json) =>
//       GetMyDriverResponse(
//         error: json["error"],
//         driversAll: json["driversAll"] == null
//             ? []
//             : List<Driver>.from(
//                 json["driversAll"]!.map((x) => Driver.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "error": error,
//         "driversAll": driversAll == null
//             ? []
//             : List<dynamic>.from(driversAll!.map((x) => x.toJson())),
//       };
// }
//
// class Driver {
//   int? id;
//   String? name;
//   String? email;
//   dynamic emailVerifiedAt;
//   dynamic isAdmin;
//   String? password;
//   dynamic rememberToken;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? merchantCategories;
//   int? areain;
//   String? vehicle;
//   int? role;
//   int? imageid;
//   String? address;
//   String? phone;
//   dynamic token;
//   String? fcbToken;
//   int? active;
//   String? typeReg;
//   String? lat;
//   String? lng;
//   String? speed;
//   dynamic stripeId;
//   String? stripeAccId;
//   dynamic bankId;
//   int? driveFor;
//   int? driverCommission;
//   DateTime? dateOfBirth;
//   dynamic idDocs;
//   dynamic addiDocs;
//   String? city;
//   String? zipcode;
//   String? country;
//   dynamic cardBrand;
//   dynamic cardLastFour;
//   dynamic trialEndsAt;
//
//   Driver({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.isAdmin,
//     this.password,
//     this.rememberToken,
//     this.createdAt,
//     this.updatedAt,
//     this.merchantCategories,
//     this.areain,
//     this.vehicle,
//     this.role,
//     this.imageid,
//     this.address,
//     this.phone,
//     this.token,
//     this.fcbToken,
//     this.active,
//     this.typeReg,
//     this.lat,
//     this.lng,
//     this.speed,
//     this.stripeId,
//     this.stripeAccId,
//     this.bankId,
//     this.driveFor,
//     this.driverCommission,
//     this.dateOfBirth,
//     this.idDocs,
//     this.addiDocs,
//     this.city,
//     this.zipcode,
//     this.country,
//     this.cardBrand,
//     this.cardLastFour,
//     this.trialEndsAt,
//   });
//
//   factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         emailVerifiedAt: json["email_verified_at"],
//         isAdmin: json["is_admin"],
//         password: json["password"],
//         rememberToken: json["remember_token"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         merchantCategories: json["merchant_categories"],
//         areain: json["areain"],
//         vehicle: json["vehicle"],
//         role: json["role"],
//         imageid: json["imageid"],
//         address: json["address"],
//         phone: json["phone"],
//         token: json["_token"],
//         fcbToken: json["fcbToken"],
//         active: json["active"],
//         typeReg: json["typeReg"],
//         lat: json["lat"],
//         lng: json["lng"],
//         speed: json["speed"],
//         stripeId: json["stripe_id"],
//         stripeAccId: json["stripe_acc_id"],
//         bankId: json["bank_id"],
//         driveFor: json["drive_for"],
//         driverCommission: json["driver_commission"],
//         dateOfBirth: json["date_of_birth"] == null
//             ? null
//             : DateTime.parse(json["date_of_birth"]),
//         idDocs: json["id_docs"],
//         addiDocs: json["addi_docs"],
//         city: json["city"],
//         zipcode: json["zipcode"],
//         country: json["country"],
//         cardBrand: json["card_brand"],
//         cardLastFour: json["card_last_four"],
//         trialEndsAt: json["trial_ends_at"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "email_verified_at": emailVerifiedAt,
//         "is_admin": isAdmin,
//         "password": password,
//         "remember_token": rememberToken,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "merchant_categories": merchantCategories,
//         "areain": areain,
//         "vehicle": vehicle,
//         "role": role,
//         "imageid": imageid,
//         "address": address,
//         "phone": phone,
//         "_token": token,
//         "fcbToken": fcbToken,
//         "active": active,
//         "typeReg": typeReg,
//         "lat": lat,
//         "lng": lng,
//         "speed": speed,
//         "stripe_id": stripeId,
//         "stripe_acc_id": stripeAccId,
//         "bank_id": bankId,
//         "drive_for": driveFor,
//         "driver_commission": driverCommission,
//         "date_of_birth":
//             "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
//         "id_docs": idDocs,
//         "addi_docs": addiDocs,
//         "city": city,
//         "zipcode": zipcode,
//         "country": country,
//         "card_brand": cardBrand,
//         "card_last_four": cardLastFour,
//         "trial_ends_at": trialEndsAt,
//       };
// }

// To parse this JSON data, do
//
//     final getMyDriverResponse = getMyDriverResponseFromJson(jsonString);

import 'dart:convert';

GetMyDriverResponse getMyDriverResponseFromJson(String str) =>
    GetMyDriverResponse.fromJson(json.decode(str));

String getMyDriverResponseToJson(GetMyDriverResponse data) =>
    json.encode(data.toJson());

class GetMyDriverResponse {
  String? error;
  List<Driver>? driversAll;
  List<Areawork>? areawork;

  GetMyDriverResponse({
    this.error,
    this.driversAll,
    this.areawork,
  });

  factory GetMyDriverResponse.fromJson(Map<String, dynamic> json) =>
      GetMyDriverResponse(
        error: json["error"],
        driversAll: json["driversAll"] == null
            ? []
            : List<Driver>.from(
                json["driversAll"]!.map((x) => Driver.fromJson(x))),
        areawork: json["areawork"] == null
            ? []
            : List<Areawork>.from(
                json["areawork"]!.map((x) => Areawork.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "driversAll": driversAll == null
            ? []
            : List<dynamic>.from(driversAll!.map((x) => x.toJson())),
        "areawork": areawork == null
            ? []
            : List<dynamic>.from(areawork!.map((x) => x.toJson())),
      };
}

class Areawork {
  int? id;
  String? areaName;
  DateTime? createdAt;
  int? publish;

  Areawork({
    this.id,
    this.areaName,
    this.createdAt,
    this.publish,
  });

  factory Areawork.fromJson(Map<String, dynamic> json) => Areawork(
        id: json["id"],
        areaName: json["area_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        publish: json["publish"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "area_name": areaName,
        "created_at": createdAt?.toIso8601String(),
        "publish": publish,
      };
}

class Driver {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic isAdmin;
  String? password;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? merchantCategories;
  int? areain;
  String? vehicle;
  int? role;
  int? imageid;
  String? address;
  String? phone;
  dynamic token;
  String? fcbToken;
  int? active;
  String? typeReg;
  String? lat;
  String? lng;
  String? speed;
  dynamic stripeId;
  String? stripeAccId;
  dynamic bankId;
  int? driveFor;
  int? driverCommission;
  DateTime? dateOfBirth;
  dynamic idDocs;
  dynamic addiDocs;
  String? city;
  String? zipcode;
  String? country;
  String? image;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;

  Driver({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.merchantCategories,
    this.areain,
    this.vehicle,
    this.role,
    this.imageid,
    this.address,
    this.phone,
    this.token,
    this.fcbToken,
    this.active,
    this.typeReg,
    this.lat,
    this.lng,
    this.speed,
    this.stripeId,
    this.stripeAccId,
    this.bankId,
    this.driveFor,
    this.driverCommission,
    this.dateOfBirth,
    this.idDocs,
    this.addiDocs,
    this.city,
    this.zipcode,
    this.country,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.image,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        merchantCategories: json["merchant_categories"],
        areain: json["areain"],
        vehicle: json["vehicle"],
        role: json["role"],
        imageid: json["imageid"],
        address: json["address"],
        phone: json["phone"],
        token: json["_token"],
        fcbToken: json["fcbToken"],
        active: json["active"],
        typeReg: json["typeReg"],
        lat: json["lat"],
        lng: json["lng"],
        speed: json["speed"],
        stripeId: json["stripe_id"],
        stripeAccId: json["stripe_acc_id"],
        bankId: json["bank_id"],
        driveFor: json["drive_for"],
        driverCommission: json["driver_commission"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        idDocs: json["id_docs"],
        addiDocs: json["addi_docs"],
        city: json["city"],
        zipcode: json["zipcode"],
        country: json["country"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "merchant_categories": merchantCategories,
        "areain": areain,
        "vehicle": vehicle,
        "role": role,
        "imageid": imageid,
        "address": address,
        "phone": phone,
        "_token": token,
        "fcbToken": fcbToken,
        "active": active,
        "typeReg": typeReg,
        "lat": lat,
        "lng": lng,
        "speed": speed,
        "stripe_id": stripeId,
        "stripe_acc_id": stripeAccId,
        "bank_id": bankId,
        "drive_for": driveFor,
        "driver_commission": driverCommission,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "id_docs": idDocs,
        "addi_docs": addiDocs,
        "city": city,
        "zipcode": zipcode,
        "country": country,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "image": image,
      };
}
