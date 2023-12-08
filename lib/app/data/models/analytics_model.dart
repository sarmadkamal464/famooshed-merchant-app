// // To parse this JSON data, do
// //
// //     final analyticsModel = analyticsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// AnalyticsModel analyticsModelFromJson(String str) =>
//     AnalyticsModel.fromJson(json.decode(str));
//
// String analyticsModelToJson(AnalyticsModel data) => json.encode(data.toJson());
//
// class AnalyticsModel {
//   int? returnCustmr;
//   int? totalOrderPercnt;
//   int? totalUserPercnt;
//   int? totalPercntReturn;
//   String? earning;
//   int? ordersCount;
//   int? totalUser;
//   ProductSell? productSell;
//   int? e1;
//   double? e2;
//   double? e3;
//
//   AnalyticsModel({
//     this.returnCustmr,
//     this.totalOrderPercnt,
//     this.totalUserPercnt,
//     this.totalPercntReturn,
//     this.earning,
//     this.ordersCount,
//     this.totalUser,
//     this.productSell,
//     this.e1,
//     this.e2,
//     this.e3,
//   });
//
//   factory AnalyticsModel.fromJson(Map<String, dynamic> json) => AnalyticsModel(
//         returnCustmr: json["return_custmr"],
//         totalOrderPercnt: json["total_order_percnt"],
//         totalUserPercnt: json["total_user_percnt"],
//         totalPercntReturn: json["total_percnt_return"],
//         earning: json["earning"],
//         ordersCount: json["ordersCount"],
//         totalUser: json["totalUser"],
//         productSell: json["productSell"] == null
//             ? null
//             : ProductSell.fromJson(json["productSell"]),
//         e1: json["e1"],
//         e2: json["e2"]?.toDouble(),
//         e3: json["e3"]?.toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "return_custmr": returnCustmr,
//         "total_order_percnt": totalOrderPercnt,
//         "total_user_percnt": totalUserPercnt,
//         "total_percnt_return": totalPercntReturn,
//         "earning": earning,
//         "ordersCount": ordersCount,
//         "totalUser": totalUser,
//         "productSell": productSell?.toJson(),
//         "e1": e1,
//         "e2": e2,
//         "e3": e3,
//       };
// }
//
// class ProductSell {
//   int? currentPage;
//   List<TopSellingProductModel>? data;
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
//   ProductSell({
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
//   factory ProductSell.fromJson(Map<String, dynamic> json) => ProductSell(
//         currentPage: json["current_page"],
//         data: json["data"] == null
//             ? []
//             : List<TopSellingProductModel>.from(
//                 json["data"]!.map((x) => TopSellingProductModel.fromJson(x))),
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
// class TopSellingProductModel {
//   int? foodid;
//   String? foodprice;
//   int? count;
//   int? totalCount1;
//   String? totalCount;
//   String? total;
//   DateTime? createdAt;
//   int? user;
//   int? totalUser;
//   String? totalPrice;
//   String? image;
//   String? name;
//   String? category;
//   String? restaurantname;
//   String? id;
//
//   TopSellingProductModel({
//     this.foodid,
//     this.foodprice,
//     this.count,
//     this.totalCount1,
//     this.totalCount,
//     this.total,
//     this.createdAt,
//     this.user,
//     this.totalUser,
//     this.totalPrice,
//     this.image,
//     this.name,
//     this.category,
//     this.restaurantname,
//     this.id,
//   });
//
//   factory TopSellingProductModel.fromJson(Map<String, dynamic> json) =>
//       TopSellingProductModel(
//         foodid: json["foodid"],
//         foodprice: json["foodprice"],
//         count: json["count"],
//         totalCount1: json["total_count1"],
//         totalCount: json["total_count"],
//         total: json["total"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         user: json["user"],
//         totalUser: json["total_user"],
//         totalPrice: json["total_price"],
//         image: json["image"],
//         name: json["name"],
//         category: json["category"],
//         restaurantname: json["restaurantname"],
//         id: json["id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "foodid": foodid,
//         "foodprice": foodprice,
//         "count": count,
//         "total_count1": totalCount1,
//         "total_count": totalCount,
//         "total": total,
//         "created_at": createdAt?.toIso8601String(),
//         "user": user,
//         "total_user": totalUser,
//         "total_price": totalPrice,
//         "image": image,
//         "name": name,
//         "category": category,
//         "restaurantname": restaurantname,
//         "id": id,
//       };
// }

// To parse this JSON data, do
//
//     final analyticsModel = analyticsModelFromJson(jsonString);

import 'dart:convert';

AnalyticsModel analyticsModelFromJson(String str) =>
    AnalyticsModel.fromJson(json.decode(str));

String analyticsModelToJson(AnalyticsModel data) => json.encode(data.toJson());

class AnalyticsModel {
  int? returnCustmr;
  int? totalOrderPercnt;
  int? totalPricePercnt;
  int? totalPercntReturn;
  String? earning;
  int? ordersCount;
  int? totalUser;
  dynamic monthWiseEarning;
  ProductSell? productSell;
  List<Earning>? monthlyEarning;

  AnalyticsModel({
    this.returnCustmr,
    this.totalOrderPercnt,
    this.totalPricePercnt,
    this.totalPercntReturn,
    this.earning,
    this.ordersCount,
    this.totalUser,
    this.monthWiseEarning,
    this.productSell,
    this.monthlyEarning,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> monthlyEarningMap = json["month_wise_earning"] ?? {};
    List<Earning> monthlyEarningList = [];
    if (monthlyEarningMap.isNotEmpty) {
      monthlyEarningList = monthlyEarningMap.entries
          .map((entry) => Earning(month: entry.key, earning: entry.value))
          .toList();
    }

    return AnalyticsModel(
      returnCustmr: json["return_custmr"],
      totalOrderPercnt: json["total_order_percnt"],
      totalPricePercnt: json["total_price_percnt"],
      totalPercntReturn: json["total_percnt_return"],
      earning: json["earning"],
      ordersCount: json["ordersCount"],
      totalUser: json["totalUser"],
      monthWiseEarning: json["month_wise_earning"],
      monthlyEarning: monthlyEarningList,
      productSell: json["productSell"] == null
          ? null
          : ProductSell.fromJson(json["productSell"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "return_custmr": returnCustmr,
        "total_order_percnt": totalOrderPercnt,
        "total_price_percnt": totalPricePercnt,
        "total_percnt_return": totalPercntReturn,
        "earning": earning,
        "ordersCount": ordersCount,
        "totalUser": totalUser,
        "month_wise_earning": monthWiseEarning,
        "productSell": productSell?.toJson(),
      };
}

class Earning {
  String? month;
  String? earning;

  Earning({this.month, this.earning});
}

class ProductSell {
  int? currentPage;
  List<TopSellingProductModel>? data;
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

  ProductSell({
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

  factory ProductSell.fromJson(Map<String, dynamic> json) => ProductSell(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<TopSellingProductModel>.from(
                json["data"]!.map((x) => TopSellingProductModel.fromJson(x))),
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

class TopSellingProductModel {
  int? foodid;
  String? foodprice;
  int? count;
  int? totalCount1;
  String? totalSell;
  String? total;
  DateTime? createdAt;
  int? user;
  int? totalCustomer;
  int? published;
  int? inventoryStock;
  String? totalEarning;
  String? image;
  String? name;
  String? category;
  String? restaurantname;
  String? id;

  TopSellingProductModel({
    this.foodid,
    this.foodprice,
    this.count,
    this.totalCount1,
    this.totalSell,
    this.total,
    this.createdAt,
    this.user,
    this.totalCustomer,
    this.published,
    this.inventoryStock,
    this.totalEarning,
    this.image,
    this.name,
    this.category,
    this.restaurantname,
    this.id,
  });

  factory TopSellingProductModel.fromJson(Map<String, dynamic> json) =>
      TopSellingProductModel(
        foodid: json["foodid"],
        foodprice: json["foodprice"],
        count: json["count"],
        totalCount1: json["total_count1"],
        totalSell: json["total_sell"],
        total: json["total"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        user: json["user"],
        totalCustomer: json["total_customer"],
        published: json["published"] ?? 0,
        inventoryStock: json["invenotory_stock"] ?? 0,
        totalEarning: json["total_earning"],
        image: json["image"],
        name: json["name"],
        category: json["category"],
        restaurantname: json["restaurantname"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "foodid": foodid,
        "foodprice": foodprice,
        "count": count,
        "total_count1": totalCount1,
        "total_sell": totalSell,
        "total": total,
        "created_at": createdAt?.toIso8601String(),
        "user": user,
        "total_customer": totalCustomer,
        "published": published,
        "invenotory_stock": inventoryStock,
        "total_earning": totalEarning,
        "image": image,
        "name": name,
        "category": category,
        "restaurantname": restaurantname,
        "id": id,
      };
}
