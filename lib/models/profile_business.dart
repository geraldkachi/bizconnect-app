
// import 'dart:convert';

// ProfileBusinessModel profileBusinessModelFromJson(String str) => ProfileBusinessModel.fromJson(json.decode(str));

// String profileBusinessModelToJson(ProfileBusinessModel data) => json.encode(data.toJson());

// class ProfileBusinessModel {
//    businessName: string;
//   description: string;
//   businessCategory: string;
//   country: string;
//   stateAndProvince: string;
//   city: string;
//   street: string;
//   postalCode: string;
//   image: string | null; // Now a string
//   instagramUrl: string;
//   websiteUrl: string;
//   linkedinUrl: string;
//   facebookUrl: string;
//   phoneNumber: string;
//   businessEmail: string;
//   operationDays: OperationDays;
//   cropped: string;
//   uncropped: string;
//   streetCoordinates: {
//     lat: number;
//     lng: number;
//   } | null;
//   // conver these to the type


//     final String? id;
//     final String? name;
//     final String? lga;
//     final String? state;
//     final dynamic classification;
//     final dynamic isActive;
//     final String? ward;
//     final String? addedBy;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final dynamic deletedAt;

//     FrofileBusinessModel({
//         this.id,
//         this.name,
//         this.lga,
//         this.state,
//         this.classification,
//         this.isActive,
//         this.ward,
//         this.addedBy,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//     });

//     factory FrofileBusinessModel.fromJson(Map<String, dynamic> json) => FrofileBusinessModel(
//         id: json["id"],
//         name: json["name"],
//         lga: json["lga"],
//         state: json["state"],
//         classification: json["classification"],
//         isActive: json["isActive"],
//         ward: json["ward"],
//         addedBy: json["addedBy"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         deletedAt: json["deletedAt"],
//     );

//     Map<String, dynamic> toJson() => {
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
//     };
// }



import 'dart:convert';

ProfileBusinessModel profileBusinessModelFromJson(String str) =>
    ProfileBusinessModel.fromJson(json.decode(str));

String profileBusinessModelToJson(ProfileBusinessModel data) =>
  json.encode(data.toJson());

class ProfileBusinessModel {
  final String? businessName;
  final String? description;
  final String? businessCategory;
  final String? country;
  final String? stateAndProvince;
  final String? city;
  final String? street;
  final String? postalCode;
  final String? image; // String type, nullable
  final String? instagramUrl;
  final String? websiteUrl;
  final String? linkedinUrl;
  final String? facebookUrl;
  final String? phoneNumber;
  final String? businessEmail;
  final OperationDays? operationDays;
  final String? cropped;
  final String? uncropped;
  final StreetCoordinates? streetCoordinates;

  // Additional fields
  final String? id;
  final String? name;
  final String? lga;
  final String? state;
  final dynamic classification;
  final dynamic isActive;
  final String? ward;
  final String? addedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  ProfileBusinessModel({
    this.businessName,
    this.description,
    this.businessCategory,
    this.country,
    this.stateAndProvince,
    this.city,
    this.street,
    this.postalCode,
    this.image,
    this.instagramUrl,
    this.websiteUrl,
    this.linkedinUrl,
    this.facebookUrl,
    this.phoneNumber,
    this.businessEmail,
    this.operationDays,
    this.cropped,
    this.uncropped,
    this.streetCoordinates,
    this.id,
    this.name,
    this.lga,
    this.state,
    this.classification,
    this.isActive,
    this.ward,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ProfileBusinessModel.fromJson(Map<String, dynamic> json) =>
      ProfileBusinessModel(
        businessName: json["businessName"],
        description: json["description"],
        businessCategory: json["businessCategory"],
        country: json["country"],
        stateAndProvince: json["stateAndProvince"],
        city: json["city"],
        street: json["street"],
        postalCode: json["postalCode"],
        image: json["image"],
        instagramUrl: json["instagramUrl"],
        websiteUrl: json["websiteUrl"],
        linkedinUrl: json["linkedinUrl"],
        facebookUrl: json["facebookUrl"],
        phoneNumber: json["phoneNumber"],
        businessEmail: json["businessEmail"],
        operationDays: json["operationDays"] == null
            ? null
            : OperationDays.fromJson(json["operationDays"]),
        cropped: json["cropped"],
        uncropped: json["uncropped"],
        streetCoordinates: json["streetCoordinates"] == null
            ? null
            : StreetCoordinates.fromJson(json["streetCoordinates"]),
        id: json["id"],
        name: json["name"],
        lga: json["lga"],
        state: json["state"],
        classification: json["classification"],
        isActive: json["isActive"],
        ward: json["ward"],
        addedBy: json["addedBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "businessName": businessName,
        "description": description,
        "businessCategory": businessCategory,
        "country": country,
        "stateAndProvince": stateAndProvince,
        "city": city,
        "street": street,
        "postalCode": postalCode,
        "image": image,
        "instagramUrl": instagramUrl,
        "websiteUrl": websiteUrl,
        "linkedinUrl": linkedinUrl,
        "facebookUrl": facebookUrl,
        "phoneNumber": phoneNumber,
        "businessEmail": businessEmail,
        "operationDays": operationDays?.toJson(),
        "cropped": cropped,
        "uncropped": uncropped,
        "streetCoordinates": streetCoordinates?.toJson(),
        "id": id,
        "name": name,
        "lga": lga,
        "state": state,
        "classification": classification,
        "isActive": isActive,
        "ward": ward,
        "addedBy": addedBy,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class OperationDays {
  // Define the structure for operationDays here
  // Example:
  final List<String>? days;

  OperationDays({this.days});

  factory OperationDays.fromJson(Map<String, dynamic> json) =>
      OperationDays(days: List<String>.from(json["days"] ?? []));

  Map<String, dynamic> toJson() => {
        "days": days,
      };
}

class StreetCoordinates {
  final double? lat;
  final double? lng;

  StreetCoordinates({this.lat, this.lng});

  factory StreetCoordinates.fromJson(Map<String, dynamic> json) =>
      StreetCoordinates(
        lat: (json["lat"] as num?)?.toDouble(),
        lng: (json["lng"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
