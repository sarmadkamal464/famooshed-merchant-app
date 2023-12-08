// To parse this JSON data, do
//
//     final getFoodDetailResponse = getFoodDetailResponseFromJson(jsonString);

import 'dart:convert';

GetFoodDetailResponse getFoodDetailResponseFromJson(String str) =>
    GetFoodDetailResponse.fromJson(json.decode(str));

String getFoodDetailResponseToJson(GetFoodDetailResponse data) =>
    json.encode(data.toJson());

class GetFoodDetailResponse {
  String? error;
  String? id;
  String? image;
  String? defaultTax;
  String? currency;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? imageid;
  String? price;
  String? discountprice;
  String? desc;
  int? restaurant;
  int? category;
  String? ingredients;
  String? subCategory;
  String? unit;
  String? packageCount;
  String? weight;
  int? canDelivery;
  int? stars;
  int? published;
  int? extras;
  int? nutritions;
  List<String>? images;
  String? restaurantName;
  String? restaurantPhone;
  String? restaurantMobilePhone;
  String? fee;
  int? percent;
  int? merchantCommission;
  List<Foodsreview>? foodsreviews;
  List<Variant>? variants;
  List<SimilarFood>? similarFood;

  GetFoodDetailResponse({
    this.error,
    this.id,
    this.image,
    this.defaultTax,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageid,
    this.price,
    this.discountprice,
    this.desc,
    this.restaurant,
    this.category,
    this.ingredients,
    this.unit,
    this.packageCount,
    this.weight,
    this.canDelivery,
    this.stars,
    this.published,
    this.extras,
    this.nutritions,
    this.images,
    this.restaurantName,
    this.restaurantPhone,
    this.restaurantMobilePhone,
    this.fee,
    this.percent,
    this.merchantCommission,
    this.foodsreviews,
    this.variants,
    this.similarFood,
    this.subCategory,
  });

  factory GetFoodDetailResponse.fromJson(Map<String, dynamic> json) =>
      GetFoodDetailResponse(
        error: json["error"],
        id: json["id"],
        image: json["image"],
        defaultTax: json["default_tax"],
        currency: json["currency"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        imageid: json["imageid"],
        price: json["price"],
        discountprice: json["discountprice"],
        desc: json["desc"],
        restaurant: json["restaurant"],
        category: json["category"],
        ingredients: json["ingredients"],
        unit: json["unit"],
        packageCount: json["packageCount"].toString(),
        weight: json["weight"].toString(),
        canDelivery: json["canDelivery"],
        stars: json["stars"],
        published: json["published"],
        extras: json["extras"],
        nutritions: json["nutritions"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        restaurantName: json["restaurantName"],
        restaurantPhone: json["restaurantPhone"],
        restaurantMobilePhone: json["restaurantMobilePhone"],
        fee: json["fee"],
        percent: json["percent"],
        subCategory: json["stallCat"] ?? '',
        merchantCommission: json["merchant_commission"],
        foodsreviews: json["foodsreviews"] == null
            ? []
            : List<Foodsreview>.from(
                json["foodsreviews"]!.map((x) => Foodsreview.fromJson(x))),
        variants: json["variants"] == null
            ? []
            : List<Variant>.from(
                json["variants"]!.map((x) => Variant.fromJson(x))),
        similarFood: json["similarFood"] == null
            ? []
            : List<SimilarFood>.from(
                json["similarFood"]!.map((x) => SimilarFood.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "id": id,
        "image": image,
        "default_tax": defaultTax,
        "currency": currency,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "imageid": imageid,
        "price": price,
        "discountprice": discountprice,
        "desc": desc,
        "restaurant": restaurant,
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
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "restaurantName": restaurantName,
        "restaurantPhone": restaurantPhone,
        "restaurantMobilePhone": restaurantMobilePhone,
        "fee": fee,
        "percent": percent,
        "merchant_commission": merchantCommission,
        "stallCat": subCategory,
        "foodsreviews": foodsreviews == null
            ? []
            : List<dynamic>.from(foodsreviews!.map((x) => x.toJson())),
        "variants": variants == null
            ? []
            : List<dynamic>.from(variants!.map((x) => x.toJson())),
        "similarFood": similarFood == null
            ? []
            : List<dynamic>.from(similarFood!.map((x) => x.toJson())),
      };
}

class Foodsreview {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? desc;
  int? user;
  String? rate;
  int? food;
  dynamic name;
  String? image;

  Foodsreview({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.desc,
    this.user,
    this.rate,
    this.food,
    this.name,
    this.image,
  });

  factory Foodsreview.fromJson(Map<String, dynamic> json) => Foodsreview(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        desc: json["desc"],
        user: json["user"],
        rate: json["rate"],
        food: json["food"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "desc": desc,
        "user": user,
        "rate": rate,
        "food": food,
        "name": name,
        "image": image,
      };
}

class SimilarFood {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? imageid;
  String? price;
  String? discountprice;
  String? desc;
  int? restaurant;
  int? category;
  String? stallCat;
  String? ingredients;
  String? unit;
  int? packageCount;
  int? weight;
  int? canDelivery;
  int? stars;
  int? published;
  int? extras;
  int? nutritions;
  String? images;
  String? image;

  SimilarFood({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageid,
    this.price,
    this.discountprice,
    this.desc,
    this.restaurant,
    this.category,
    this.stallCat,
    this.ingredients,
    this.unit,
    this.packageCount,
    this.weight,
    this.canDelivery,
    this.stars,
    this.published,
    this.extras,
    this.nutritions,
    this.images,
    this.image,
  });

  factory SimilarFood.fromJson(Map<String, dynamic> json) => SimilarFood(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        imageid: json["imageid"],
        price: json["price"],
        discountprice: json["discountprice"],
        desc: json["desc"],
        restaurant: json["restaurant"],
        category: json["category"],
        stallCat: json["stallCat"],
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
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "imageid": imageid,
        "price": price,
        "discountprice": discountprice,
        "desc": desc,
        "restaurant": restaurant,
        "category": category,
        "stallCat": stallCat,
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
        "image": image,
      };
}

class Variant {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? food;
  String? name;
  int? imageid;
  String? price;
  String? dprice;
  String? image;
  String? timeago;

  Variant({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.food,
    this.name,
    this.imageid,
    this.price,
    this.dprice,
    this.image,
    this.timeago,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        food: json["food"],
        name: json["name"],
        imageid: json["imageid"],
        price: json["price"],
        dprice: json["dprice"],
        image: json["image"],
        timeago: json["timeago"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "food": food,
        "name": name,
        "imageid": imageid,
        "price": price,
        "dprice": dprice,
        "image": image,
        "timeago": timeago,
      };
}
