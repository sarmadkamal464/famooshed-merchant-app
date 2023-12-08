// To parse this JSON data, do
//
//     final getMyStallResponse = getMyStallResponseFromJson(jsonString);

import 'dart:convert';

GetMyStallResponse getMyStallResponseFromJson(String str) =>
    GetMyStallResponse.fromJson(json.decode(str));

String getMyStallResponseToJson(GetMyStallResponse data) =>
    json.encode(data.toJson());

class GetMyStallResponse {
  String error;
  String id;
  List<Restaurant> restaurants;

  GetMyStallResponse({
    required this.error,
    required this.id,
    required this.restaurants,
  });

  factory GetMyStallResponse.fromJson(Map<String, dynamic> json) =>
      GetMyStallResponse(
        error: json["error"],
        id: json["id"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "id": id,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  int? id;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? businessName;
  String? businessAddress;
  String? bcity;
  String? bzipcode;
  String? country;
  String? businesstype;
  dynamic cuisineName;
  String? numOfLocation;
  String? delivertype;
  int? published;
  int? delivered;
  String? phone;
  String? mobilephone;
  String? address;
  String? lat;
  String? lng;
  int? imageid;
  int? logoId;
  String? desc;
  String? fee;
  dynamic nextDayFee;
  dynamic homeDeliFee;
  int? merchantCommission;
  int? percent;
  dynamic homeDeliPercent;
  String? bestSeller;
  String? facebook;
  String? instagram;
  dynamic twitter;
  dynamic accountnumber;
  dynamic holderName;
  dynamic bankcode;
  String? bRoutingNumber;
  String? bankType;
  String? cardName;
  String? cardNumber;
  String? cardCvc;
  String? cardMm;
  String? cardYy;
  dynamic stripeId;
  String? openTimeMonday;
  String? closeTimeMonday;
  String? openTimeTuesday;
  String? closeTimeTuesday;
  String? openTimeWednesday;
  String? closeTimeWednesday;
  String? openTimeThursday;
  String? closeTimeThursday;
  String? openTimeFriday;
  String? closeTimeFriday;
  String? openTimeSaturday;
  String? closeTimeSaturday;
  String? openTimeSunday;
  String? closeTimeSunday;
  int? area;
  dynamic cardId;
  dynamic bankId;
  String? minAmount;
  int? perkm;
  int? homeDeliPerkm;
  dynamic crn;
  int? onlyfamooshed;
  int? pickUp;
  int? homeDeli;
  int? nextDay;
  String? images;
  dynamic logo;
  String? email;
  String? merchantCategories;
  String? flatNo;
  String? landmark;

  Restaurant({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.businessName,
    this.businessAddress,
    this.bcity,
    this.bzipcode,
    this.country,
    this.businesstype,
    this.cuisineName,
    this.numOfLocation,
    this.delivertype,
    this.published,
    this.delivered,
    this.phone,
    this.mobilephone,
    this.address,
    this.lat,
    this.lng,
    this.imageid,
    this.logoId,
    this.desc,
    this.fee,
    this.nextDayFee,
    this.homeDeliFee,
    this.merchantCommission,
    this.percent,
    this.homeDeliPercent,
    this.bestSeller,
    this.facebook,
    this.instagram,
    this.twitter,
    this.accountnumber,
    this.holderName,
    this.bankcode,
    this.bRoutingNumber,
    this.bankType,
    this.cardName,
    this.cardNumber,
    this.cardCvc,
    this.cardMm,
    this.cardYy,
    this.stripeId,
    this.openTimeMonday,
    this.closeTimeMonday,
    this.openTimeTuesday,
    this.closeTimeTuesday,
    this.openTimeWednesday,
    this.closeTimeWednesday,
    this.openTimeThursday,
    this.closeTimeThursday,
    this.openTimeFriday,
    this.closeTimeFriday,
    this.openTimeSaturday,
    this.closeTimeSaturday,
    this.openTimeSunday,
    this.closeTimeSunday,
    this.area,
    this.cardId,
    this.bankId,
    this.minAmount,
    this.perkm,
    this.homeDeliPerkm,
    this.crn,
    this.onlyfamooshed,
    this.pickUp,
    this.homeDeli,
    this.nextDay,
    this.images,
    this.logo,
    this.email,
    this.merchantCategories,
    this.flatNo,
    this.landmark,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        businessName: json["business_name"],
        businessAddress: json["business_address"],
        bcity: json["bcity"],
        bzipcode: json["bzipcode"],
        country: json["country"],
        businesstype: json["businesstype"],
        cuisineName: json["cuisine_name"],
        numOfLocation: json["num_of_location"],
        delivertype: json["delivertype"],
        published: json["published"],
        delivered: json["delivered"],
        phone: json["phone"],
        mobilephone: json["mobilephone"],
        address: json["address"],
        lat: json["lat"],
        lng: json["lng"],
        imageid: json["imageid"],
        logoId: json["logoId"],
        desc: json["desc"],
        fee: json["fee"],
        nextDayFee: json["next_day_fee"],
        homeDeliFee: json["home_deli_fee"],
        merchantCommission: json["merchant_commission"],
        percent: json["percent"],
        homeDeliPercent: json["home_deli_percent"],
        bestSeller: json["best_seller"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        accountnumber: json["accountnumber"],
        holderName: json["holder_name"],
        bankcode: json["bankcode"],
        bRoutingNumber: json["b_routing_number"],
        bankType: json["bank_type"],
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        cardCvc: json["card_cvc"],
        cardMm: json["card_mm"],
        cardYy: json["card_yy"],
        stripeId: json["stripe_id"],
        openTimeMonday: json["openTimeMonday"],
        closeTimeMonday: json["closeTimeMonday"],
        openTimeTuesday: json["openTimeTuesday"],
        closeTimeTuesday: json["closeTimeTuesday"],
        openTimeWednesday: json["openTimeWednesday"],
        closeTimeWednesday: json["closeTimeWednesday"],
        openTimeThursday: json["openTimeThursday"],
        closeTimeThursday: json["closeTimeThursday"],
        openTimeFriday: json["openTimeFriday"],
        closeTimeFriday: json["closeTimeFriday"],
        openTimeSaturday: json["openTimeSaturday"],
        closeTimeSaturday: json["closeTimeSaturday"],
        openTimeSunday: json["openTimeSunday"],
        closeTimeSunday: json["closeTimeSunday"],
        area: json["area"],
        cardId: json["card_id"],
        bankId: json["bank_id"],
        minAmount: json["minAmount"],
        perkm: json["perkm"],
        homeDeliPerkm: json["home_deli_perkm"],
        crn: json["crn"],
        onlyfamooshed: json["onlyfamooshed"],
        pickUp: json["pick_up"],
        homeDeli: json["home_deli"],
        nextDay: json["next_day"],
        images: json["images"],
        logo: json["logo"],
        email: json["email"],
        merchantCategories: json["merchant_categories"],
        flatNo: json["flat_house_no"],
        landmark: json["near_by_landmark"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "business_name": businessName,
        "business_address": businessAddress,
        "bcity": bcity,
        "bzipcode": bzipcode,
        "country": country,
        "businesstype": businesstype,
        "cuisine_name": cuisineName,
        "num_of_location": numOfLocation,
        "delivertype": delivertype,
        "published": published,
        "delivered": delivered,
        "phone": phone,
        "mobilephone": mobilephone,
        "address": address,
        "lat": lat,
        "lng": lng,
        "imageid": imageid,
        "logoId": logoId,
        "desc": desc,
        "fee": fee,
        "next_day_fee": nextDayFee,
        "home_deli_fee": homeDeliFee,
        "merchant_commission": merchantCommission,
        "percent": percent,
        "home_deli_percent": homeDeliPercent,
        "best_seller": bestSeller,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "accountnumber": accountnumber,
        "holder_name": holderName,
        "bankcode": bankcode,
        "b_routing_number": bRoutingNumber,
        "bank_type": bankType,
        "card_name": cardName,
        "card_number": cardNumber,
        "card_cvc": cardCvc,
        "card_mm": cardMm,
        "card_yy": cardYy,
        "stripe_id": stripeId,
        "openTimeMonday": openTimeMonday,
        "closeTimeMonday": closeTimeMonday,
        "openTimeTuesday": openTimeTuesday,
        "closeTimeTuesday": closeTimeTuesday,
        "openTimeWednesday": openTimeWednesday,
        "closeTimeWednesday": closeTimeWednesday,
        "openTimeThursday": openTimeThursday,
        "closeTimeThursday": closeTimeThursday,
        "openTimeFriday": openTimeFriday,
        "closeTimeFriday": closeTimeFriday,
        "openTimeSaturday": openTimeSaturday,
        "closeTimeSaturday": closeTimeSaturday,
        "openTimeSunday": openTimeSunday,
        "closeTimeSunday": closeTimeSunday,
        "area": area,
        "card_id": cardId,
        "bank_id": bankId,
        "minAmount": minAmount,
        "perkm": perkm,
        "home_deli_perkm": homeDeliPerkm,
        "crn": crn,
        "onlyfamooshed": onlyfamooshed,
        "pick_up": pickUp,
        "home_deli": homeDeli,
        "next_day": nextDay,
        "images": images,
        "logo": logo,
        "email": email,
        "merchant_categories": merchantCategories,
        "flat_house_no": flatNo,
        "near_by_landmark": landmark,
      };
}

// class Restaurant {
//   int id;
//   int userId;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String name;
//   String businessName;
//   String businessAddress;
//   String bcity;
//   String bzipcode;
//   String country;
//   String businesstype;
//   dynamic cuisineName;
//   String numOfLocation;
//   String delivertype;
//   int published;
//   int delivered;
//   String phone;
//   String mobilephone;
//   String address;
//   String lat;
//   String lng;
//   int imageid;
//   int logoId;
//   String desc;
//   String fee;
//   int merchantCommission;
//   int percent;
//   String bestSeller;
//   String facebook;
//   String instagram;
//   String twitter;
//   String accountnumber;
//   String holderName;
//   dynamic bankcode;
//   String bRoutingNumber;
//   String bankType;
//   String cardName;
//   String cardNumber;
//   String cardCvc;
//   String cardMm;
//   String cardYy;
//   String stripeId;
//   String openTimeMonday;
//   String closeTimeMonday;
//   String openTimeTuesday;
//   String closeTimeTuesday;
//   String openTimeWednesday;
//   String closeTimeWednesday;
//   String openTimeThursday;
//   String closeTimeThursday;
//   String openTimeFriday;
//   String closeTimeFriday;
//   String openTimeSaturday;
//   String closeTimeSaturday;
//   String openTimeSunday;
//   String closeTimeSunday;
//   int area;
//   dynamic cardId;
//   String bankId;
//   String minAmount;
//   int perkm;
//   dynamic crn;
//   int onlyfamooshed;
//   String images;
//   String logo;
//   dynamic email;
//
//   Restaurant({
//     required this.id,
//     required this.userId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.name,
//     required this.businessName,
//     required this.businessAddress,
//     required this.bcity,
//     required this.bzipcode,
//     required this.country,
//     required this.businesstype,
//     this.cuisineName,
//     required this.numOfLocation,
//     required this.delivertype,
//     required this.published,
//     required this.delivered,
//     required this.phone,
//     required this.mobilephone,
//     required this.address,
//     required this.lat,
//     required this.lng,
//     required this.imageid,
//     required this.logoId,
//     required this.desc,
//     required this.fee,
//     required this.merchantCommission,
//     required this.percent,
//     required this.bestSeller,
//     required this.facebook,
//     required this.instagram,
//     required this.twitter,
//     required this.accountnumber,
//     required this.holderName,
//     this.bankcode,
//     required this.bRoutingNumber,
//     required this.bankType,
//     required this.cardName,
//     required this.cardNumber,
//     required this.cardCvc,
//     required this.cardMm,
//     required this.cardYy,
//     required this.stripeId,
//     required this.openTimeMonday,
//     required this.closeTimeMonday,
//     required this.openTimeTuesday,
//     required this.closeTimeTuesday,
//     required this.openTimeWednesday,
//     required this.closeTimeWednesday,
//     required this.openTimeThursday,
//     required this.closeTimeThursday,
//     required this.openTimeFriday,
//     required this.closeTimeFriday,
//     required this.openTimeSaturday,
//     required this.closeTimeSaturday,
//     required this.openTimeSunday,
//     required this.closeTimeSunday,
//     required this.area,
//     this.cardId,
//     required this.bankId,
//     required this.minAmount,
//     required this.perkm,
//     this.crn,
//     required this.onlyfamooshed,
//     required this.images,
//     required this.logo,
//     this.email,
//   });
//
//   factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
//         id: json["id"],
//         userId: json["user_id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         name: json["name"],
//         businessName: json["business_name"],
//         businessAddress: json["business_address"],
//         bcity: json["bcity"],
//         bzipcode: json["bzipcode"],
//         country: json["country"],
//         businesstype: json["businesstype"],
//         cuisineName: json["cuisine_name"],
//         numOfLocation: json["num_of_location"],
//         delivertype: json["delivertype"],
//         published: json["published"],
//         delivered: json["delivered"],
//         phone: json["phone"],
//         mobilephone: json["mobilephone"],
//         address: json["address"],
//         lat: json["lat"],
//         lng: json["lng"],
//         imageid: json["imageid"],
//         logoId: json["logoId"],
//         desc: json["desc"],
//         fee: json["fee"],
//         merchantCommission: json["merchant_commission"],
//         percent: json["percent"],
//         bestSeller: json["best_seller"],
//         facebook: json["facebook"] ?? '',
//         instagram: json["instagram"] ?? '',
//         twitter: json["twitter"] ?? '',
//         accountnumber: json["accountnumber"] ?? '',
//         holderName: json["holder_name"] ?? '',
//         bankcode: json["bankcode"],
//         bRoutingNumber: json["b_routing_number"],
//         bankType: json["bank_type"],
//         cardName: json["card_name"],
//         cardNumber: json["card_number"],
//         cardCvc: json["card_cvc"],
//         cardMm: json["card_mm"],
//         cardYy: json["card_yy"],
//         stripeId: json["stripe_id"] ?? '',
//         openTimeMonday: json["openTimeMonday"],
//         closeTimeMonday: json["closeTimeMonday"],
//         openTimeTuesday: json["openTimeTuesday"],
//         closeTimeTuesday: json["closeTimeTuesday"],
//         openTimeWednesday: json["openTimeWednesday"],
//         closeTimeWednesday: json["closeTimeWednesday"],
//         openTimeThursday: json["openTimeThursday"],
//         closeTimeThursday: json["closeTimeThursday"],
//         openTimeFriday: json["openTimeFriday"],
//         closeTimeFriday: json["closeTimeFriday"],
//         openTimeSaturday: json["openTimeSaturday"],
//         closeTimeSaturday: json["closeTimeSaturday"],
//         openTimeSunday: json["openTimeSunday"],
//         closeTimeSunday: json["closeTimeSunday"],
//         area: json["area"],
//         cardId: json["card_id"],
//         bankId: json["bank_id"],
//         minAmount: json["minAmount"],
//         perkm: json["perkm"],
//         crn: json["crn"],
//         onlyfamooshed: json["onlyfamooshed"],
//         images: json["images"],
//         logo: json["logo"],
//         email: json["email"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "name": name,
//         "business_name": businessName,
//         "business_address": businessAddress,
//         "bcity": bcity,
//         "bzipcode": bzipcode,
//         "country": country,
//         "businesstype": businesstype,
//         "cuisine_name": cuisineName,
//         "num_of_location": numOfLocation,
//         "delivertype": delivertype,
//         "published": published,
//         "delivered": delivered,
//         "phone": phone,
//         "mobilephone": mobilephone,
//         "address": address,
//         "lat": lat,
//         "lng": lng,
//         "imageid": imageid,
//         "logoId": logoId,
//         "desc": desc,
//         "fee": fee,
//         "merchant_commission": merchantCommission,
//         "percent": percent,
//         "best_seller": bestSeller,
//         "facebook": facebook,
//         "instagram": instagram,
//         "twitter": twitter,
//         "accountnumber": accountnumber,
//         "holder_name": holderName,
//         "bankcode": bankcode,
//         "b_routing_number": bRoutingNumber,
//         "bank_type": bankType,
//         "card_name": cardName,
//         "card_number": cardNumber,
//         "card_cvc": cardCvc,
//         "card_mm": cardMm,
//         "card_yy": cardYy,
//         "stripe_id": stripeId,
//         "openTimeMonday": openTimeMonday,
//         "closeTimeMonday": closeTimeMonday,
//         "openTimeTuesday": openTimeTuesday,
//         "closeTimeTuesday": closeTimeTuesday,
//         "openTimeWednesday": openTimeWednesday,
//         "closeTimeWednesday": closeTimeWednesday,
//         "openTimeThursday": openTimeThursday,
//         "closeTimeThursday": closeTimeThursday,
//         "openTimeFriday": openTimeFriday,
//         "closeTimeFriday": closeTimeFriday,
//         "openTimeSaturday": openTimeSaturday,
//         "closeTimeSaturday": closeTimeSaturday,
//         "openTimeSunday": openTimeSunday,
//         "closeTimeSunday": closeTimeSunday,
//         "area": area,
//         "card_id": cardId,
//         "bank_id": bankId,
//         "minAmount": minAmount,
//         "perkm": perkm,
//         "crn": crn,
//         "onlyfamooshed": onlyfamooshed,
//         "images": images,
//         "logo": logo,
//         "email": email,
//       };
// }
