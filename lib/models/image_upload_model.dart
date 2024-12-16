class BaseResponseMessage {
  final bool? success;
  final BaseMessage message;
  final dynamic data;

  BaseResponseMessage({
    required this.success,
    required this.message,
    this.data,
  });

  factory BaseResponseMessage.fromJson(Map<String, dynamic> json) {
    return BaseResponseMessage(
      success: json['success'] as bool?,
      message: BaseMessage.fromJson(json['message']),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message.toJson(),
      'data': data,
    };
  }
}

class UploadSignature extends BaseResponseMessage {
  final UploadData? uploadData;

  UploadSignature({
    required bool? success,
    required BaseMessage message,
    this.uploadData,
  }) : super(success: success, message: message, data: uploadData);

  factory UploadSignature.fromJson(Map<String, dynamic> json) {
    return UploadSignature(
      success: json['success'] as bool?,
      message: BaseMessage.fromJson(json['message']),
      uploadData: json['data'] != null
          ? UploadData.fromJson(json['data'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message.toJson(),
      'data': uploadData?.toJson(),
    };
  }
}

class UploadData {
  final int timestamp;
  final String signature;

  UploadData({
    required this.timestamp,
    required this.signature,
  });

  factory UploadData.fromJson(Map<String, dynamic> json) {
    return UploadData(
      timestamp: json['timestamp'] as int,
      signature: json['signature'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'signature': signature,
    };
  }
}

class BaseMessage {
  final String text;

  BaseMessage({required this.text});

  factory BaseMessage.fromJson(Map<String, dynamic> json) {
    return BaseMessage(
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
