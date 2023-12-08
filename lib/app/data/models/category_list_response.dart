// To parse this JSON data, do
//
//     final categoryListResponse = categoryListResponseFromJson(jsonString);

import 'dart:convert';

CategoryListResponse categoryListResponseFromJson(String str) =>
    CategoryListResponse.fromJson(json.decode(str));

String categoryListResponseToJson(CategoryListResponse data) =>
    json.encode(data.toJson());

class CategoryListResponse {
  String error;

  List<Category> category;
  List<Category> subCategory;

  CategoryListResponse({
    required this.error,
    required this.category,
    required this.subCategory,
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) =>
      CategoryListResponse(
        error: json["error"],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        subCategory: List<Category>.from(
            json["sub_categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "sub_categories":
            List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class Category {
  int id;
  String name;
  String desc;
  int visible;
  int parent;
  int featuredCat;
  String? image;
  String? categoryType;
  int? imageId;
  String? parentName;
  int itemsCount;
  bool? isReadOnly;

  Category(
      {required this.id,
      required this.name,
      required this.desc,
      required this.visible,
      required this.parent,
      required this.featuredCat,
      this.image,
      required this.parentName,
      required this.itemsCount,
      required this.categoryType,
      required this.imageId,
      this.isReadOnly});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        visible: json["visible"],
        parent: json["parent"],
        featuredCat: json["featured_cat"],
        image: json["image"] ?? '',
        parentName: json["parentName"] ?? '',
        itemsCount: json["itemsCount"] ?? 0,
        categoryType: json["category_type"],
        imageId: json["imageid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "visible": visible,
        "parent": parent,
        "featured_cat": featuredCat,
        "image": image,
        "parentName": parentName,
        "itemsCount": itemsCount,
        "category_type": categoryType,
        "imageid": imageId,
      };
}
