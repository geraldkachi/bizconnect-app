
// import 'dart:convert';

// ProfileBusinessModel profileBusinessModelFromJson(String str) =>
//     ProfileBusinessModel.fromJson(json.decode(str));

// String profileBusinessModelToJson(ProfileBusinessModel data) =>
//   json.encode(data.toJson());

// class ProfileBusinessModel {
//   final String? businessName;
//   final String? description;
//   final String? businessCategory;
//   final String? country;
//   final String? stateAndProvince;
//   final String? city;
//   final String? street;
//   final String? postalCode;
//   final String? image; // String type, nullable
//   final String? instagramUrl;
//   final String? websiteUrl;
//   final String? linkedinUrl;
//   final String? facebookUrl;
//   final String? phoneNumber;
//   final String? businessEmail;
//   final OperationDays? operationDays;
//   final String? cropped;
//   final String? uncropped;
//   final StreetCoordinates? streetCoordinates;

//   // Additional fields
//   final String? id;
//   final String? name;
//   final String? lga;
//   final String? state;
//   final dynamic classification;
//   final dynamic isActive;
//   final String? ward;
//   final String? addedBy;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final dynamic deletedAt;

//   ProfileBusinessModel({
//     this.businessName,
//     this.description,
//     this.businessCategory,
//     this.country,
//     this.stateAndProvince,
//     this.city,
//     this.street,
//     this.postalCode,
//     this.image,
//     this.instagramUrl,
//     this.websiteUrl,
//     this.linkedinUrl,
//     this.facebookUrl,
//     this.phoneNumber,
//     this.businessEmail,
//     this.operationDays,
//     this.cropped,
//     this.uncropped,
//     this.streetCoordinates,
//     this.id,
//     this.name,
//     this.lga,
//     this.state,
//     this.classification,
//     this.isActive,
//     this.ward,
//     this.addedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });

//   factory ProfileBusinessModel.fromJson(Map<String, dynamic> json) =>
//       ProfileBusinessModel(
//         businessName: json["businessName"],
//         description: json["description"],
//         businessCategory: json["businessCategory"],
//         country: json["country"],
//         stateAndProvince: json["stateAndProvince"],
//         city: json["city"],
//         street: json["street"],
//         postalCode: json["postalCode"],
//         image: json["image"],
//         instagramUrl: json["instagramUrl"],
//         websiteUrl: json["websiteUrl"],
//         linkedinUrl: json["linkedinUrl"],
//         facebookUrl: json["facebookUrl"],
//         phoneNumber: json["phoneNumber"],
//         businessEmail: json["businessEmail"],
//         operationDays: json["operationDays"] == null
//             ? null
//             : OperationDays.fromJson(json["operationDays"]),
//         cropped: json["cropped"],
//         uncropped: json["uncropped"],
//         streetCoordinates: json["streetCoordinates"] == null
//             ? null
//             : StreetCoordinates.fromJson(json["streetCoordinates"]),
//         id: json["id"],
//         name: json["name"],
//         lga: json["lga"],
//         state: json["state"],
//         classification: json["classification"],
//         isActive: json["isActive"],
//         ward: json["ward"],
//         addedBy: json["addedBy"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "businessName": businessName,
//         "description": description,
//         "businessCategory": businessCategory,
//         "country": country,
//         "stateAndProvince": stateAndProvince,
//         "city": city,
//         "street": street,
//         "postalCode": postalCode,
//         "image": image,
//         "instagramUrl": instagramUrl,
//         "websiteUrl": websiteUrl,
//         "linkedinUrl": linkedinUrl,
//         "facebookUrl": facebookUrl,
//         "phoneNumber": phoneNumber,
//         "businessEmail": businessEmail,
//         "operationDays": operationDays?.toJson(),
//         "cropped": cropped,
//         "uncropped": uncropped,
//         "streetCoordinates": streetCoordinates?.toJson(),
//         "id": id,
//         "name": name,
//         "lga": lga,
//         "state": state,
//         "classification": classification,
//         "isActive": isActive,
//         "ward": ward,
//         "addedBy": addedBy,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "deletedAt": deletedAt,
//       };
// }

// class OperationDays {
//   // Define the structure for operationDays here
//   // Example:
//   final List<String>? days;

//   OperationDays({this.days});

//   factory OperationDays.fromJson(Map<String, dynamic> json) =>
//       OperationDays(days: List<String>.from(json["days"] ?? []));

//   Map<String, dynamic> toJson() => {
//         "days": days,
//       };
// }

// class StreetCoordinates {
//   final double? lat;
//   final double? lng;

//   StreetCoordinates({this.lat, this.lng});

//   factory StreetCoordinates.fromJson(Map<String, dynamic> json) =>
//       StreetCoordinates(
//         lat: (json["lat"] as num?)?.toDouble(),
//         lng: (json["lng"] as num?)?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lng": lng,
//       };
// }


// new code

import 'dart:convert';
import 'package:flutter/foundation.dart';

ProfileBusinessModel profileBusinessModelFromJson(String str) =>
    ProfileBusinessModel.fromJson(json.decode(str));

String profileBusinessModelToJson(ProfileBusinessModel data) =>
    json.encode(data.toJson());

class ProfileBusinessModel {
  final String uuid;
  final String userUuid;
  final String name;
  final String description;
  final String businessCategoryUuid;
  final String? country;
  final String? stateAndProvince;
  final String? city;
  final String? street;
  final String? postalCode;
  final String? logoUrl;
  final String? croppedImageUrl;
  final String? imageUrl;
  final String? image;
  final List<OperationDay> operationDays;
  final String? phoneNumber;
  final String? businessEmail;
  final String? websiteUrl;
  final String? linkedinUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? facebookUrl;
  final String createdUtc;
  final String modifiedUtc;
  final BusinessCategory businessCategory;
  final String operationInfo;
  final double averageRatings;
  final int totalReviews;
  final double latitude;
  final double longitude;
  final int? followersCount;
  final int? followingCount;
  final bool isFollowing;
  final bool isOwner;
  final String? latestNewArrival;
  final String? latestDiscount;

  ProfileBusinessModel({
    required this.uuid,
    required this.userUuid,
    required this.name,
    required this.description,
    required this.businessCategoryUuid,
    this.country,
    this.stateAndProvince,
    this.city,
    this.street,
    this.postalCode,
    this.logoUrl,
    this.croppedImageUrl,
    this.imageUrl,
    this.image,
    required this.operationDays,
    this.phoneNumber,
    this.businessEmail,
    this.websiteUrl,
    this.linkedinUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.facebookUrl,
    required this.createdUtc,
    required this.modifiedUtc,
    required this.businessCategory,
    required this.operationInfo,
    required this.averageRatings,
    required this.totalReviews,
    required this.latitude,
    required this.longitude,
    this.followersCount,
    this.followingCount,
    required this.isFollowing,
    required this.isOwner,
    this.latestNewArrival,
    this.latestDiscount,
  });

  factory ProfileBusinessModel.fromJson(Map<String, dynamic> json) =>
      ProfileBusinessModel(
        uuid: json['uuid'],
        userUuid: json['userUuid'],
        name: json['name'],
        description: json['description'],
        businessCategoryUuid: json['businessCategoryUuid'],
        country: json['country'],
        stateAndProvince: json['stateAndProvince'],
        city: json['city'],
        street: json['street'],
        postalCode: json['postalCode'],
        logoUrl: json['logoUrl'],
        croppedImageUrl: json['croppedImageUrl'],
        imageUrl: json['imageUrl'],
        image: json['image'],
        operationDays: (json['operationDays'] as List)
            .map((e) => OperationDay.fromJson(e))
            .toList(),
        phoneNumber: json['phoneNumber'],
        businessEmail: json['businessEmail'],
        websiteUrl: json['websiteUrl'],
        linkedinUrl: json['linkedinUrl'],
        instagramUrl: json['instagramUrl'],
        twitterUrl: json['twitterUrl'],
        facebookUrl: json['facebookUrl'],
        createdUtc: json['createdUtc'],
        modifiedUtc: json['modifiedUtc'],
        businessCategory: BusinessCategory.fromJson(json['businessCategory']),
        operationInfo: json['operationInfo'],
        averageRatings: json['averageRatings'].toDouble(),
        totalReviews: json['totalReviews'],
        latitude: json['latitude'].toDouble(),
        longitude: json['longitude'].toDouble(),
        followersCount: json['followersCount'],
        followingCount: json['followingCount'],
        isFollowing: json['isFollowing'],
        isOwner: json['isOwner'],
        latestNewArrival: json['latestNewArrival'],
        latestDiscount: json['latestDiscount'],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "userUuid": userUuid,
        "name": name,
        "description": description,
        "businessCategoryUuid": businessCategoryUuid,
        "country": country,
        "stateAndProvince": stateAndProvince,
        "city": city,
        "street": street,
        "postalCode": postalCode,
        "logoUrl": logoUrl,
        "croppedImageUrl": croppedImageUrl,
        "imageUrl": imageUrl,
        "image": image,
        "operationDays": operationDays.map((e) => e.toJson()).toList(),
        "phoneNumber": phoneNumber,
        "businessEmail": businessEmail,
        "websiteUrl": websiteUrl,
        "linkedinUrl": linkedinUrl,
        "instagramUrl": instagramUrl,
        "twitterUrl": twitterUrl,
        "facebookUrl": facebookUrl,
        "createdUtc": createdUtc,
        "modifiedUtc": modifiedUtc,
        "businessCategory": businessCategory.toJson(),
        "operationInfo": operationInfo,
        "averageRatings": averageRatings,
        "totalReviews": totalReviews,
        "latitude": latitude,
        "longitude": longitude,
        "followersCount": followersCount,
        "followingCount": followingCount,
        "isFollowing": isFollowing,
        "isOwner": isOwner,
        "latestNewArrival": latestNewArrival,
        "latestDiscount": latestDiscount,
      };
}

class OperationDay {
  final SlotDaysType day;
  final String openTime;
  final String closeTime;

  OperationDay({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  factory OperationDay.fromJson(Map<String, dynamic> json) => OperationDay(
        day: SlotDaysType.values
            .firstWhere((e) => describeEnum(e) == json['day']),
        openTime: json['openTime'],
        closeTime: json['closeTime'],
      );

  Map<String, dynamic> toJson() => {
        "day": describeEnum(day),
        "openTime": openTime,
        "closeTime": closeTime,
      };
}

enum SlotDaysType { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

class BusinessCategory {
  final String uuid;
  final String? description;

  BusinessCategory({required this.uuid, this.description});

  factory BusinessCategory.fromJson(Map<String, dynamic> json) =>
      BusinessCategory(
        uuid: json['uuid'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "description": description,
      };
}
