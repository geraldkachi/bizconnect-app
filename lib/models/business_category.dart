// To parse this JSON data, do
//
//     final businessCategoriesModel = businessCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BusinessCategoriesModel businessCategoriesModelFromJson(String str) => BusinessCategoriesModel.fromJson(json.decode(str));

String businessCategoriesModelToJson(BusinessCategoriesModel data) => json.encode(data.toJson());

class BusinessCategoriesModel {
    final bool? success;
    final Message? message;
    final Data? data;

    BusinessCategoriesModel({
        this.success,
        this.message,
        this.data,
    });

    factory BusinessCategoriesModel.fromJson(Map<String, dynamic> json) => BusinessCategoriesModel(
        success: json["success"],
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message?.toJson(),
        "data": data?.toJson(),
    };
}

class Data {
    final List<BusinessCategory> businessCategories;

    Data({
        required this.businessCategories,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        businessCategories: List<BusinessCategory>.from(json["businessCategories"].map((x) => BusinessCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "businessCategories": List<dynamic>.from(businessCategories.map((x) => x.toJson())),
    };
}

class BusinessCategory {
    final String uuid;
    final String description;

    BusinessCategory({
        required this.uuid,
        required this.description,
    });

    factory BusinessCategory.fromJson(Map<String, dynamic> json) => BusinessCategory(
        uuid: json["uuid"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "description": description,
    };
}

class Message {
    final int code;
    final String desc;

    Message({
        required this.code,
        required this.desc,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        code: json["code"],
        desc: json["desc"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
    };
}


// class BusinessCategoriesModel {
//   final String uuid;
//   final String description;

//   BusinessCategoriesModel({
//     required this.uuid,
//     required this.description,
//   });

//   factory BusinessCategoriesModel.fromJson(Map<String, dynamic> json) {
//     return BusinessCategoriesModel(
//       uuid: json['uuid'] ?? '',  // Handle null values gracefully
//       description: json['description'] ?? '',  // Handle null values gracefully
//     );
//   }
// }

class BusinessProfile {
  final String? street;
  final String? city;
  final String? stateAndProvince;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? websiteUrl;
  final String? phoneNumber;
  final String? businessEmail;
  final String? description;
  final bool? isOpened;
  final List<String>? operationDays;

  BusinessProfile({
    this.street,
    this.city,
    this.stateAndProvince,
    this.facebookUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.websiteUrl,
    this.phoneNumber,
    this.businessEmail,
    this.description,
    this.operationDays,
    this.isOpened,
  });
}
