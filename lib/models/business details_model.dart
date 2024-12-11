class BusinessProfileDetailModel {
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
  final List<String>? imageUrl;
  final String? croppedImageUrl;
  final String? phoneNumber;
  final String? businessEmail;
  final String? openTime;
  final String? closeTime;
  final List<OperationDay>? operationDays;
  final String? websiteUrl;
  final String? linkedinUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? facebookUrl;
  final DateTime? createdUtc;
  final DateTime? modifiedUtc;
  final int totalReviews;
  final double averageRatings;
  final double? longitude;
  final double? latitude;
  final List<CustomProductCategory>? customProductCategories;
  final String? businessCategory;
  final List<dynamic>? reviews;
  final List<Follower>? followers;
  final int followersCount;
  final bool isFollowing;

  BusinessProfileDetailModel({
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
    this.imageUrl,
    this.croppedImageUrl,
    this.phoneNumber,
    this.businessEmail,
    this.openTime,
    this.closeTime,
    this.operationDays,
    this.websiteUrl,
    this.linkedinUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.facebookUrl,
    this.createdUtc,
    this.modifiedUtc,
    this.totalReviews = 0,
    this.averageRatings = 0.0,
    this.longitude,
    this.latitude,
    this.customProductCategories,
    this.businessCategory,
    this.reviews,
    this.followers,
    this.followersCount = 0,
    this.isFollowing = false,
  });

  factory BusinessProfileDetailModel.fromJson(Map<String, dynamic> json) {
    return BusinessProfileDetailModel(
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
      imageUrl: (json['imageUrl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      croppedImageUrl: json['croppedImageUrl'],
      phoneNumber: json['phoneNumber'],
      businessEmail: json['businessEmail'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      operationDays: (json['operationDays'] as List<dynamic>?)
          ?.map((e) => OperationDay.fromJson(e))
          .toList(),
      websiteUrl: json['websiteUrl'],
      linkedinUrl: json['linkedinUrl'],
      instagramUrl: json['instagramUrl'],
      twitterUrl: json['twitterUrl'],
      facebookUrl: json['facebookUrl'],
      createdUtc: json['createdUtc'] != null ? DateTime.parse(json['createdUtc']) : null,
      modifiedUtc: json['modifiedUtc'] != null ? DateTime.parse(json['modifiedUtc']) : null,
      totalReviews: json['totalReviews'] ?? 0,
      averageRatings: (json['averageRatings'] ?? 0).toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      customProductCategories: (json['customProductCategories'] as List<dynamic>?)
          ?.map((e) => CustomProductCategory.fromJson(e))
          .toList(),
      businessCategory: json['businessCategory'],
      reviews: json['reviews'] as List<dynamic>?,
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => Follower.fromJson(e))
          .toList(),
      followersCount: json['followersCount'] ?? 0,
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'userUuid': userUuid,
      'name': name,
      'description': description,
      'businessCategoryUuid': businessCategoryUuid,
      'country': country,
      'stateAndProvince': stateAndProvince,
      'city': city,
      'street': street,
      'postalCode': postalCode,
      'logoUrl': logoUrl,
      'imageUrl': imageUrl,
      'croppedImageUrl': croppedImageUrl,
      'phoneNumber': phoneNumber,
      'businessEmail': businessEmail,
      'openTime': openTime,
      'closeTime': closeTime,
      'operationDays': operationDays?.map((e) => e.toJson()).toList(),
      'websiteUrl': websiteUrl,
      'linkedinUrl': linkedinUrl,
      'instagramUrl': instagramUrl,
      'twitterUrl': twitterUrl,
      'facebookUrl': facebookUrl,
      'createdUtc': createdUtc?.toIso8601String(),
      'modifiedUtc': modifiedUtc?.toIso8601String(),
      'totalReviews': totalReviews,
      'averageRatings': averageRatings,
      'longitude': longitude,
      'latitude': latitude,
      'customProductCategories': customProductCategories?.map((e) => e.toJson()).toList(),
      'businessCategory': businessCategory,
      'reviews': reviews,
      'followers': followers?.map((e) => e.toJson()).toList(),
      'followersCount': followersCount,
      'isFollowing': isFollowing,
    };
  }
}

class OperationDay {
  final String day;
  final String openTime;
  final String closeTime;

  OperationDay({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  factory OperationDay.fromJson(Map<String, dynamic> json) {
    return OperationDay(
      day: json['day'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }
}

class CustomProductCategory {
  final String id;
  final String value;
  final bool isDefault;

  CustomProductCategory({
    required this.id,
    required this.value,
    required this.isDefault,
  });

  factory CustomProductCategory.fromJson(Map<String, dynamic> json) {
    return CustomProductCategory(
      id: json['id'],
      value: json['value'],
      isDefault: json['default'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'default': isDefault,
    };
  }
}

class Follower {
  final String userId;

  Follower({
    required this.userId,
  });

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
