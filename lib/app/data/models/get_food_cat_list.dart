// To parse this JSON data, do
//
//     final getFoodCatListResponse = getFoodCatListResponseFromJson(jsonString);

import 'dart:convert';

GetFoodCatListResponse getFoodCatListResponseFromJson(String str) =>
    GetFoodCatListResponse.fromJson(json.decode(str));

String getFoodCatListResponseToJson(GetFoodCatListResponse data) =>
    json.encode(data.toJson());

class GetFoodCatListResponse {
  String? error;
  List<CatList>? catList;
  List<CatList>? stallcatList;

  GetFoodCatListResponse({
    this.error,
    this.catList,
    this.stallcatList,
  });

  factory GetFoodCatListResponse.fromJson(Map<String, dynamic> json) =>
      GetFoodCatListResponse(
        error: json["error"],
        catList: json["catList"] == null
            ? []
            : List<CatList>.from(
                json["catList"]!.map((x) => CatList.fromJson(x))),
        stallcatList: json["stallcatList"] == null
            ? []
            : List<CatList>.from(
                json["stallcatList"]!.map((x) => CatList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "catList": catList == null
            ? []
            : List<dynamic>.from(catList!.map((x) => x.toJson())),
        "stallcatList": stallcatList == null
            ? []
            : List<dynamic>.from(stallcatList!.map((x) => x.toJson())),
      };
}

class CatList {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? imageid;
  String? desc;
  int? visible;
  int? parent;
  int? featuredCat;
  String? restUserId;
  String? categoryType;

  CatList({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageid,
    this.desc,
    this.visible,
    this.parent,
    this.featuredCat,
    this.restUserId,
    this.categoryType,
  });

  factory CatList.fromJson(Map<String, dynamic> json) => CatList(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        imageid: json["imageid"],
        desc: json["desc"],
        visible: json["visible"],
        parent: json["parent"],
        featuredCat: json["featured_cat"],
        restUserId: json["rest_user_id"],
        categoryType: json["category_type"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "imageid": imageid,
        "desc": desc,
        "visible": visible,
        "parent": parent,
        "featured_cat": featuredCat,
        "rest_user_id": restUserId,
        "category_type": categoryType,
      };
}
