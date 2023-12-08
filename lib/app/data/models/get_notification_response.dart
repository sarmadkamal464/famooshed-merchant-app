// // To parse this JSON data, do
// //
// //     final getNotificationResponse = getNotificationResponseFromJson(jsonString);
//
// // import 'dart:convert';
// //
// // GetNotificationResponse getNotificationResponseFromJson(String str) =>
// //     GetNotificationResponse.fromJson(json.decode(str));
// //
// // String getNotificationResponseToJson(GetNotificationResponse data) =>
// //     json.encode(data.toJson());
// //
// // class GetNotificationResponse {
// //   NotoficationData notoficationData;
// //
// //   GetNotificationResponse({
// //     required this.notoficationData,
// //   });
// //
// //   factory GetNotificationResponse.fromJson(Map<String, dynamic> json) =>
// //       GetNotificationResponse(
// //         notoficationData: NotoficationData.fromJson(json["idata"]),
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "idata": notoficationData.toJson(),
// //       };
// // }
// //
// // class NotoficationData {
// //   int currentPage;
// //   List<NotoficationDataItem> notoficationDataItem;
// //   String firstPageUrl;
// //   int from;
// //   int lastPage;
// //   String lastPageUrl;
// //   String nextPageUrl;
// //   String path;
// //   int perPage;
// //   dynamic prevPageUrl;
// //   int to;
// //   int total;
// //
// //   NotoficationData({
// //     required this.currentPage,
// //     required this.notoficationDataItem,
// //     required this.firstPageUrl,
// //     required this.from,
// //     required this.lastPage,
// //     required this.lastPageUrl,
// //     required this.nextPageUrl,
// //     required this.path,
// //     required this.perPage,
// //     this.prevPageUrl,
// //     required this.to,
// //     required this.total,
// //   });
// //
// //   factory NotoficationData.fromJson(Map<String, dynamic> json) =>
// //       NotoficationData(
// //         currentPage: json["current_page"],
// //         notoficationDataItem: List<NotoficationDataItem>.from(
// //             json["data"].map((x) => NotoficationDataItem.fromJson(x))),
// //         firstPageUrl: json["first_page_url"],
// //         from: json["from"],
// //         lastPage: json["last_page"],
// //         lastPageUrl: json["last_page_url"],
// //         nextPageUrl: json["next_page_url"],
// //         path: json["path"],
// //         perPage: json["per_page"],
// //         prevPageUrl: json["prev_page_url"],
// //         to: json["to"],
// //         total: json["total"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "current_page": currentPage,
// //         "data": List<dynamic>.from(notoficationDataItem.map((x) => x.toJson())),
// //         "first_page_url": firstPageUrl,
// //         "from": from,
// //         "last_page": lastPage,
// //         "last_page_url": lastPageUrl,
// //         "next_page_url": nextPageUrl,
// //         "path": path,
// //         "per_page": perPage,
// //         "prev_page_url": prevPageUrl,
// //         "to": to,
// //         "total": total,
// //       };
// // }
// //
// // class NotoficationDataItem {
// //   int id;
// //   DateTime createdAt;
// //   DateTime updatedAt;
// //   int user;
// //   String title;
// //   String text;
// //   String image;
// //   int show;
// //   int read;
// //   String uid;
// //   String delete;
// //   int countAll;
// //   int countRead;
// //
// //   NotoficationDataItem({
// //     required this.id,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.user,
// //     required this.title,
// //     required this.text,
// //     required this.image,
// //     required this.show,
// //     required this.read,
// //     required this.uid,
// //     required this.delete,
// //     required this.countAll,
// //     required this.countRead,
// //   });
// //
// //   factory NotoficationDataItem.fromJson(Map<String, dynamic> json) =>
// //       NotoficationDataItem(
// //         id: json["id"],
// //         createdAt: DateTime.parse(json["created_at"]),
// //         updatedAt: DateTime.parse(json["updated_at"]),
// //         user: json["user"],
// //         title: json["title"],
// //         text: json["text"],
// //         image: json["image"],
// //         show: json["show"],
// //         read: json["read"],
// //         uid: json["uid"],
// //         delete: json["delete"],
// //         countAll: json["countAll"],
// //         countRead: json["countRead"],
// //       );
// //
// //   Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "created_at": createdAt.toIso8601String(),
// //         "updated_at": updatedAt.toIso8601String(),
// //         "user": user,
// //         "title": title,
// //         "text": text,
// //         "image": image,
// //         "show": show,
// //         "read": read,
// //         "uid": uid,
// //         "delete": delete,
// //         "countAll": countAll,
// //         "countRead": countRead,
// //       };
// // }
//
// // To parse this JSON data, do
// //
// //     final getNotificationResponse = getNotificationResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// GetNotificationResponse getNotificationResponseFromJson(String str) =>
//     GetNotificationResponse.fromJson(json.decode(str));
//
// String getNotificationResponseToJson(GetNotificationResponse data) =>
//     json.encode(data.toJson());
//
// class GetNotificationResponse {
//   Idata? idata;
//   List<Iuser>? iusers;
//   String? texton;
//   String? text;
//   String? defaultImage;
//   String? defaultImageId;
//   int? filesize;
//   List<Petani>? petani;
//
//   GetNotificationResponse({
//     this.idata,
//     this.iusers,
//     this.texton,
//     this.text,
//     this.defaultImage,
//     this.defaultImageId,
//     this.filesize,
//     this.petani,
//   });
//
//   factory GetNotificationResponse.fromJson(Map<String, dynamic> json) =>
//       GetNotificationResponse(
//         idata: json["idata"] == null ? null : Idata.fromJson(json["idata"]),
//         iusers: json["iusers"] == null
//             ? []
//             : List<Iuser>.from(json["iusers"]!.map((x) => Iuser.fromJson(x))),
//         texton: json["texton"],
//         text: json["text"],
//         defaultImage: json["defaultImage"],
//         defaultImageId: json["defaultImageId"],
//         filesize: json["filesize"],
//         petani: json["petani"] == null
//             ? []
//             : List<Petani>.from(json["petani"]!.map((x) => Petani.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "idata": idata?.toJson(),
//         "iusers": iusers == null
//             ? []
//             : List<dynamic>.from(iusers!.map((x) => x.toJson())),
//         "texton": texton,
//         "text": text,
//         "defaultImage": defaultImage,
//         "defaultImageId": defaultImageId,
//         "filesize": filesize,
//         "petani": petani == null
//             ? []
//             : List<dynamic>.from(petani!.map((x) => x.toJson())),
//       };
// }
//
// class Idata {
//   int? currentPage;
//   List<NotoficationDataItem>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;
//
//   Idata({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   factory Idata.fromJson(Map<String, dynamic> json) => Idata(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<NotoficationDataItem>.from(
//                 json["data"]!.map((x) => NotoficationDataItem.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }
//
// class NotoficationDataItem {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? user;
//   String? title;
//   String? text;
//   String? image;
//   String? imageName;
//   int? show;
//   int? read;
//   String? uid;
//   String? delete;
//   String? scheduleTime;
//   int? authUser;
//   int? countAll;
//   int? countRead;
//
//   NotoficationDataItem({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//     this.title,
//     this.text,
//     this.image,
//     this.imageName,
//     this.show,
//     this.read,
//     this.uid,
//     this.delete,
//     this.scheduleTime,
//     this.authUser,
//     this.countAll,
//     this.countRead,
//   });
//
//   factory NotoficationDataItem.fromJson(Map<String, dynamic> json) =>
//       NotoficationDataItem(
//         id: json["id"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         user: json["user"],
//         title: json["title"],
//         text: json["text"],
//         image: json["image"],
//         imageName: json["imageName"],
//         show: json["show"],
//         read: json["read"],
//         uid: json["uid"],
//         delete: json["delete"],
//         scheduleTime: json["Schedule_time"],
//         authUser: json["auth_user"],
//         countAll: json["countAll"],
//         countRead: json["countRead"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "user": user,
//         "title": title,
//         "text": text,
//         "image": image,
//         "show": show,
//         "read": read,
//         "uid": uid,
//         "delete": delete,
//         "Schedule_time": scheduleTime,
//         "auth_user": authUser,
//         "countAll": countAll,
//         "countRead": countRead,
//       };
// }
//
// class Iuser {
//   int? id;
//   String? name;
//   String? email;
//   dynamic emailVerifiedAt;
//   dynamic isAdmin;
//   String? password;
//   String? rememberToken;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? merchantCategories;
//   dynamic areain;
//   dynamic vehicle;
//   int? role;
//   int? imageid;
//   String? address;
//   String? phone;
//   dynamic token;
//   String? fcbToken;
//   int? active;
//   TypeReg? typeReg;
//   String? lat;
//   String? lng;
//   String? speed;
//   String? stripeId;
//   dynamic stripeAccId;
//   dynamic bankId;
//   dynamic driveFor;
//   int? driverCommission;
//   DateTime? dateOfBirth;
//   String? idDocs;
//   String? addiDocs;
//   dynamic city;
//   dynamic zipcode;
//   dynamic country;
//   dynamic cardBrand;
//   dynamic cardLastFour;
//   dynamic trialEndsAt;
//
//   Iuser({
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
//   factory Iuser.fromJson(Map<String, dynamic> json) => Iuser(
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
//         typeReg: typeRegValues.map[json["typeReg"]]!,
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
//         "typeReg": typeRegValues.reverse[typeReg],
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
//
// enum TypeReg { APPLE, EMAIL, FACEBOOK, GOOGLE }
//
// final typeRegValues = EnumValues({
//   "apple": TypeReg.APPLE,
//   "email": TypeReg.EMAIL,
//   "facebook": TypeReg.FACEBOOK,
//   "google": TypeReg.GOOGLE
// });
//
// class Petani {
//   int? id;
//   String? filename;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Petani({
//     this.id,
//     this.filename,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Petani.fromJson(Map<String, dynamic> json) => Petani(
//         id: json["id"],
//         filename: json["filename"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "filename": filename,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
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
//     final getNotificationResponse = getNotificationResponseFromJson(jsonString);
// To parse this JSON data, do
//
//     final getNotificationResponse = getNotificationResponseFromJson(jsonString);

import 'dart:convert';

GetNotificationResponse getNotificationResponseFromJson(String str) =>
    GetNotificationResponse.fromJson(json.decode(str));

String getNotificationResponseToJson(GetNotificationResponse data) =>
    json.encode(data.toJson());

class GetNotificationResponse {
  Idata? idata;
  List<NotificationDriverUser>? iusers;
  String? texton;
  String? text;
  String? defaultImage;
  String? defaultImageId;
  int? filesize;
  List<Petani>? petani;

  GetNotificationResponse({
    this.idata,
    this.iusers,
    this.texton,
    this.text,
    this.defaultImage,
    this.defaultImageId,
    this.filesize,
    this.petani,
  });

  factory GetNotificationResponse.fromJson(Map<String, dynamic> json) =>
      GetNotificationResponse(
        idata: json["idata"] == null ? null : Idata.fromJson(json["idata"]),
        iusers: json["drivers"] == null
            ? []
            : List<NotificationDriverUser>.from(json["drivers"]!
                .map((x) => NotificationDriverUser.fromJson(x))),
        texton: json["texton"],
        text: json["text"],
        defaultImage: json["defaultImage"],
        defaultImageId: json["defaultImageId"],
        filesize: json["filesize"],
        petani: json["petani"] == null
            ? []
            : List<Petani>.from(json["petani"]!.map((x) => Petani.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idata": idata?.toJson(),
        "drivers": iusers == null
            ? []
            : List<dynamic>.from(iusers!.map((x) => x.toJson())),
        "texton": texton,
        "text": text,
        "defaultImage": defaultImage,
        "defaultImageId": defaultImageId,
        "filesize": filesize,
        "petani": petani == null
            ? []
            : List<dynamic>.from(petani!.map((x) => x.toJson())),
      };
}

class Idata {
  int? currentPage;
  List<NotoficationDataItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Idata({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Idata.fromJson(Map<String, dynamic> json) => Idata(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<NotoficationDataItem>.from(
                json["data"]!.map((x) => NotoficationDataItem.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class NotoficationDataItem {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? user;
  String? title;
  String? text;
  String? image;
  int? show;
  int? read;
  String? uid;
  String? delete;
  String? scheduleTime;
  int? authUser;
  int? countAll;
  int? countRead;
  String? imageName;

  NotoficationDataItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.title,
    this.text,
    this.image,
    this.show,
    this.read,
    this.uid,
    this.delete,
    this.scheduleTime,
    this.authUser,
    this.countAll,
    this.countRead,
    this.imageName,
  });

  factory NotoficationDataItem.fromJson(Map<String, dynamic> json) =>
      NotoficationDataItem(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"],
        title: json["title"],
        text: json["text"],
        image: json["image"],
        show: json["show"],
        read: json["read"],
        uid: json["uid"],
        delete: json["delete"],
        scheduleTime: json["Schedule_time"],
        authUser: json["auth_user"],
        countAll: json["countAll"],
        countRead: json["countRead"],
        imageName: json["imageName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user,
        "title": title,
        "text": text,
        "image": image,
        "show": show,
        "read": read,
        "uid": uid,
        "delete": delete,
        "Schedule_time": scheduleTime,
        "auth_user": authUser,
        "countAll": countAll,
        "countRead": countRead,
        "imageName": imageName,
      };
}

class NotificationDriverUser {
  int? id;
  String? name;
  String? email;
  int? active;

  NotificationDriverUser({
    this.id,
    this.name,
    this.email,
    this.active,
  });

  factory NotificationDriverUser.fromJson(Map<String, dynamic> json) =>
      NotificationDriverUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "active": active,
      };
}

enum TypeReg { APPLE, EMAIL, FACEBOOK, GOOGLE }

final typeRegValues = EnumValues({
  "apple": TypeReg.APPLE,
  "email": TypeReg.EMAIL,
  "facebook": TypeReg.FACEBOOK,
  "google": TypeReg.GOOGLE
});

class Petani {
  int? id;
  String? filename;
  DateTime? createdAt;
  DateTime? updatedAt;

  Petani({
    this.id,
    this.filename,
    this.createdAt,
    this.updatedAt,
  });

  factory Petani.fromJson(Map<String, dynamic> json) => Petani(
        id: json["id"],
        filename: json["filename"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
