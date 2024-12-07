// // To parse this JSON data, do
// //
// //     final BusinessCategoriesModel = BusinessCategoriesModelFromJson(jsonString);

// import 'dart:convert';

// BusinessCategoriesModel BusinessCategoriesModelFromJson(String str) => BusinessCategoriesModel.fromJson(json.decode(str));

// String BusinessCategoriesModelToJson(BusinessCategoriesModel data) => json.encode(data.toJson());

// class BusinessCategoriesModel {
//     final String? id;
//     final String? name;
//     final List<SubCategory>? subCategory;
//     final bool? display;
//     final String? addedBy;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final dynamic deletedAt;

//     BusinessCategoriesModel({
//         this.id,
//         this.name,
//         this.subCategory,
//         this.display,
//         this.addedBy,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//     });

//     factory BusinessCategoriesModel.fromJson(Map<String, dynamic> json) => BusinessCategoriesModel(
//         id: json["id"],
//         name: json["name"],
//         subCategory: json["subCategory"] == null ? [] : List<SubCategory>.from(json["subCategory"]!.map((x) => SubCategory.fromJson(x))),
//         display: json["display"],
//         addedBy: json["addedBy"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "subCategory": subCategory == null ? [] : List<dynamic>.from(subCategory!.map((x) => x.toJson())),
//         "display": display,
//         "addedBy": addedBy,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "deletedAt": deletedAt,
//     };
// }

// class SubCategory {
//     final String? name;

//     SubCategory({
//         this.name,
//     });

//     factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//     };
// }


class BusinessCategoriesModel {
  final String uuid;
  final String description;

  BusinessCategoriesModel({
    required this.uuid,
    required this.description,
  });

  factory BusinessCategoriesModel.fromJson(Map<String, dynamic> json) {
    return BusinessCategoriesModel(
      uuid: json['uuid'] as String,
      description: json['description'] as String,
    );
  }
}

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
