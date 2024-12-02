import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ErrorModel {
  final bool? status;
  final String? message;
  ErrorModel({
    this.status,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      status: map['status'] != null ? map['status'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
