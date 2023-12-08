// To parse this JSON data, do
//
//     final getFoodListResponse = getFoodListResponseFromJson(jsonString);

import 'dart:convert';

GetFoodListResponse getFoodListResponseFromJson(String str) =>
    GetFoodListResponse.fromJson(json.decode(str));

String getFoodListResponseToJson(GetFoodListResponse data) =>
    json.encode(data.toJson());

class GetFoodListResponse {
  String error;
  String id;
  List<Food> foods;

  GetFoodListResponse({
    required this.error,
    required this.id,
    required this.foods,
  });

  factory GetFoodListResponse.fromJson(Map<String, dynamic> json) =>
      GetFoodListResponse(
        error: json["error"],
        id: json["id"],
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "id": id,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
      };
}

class Food {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int user;
  int restaurant;
  String name;
  int imageid;
  int? invenotory_stock;
  String price;
  String discountprice;
  String desc;
  int category;
  String ingredients;
  String unit;
  int packageCount;
  int weight;
  int canDelivery;
  int stars;
  int published;
  int extras;
  int nutritions;
  String? images;
  String? fileName;
  List<dynamic> variants;

  Food({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.restaurant,
    required this.name,
    required this.imageid,
    required this.price,
    required this.discountprice,
    required this.desc,
    required this.category,
    required this.ingredients,
    required this.unit,
    required this.packageCount,
    required this.weight,
    required this.canDelivery,
    required this.stars,
    required this.published,
    required this.extras,
    required this.nutritions,
    this.images,
    this.fileName,
    this.invenotory_stock,
    required this.variants,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"] ?? 0,
        invenotory_stock: json["invenotory_stock"] ?? 0,
        restaurant: json["restaurant"],
        name: json["name"],
        imageid: json["imageid"],
        price: json["price"],
        discountprice: json["discountprice"],
        desc: json["desc"],
        category: json["category"],
        ingredients: json["ingredients"],
        unit: json["unit"],
        packageCount: json["packageCount"],
        weight: json["weight"],
        canDelivery: json["canDelivery"],
        stars: json["stars"],
        published: json["published"],
        extras: json["extras"],
        nutritions: json["nutritions"],
        images: json["images"],
        fileName: json["filename"],
        variants: List<dynamic>.from(json["variants"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "restaurant": restaurant,
        "name": name,
        "imageid": imageid,
        "price": price,
        "discountprice": discountprice,
        "desc": desc,
        "category": category,
        "ingredients": ingredients,
        "unit": unit,
        "packageCount": packageCount,
        "weight": weight,
        "canDelivery": canDelivery,
        "stars": stars,
        "published": published,
        "extras": extras,
        "nutritions": nutritions,
        "images": images,
        "filename": fileName,
        "invenotory_stock": invenotory_stock,
        "variants": List<dynamic>.from(variants.map((x) => x)),
      };
}
