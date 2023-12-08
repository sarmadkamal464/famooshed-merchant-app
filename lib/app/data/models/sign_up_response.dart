// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  int? error;
  User? user;
  String? accessToken;
  int? notify;

  SignUpResponse({
    this.error,
    this.user,
    this.accessToken,
    this.notify,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        error: json["error"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"],
        notify: json["notify"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "user": user?.toJson(),
        "access_token": accessToken,
        "notify": notify,
      };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic isAdmin;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? merchantCategories;
  dynamic areain;
  dynamic vehicle;
  int? role;
  String? driverType;
  dynamic imageid;
  dynamic address;
  String? phone;
  dynamic token;
  dynamic fcbToken;
  int? active;
  String? typeReg;
  String? lat;
  String? lng;
  String? speed;
  dynamic stripeId;
  String? stripeAccId;
  dynamic bankId;
  dynamic driveFor;
  dynamic driverCommission;
  dynamic dateOfBirth;
  dynamic idDocs;
  dynamic addiDocs;
  dynamic city;
  dynamic zipcode;
  dynamic country;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  String? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.merchantCategories,
    this.areain,
    this.vehicle,
    this.role,
    this.driverType,
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
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"],
        password: json["password"],
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
        driverType: json["driver_type"],
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
        dateOfBirth: json["date_of_birth"],
        idDocs: json["id_docs"],
        addiDocs: json["addi_docs"],
        city: json["city"],
        zipcode: json["zipcode"],
        country: json["country"],
        cardBrand: json["card_brand"],
        cardLastFour: json["card_last_four"],
        trialEndsAt: json["trial_ends_at"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin,
        "password": password,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "merchant_categories": merchantCategories,
        "areain": areain,
        "vehicle": vehicle,
        "role": role,
        "driver_type": driverType,
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
        "date_of_birth": dateOfBirth,
        "id_docs": idDocs,
        "addi_docs": addiDocs,
        "city": city,
        "zipcode": zipcode,
        "country": country,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "avatar": avatar,
      };
}
