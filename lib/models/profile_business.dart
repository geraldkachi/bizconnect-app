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
