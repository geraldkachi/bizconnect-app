// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {  
    final String? uuid;
    final String? id;
    final String? firstName;
    final String? lastName;
    final String? email;
    final String? phoneNumber;
    final String? password;
    final String? confirmPassword;
    final bool? isActive;
    final bool? verified;
    final String? role;

    final bool? emailNotification;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final dynamic deletedAt;

    AuthModel({
        this.uuid,
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.password,
        this.confirmPassword,
        this.isActive,
        this.verified,
        this.role,
        this.emailNotification,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        uuid: json["uuid"],
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
        isActive: json["isActive"],
        role: json["role"],
        verified: json["verified"],
        emailNotification: json["emailNotification"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "confirmPassword": confirmPassword,
        "isActive": isActive,
        "role": role,
        "verified": verified,
        "emailNotification": emailNotification,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
    };
}
