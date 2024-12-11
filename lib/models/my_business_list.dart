import 'dart:convert';

// Function to parse JSON data
MyBusinessListModel myBusinessListModelFromJson(String str) =>
    MyBusinessListModel.fromJson(json.decode(str));

// Function to convert data back to JSON format
String myBusinessListModelToJson(MyBusinessListModel data) =>
    json.encode(data.toJson());

class MyBusinessListModel {
  final bool? success;
  final Message? message;
  final Data? data;

  MyBusinessListModel({
    this.success,
    this.message,
    this.data,
  });

  factory MyBusinessListModel.fromJson(Map<String, dynamic> json) =>
      MyBusinessListModel(
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
  final List<BusinessProfile> businessProfiles;

  Data({
    required this.businessProfiles,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        businessProfiles: List<BusinessProfile>.from(
            json["businessProfiles"].map((x) => BusinessProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "businessProfiles":
            List<dynamic>.from(businessProfiles.map((x) => x.toJson())),
      };
}

class BusinessProfile {
  final String uuid;
  final String userUuid;
  final String name;
  final String? description;
  final String? businessCategoryUuid;
  final String? country;
  final String? stateAndProvince;
  final String? city;
  final String? street;
  final String? postalCode;
  final String? logoUrl;
  final List<String> imageUrl;
  final String? croppedImageUrl;
  final String? phoneNumber;
  final String? businessEmail;
  final String? openTime;
  final String? closeTime;
  final List<String> daysOfOperation;
  final int? followersCount;
  final int? followingCount;
  final bool? isFollowing;
  final bool? isOwner;
  final String? websiteUrl;
  final String? linkedinUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? facebookUrl;
  final String? createdUtc;

  BusinessProfile({
    required this.uuid,
    required this.userUuid,
    required this.name,
    this.description,
    this.businessCategoryUuid,
    this.country,
    this.stateAndProvince,
    this.city,
    this.street,
    this.postalCode,
    this.logoUrl,
    required this.imageUrl,
    this.croppedImageUrl,
    this.phoneNumber,
    this.businessEmail,
    this.openTime,
    this.closeTime,
    required this.daysOfOperation,
    this.followersCount,
    this.followingCount,
    this.isFollowing,
    this.isOwner,
    this.websiteUrl,
    this.linkedinUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.facebookUrl,
    this.createdUtc,
  });

  factory BusinessProfile.fromJson(Map<String, dynamic> json) =>
      BusinessProfile(
        uuid: json["uuid"],
        userUuid: json["userUuid"],
        name: json["name"],
        description: json["description"],
        businessCategoryUuid: json["businessCategoryUuid"],
        country: json["country"],
        stateAndProvince: json["stateAndProvince"],
        city: json["city"],
        street: json["street"],
        postalCode: json["postalCode"],
        logoUrl: json["logoUrl"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        croppedImageUrl: json["croppedImageUrl"],
        phoneNumber: json["phoneNumber"],
        businessEmail: json["businessEmail"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        daysOfOperation:
            List<String>.from(json["daysOfOperation"].map((x) => x)),
        websiteUrl: json["websiteUrl"],
        linkedinUrl: json["linkedinUrl"],
        instagramUrl: json["instagramUrl"],
        twitterUrl: json["twitterUrl"],
        facebookUrl: json["facebookUrl"],
        createdUtc: json["createdUtc"],
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
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "croppedImageUrl": croppedImageUrl,
        "phoneNumber": phoneNumber,
        "businessEmail": businessEmail,
        "openTime": openTime,
        "closeTime": closeTime,
        "daysOfOperation": List<dynamic>.from(daysOfOperation.map((x) => x)),
        "websiteUrl": websiteUrl,
        "linkedinUrl": linkedinUrl,
        "instagramUrl": instagramUrl,
        "twitterUrl": twitterUrl,
        "facebookUrl": facebookUrl,
        "createdUtc": createdUtc,
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
