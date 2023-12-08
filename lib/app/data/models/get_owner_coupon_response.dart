import 'dart:convert';

GetOwnerCouponResponse getOwnerCouponResponseFromJson(String str) =>
    GetOwnerCouponResponse.fromJson(json.decode(str));

String getOwnerCouponResponseToJson(GetOwnerCouponResponse data) =>
    json.encode(data.toJson());

class GetOwnerCouponResponse {
  String error;
  List<CouponInfo> restaurants;

  GetOwnerCouponResponse({
    required this.error,
    required this.restaurants,
  });

  factory GetOwnerCouponResponse.fromJson(Map<String, dynamic> json) =>
      GetOwnerCouponResponse(
        error: json["error"],
        restaurants: List<CouponInfo>.from(
            json["restaurants"].map((x) => CouponInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class CouponInfo {
  int id;
  String name;
  String discount;
  String desc;
  String minamount;
  DateTime dateStart;
  DateTime dateEnd;
  int published;
  int inpercents;
  int allCategory;
  int allFoods;
  CouponInfo({
    required this.id,
    required this.name,
    required this.discount,
    required this.desc,
    required this.minamount,
    required this.dateStart,
    required this.dateEnd,
    required this.published,
    required this.inpercents,
    required this.allCategory,
    required this.allFoods,
  });

  factory CouponInfo.fromJson(Map<String, dynamic> json) => CouponInfo(
        id: json["id"],
        name: json["name"],
        discount: json["discount"],
        desc: json["desc"],
        minamount: json["minamount"],
        dateStart: DateTime.parse(json["dateStart"]),
        dateEnd: DateTime.parse(json["dateEnd"]),
        published: json["published"],
        inpercents: json["inpercents"],
        allCategory: json["allCategory"] ?? 0,
        allFoods: json["allFoods"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "discount": discount,
        "desc": desc,
        "minamount": minamount,
        "dateStart": dateStart.toIso8601String(),
        "dateEnd": dateEnd.toIso8601String(),
        "published": published,
        "inpercents": inpercents,
        "allCategory": allCategory,
        "allFoods": allFoods,
      };
}
