// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  int error;
  User? user;
  String? accessToken;
  int? notify;

  SignInResponse({
    required this.error,
    this.user,
    this.accessToken,
    this.notify,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        error: json["error"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        accessToken: json["access_token"],
        notify: json["notify"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "user": user!.toJson(),
        "access_token": accessToken,
        "notify": notify,
      };
}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic isAdmin;
  String password;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic areain;
  dynamic vehicle;
  int role;
  int imageid;
  String address;
  String phone;
  dynamic token;
  String fcbToken;
  int active;
  String typeReg;
  String lat;
  String lng;
  String speed;
  dynamic stripeId;
  dynamic bankId;
  dynamic driveFor;
  int driverCommission;
  dynamic dateOfBirth;
  String idDocs;
  String addiDocs;
  dynamic city;
  dynamic zipcode;
  dynamic country;
  String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    this.areain,
    this.vehicle,
    required this.role,
    required this.imageid,
    required this.address,
    required this.phone,
    this.token,
    required this.fcbToken,
    required this.active,
    required this.typeReg,
    required this.lat,
    required this.lng,
    required this.speed,
    this.stripeId,
    this.bankId,
    this.driveFor,
    required this.driverCommission,
    this.dateOfBirth,
    required this.idDocs,
    required this.addiDocs,
    this.city,
    this.zipcode,
    this.country,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        isAdmin: json["is_admin"],
        password: json["password"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        areain: json["areain"],
        vehicle: json["vehicle"],
        role: json["role"],
        imageid: json["imageid"] ?? 0,
        address: json["address"] ?? '',
        phone: json["phone"],
        token: json["_token"],
        fcbToken: json["fcbToken"] ?? '',
        active: json["active"],
        typeReg: json["typeReg"],
        lat: json["lat"],
        lng: json["lng"],
        speed: json["speed"],
        stripeId: json["stripe_id"],
        bankId: json["bank_id"],
        driveFor: json["drive_for"],
        driverCommission: json["driver_commission"] ?? 0,
        dateOfBirth: json["date_of_birth"],
        idDocs: json["id_docs"] ?? '',
        addiDocs: json["addi_docs"] ?? '',
        city: json["city"],
        zipcode: json["zipcode"],
        country: json["country"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "is_admin": isAdmin,
        "password": password,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
        "bank_id": bankId,
        "drive_for": driveFor,
        "driver_commission": driverCommission,
        "date_of_birth": dateOfBirth,
        "id_docs": idDocs,
        "addi_docs": addiDocs,
        "city": city,
        "zipcode": zipcode,
        "country": country,
        "avatar": avatar,
      };
}
