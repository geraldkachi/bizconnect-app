import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
const String cloudinaryCloudName = 'dshq6chfl'; // Replace with your Cloudinary cloud name

const String cloudinaryApiKey = '877589337471488';
class CloudinaryConfig {
  static const String apiKey = cloudinaryApiKey;
  static const String cloudName = cloudinaryCloudName;
}

class UploadSignature {
  final String signature;
  final int timestamp;

  UploadSignature({required this.signature, required this.timestamp});

  factory UploadSignature.fromJson(Map<String, dynamic> json) {
    return UploadSignature(
      signature: json['signature'],
      timestamp: json['timestamp'], 
    );
  }
}

class CloudinaryUploadResponse {
  final String publicId;
  final String secureUrl;

  CloudinaryUploadResponse({required this.publicId, required this.secureUrl});

  factory CloudinaryUploadResponse.fromJson(Map<String, dynamic> json) {
    return CloudinaryUploadResponse(
      publicId: json['public_id'],
      secureUrl: json['secure_url'],
    );
  }
}

Future<UploadSignature> getUploadSignature(String folderPath) async {
  // Replace with your API endpoint to fetch the signature
  final response = await http.get(Uri.parse('<your-api-endpoint>?folder=$folderPath'));

  if (response.statusCode == 200) {
    return UploadSignature.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch upload signature');
  }
}

Future<CloudinaryUploadResponse> uploadMediaToCloudinary({
  required String mediaPath,
  required String folderPath,
}) async {
  final signature = await getUploadSignature(folderPath);

  final request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/auto/upload'),
  );

  request.fields['folder'] = folderPath;
  request.fields['signature'] = signature.signature;
  request.fields['timestamp'] = signature.timestamp.toString();
  request.fields['api_key'] = CloudinaryConfig.apiKey;
  request.files.add(await http.MultipartFile.fromPath('file', mediaPath));

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    return CloudinaryUploadResponse.fromJson(jsonDecode(responseData));
  } else {
    throw Exception('Failed to upload media to Cloudinary');
  }
}

String constructCloudinaryUrl(String publicId) {
  return 'https://res.cloudinary.com/${CloudinaryConfig.cloudName}/image/upload/$publicId';
}
