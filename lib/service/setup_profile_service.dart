import 'dart:convert';
import 'dart:developer';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/business_category.dart';
import 'package:bizconnect/models/google_place_result.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:flutter/foundation.dart';

class ProfileBusinessService {
  final NetworkService _networkService = getIt<NetworkService>();

  List<Map<String, dynamic>> _businessCategories = [];
  List<Map<String, dynamic>> get businessCategories => _businessCategories;

  Future<void> profileBusiness(Map<String, dynamic> businessPayload) async {
    try {
      debugPrint('Raw payload $businessPayload');

      final response = await _networkService.post(
        '/api/business-profile/create',
        data: jsonEncode(businessPayload),
      );
      debugPrint('response create profile $response');
    } on BizException {
      rethrow;
    } catch (e) {
      debugPrint('response error $e');
      rethrow;
    }
    return;
  }

  Future<void> updateBusiness(
      Map<String, dynamic> businessPayload, String id) async {
    try {
      debugPrint('Raw payload $businessPayload');

      final response = await _networkService.post(
        '/api/business-profile/update/$id',
        data: jsonEncode(businessPayload),
      );
      debugPrint('response update profile $response');
    } on BizException {
      rethrow;
    } catch (e) {
      debugPrint('response error $e');
      rethrow;
    }
    return;
  }

  Future<BusinessCategoriesModel> allBusinessCategories() async {
    try {
      final response =
          await _networkService.get('/api/business-profile/categories');
      final Map<String, dynamic> jsonDecodedPayload = response;
      if (jsonDecodedPayload['data'] != null) {
        print('Fetched Categories: $jsonDecodedPayload');
        return BusinessCategoriesModel.fromJson(jsonDecodedPayload);
      } else {
        throw BizException(message: 'Invalid response structure');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching categories: $e\n$stackTrace');
      throw BizException(message: 'Unable to fetch categories');
    }
  }
 

  Future<BusinessCategoriesModel> allBusinessList() async {
    try {
      final response = await _networkService.get('/api/business-profile/list');
      final Map<String, dynamic> jsonDecodedPayload = response;
      if (jsonDecodedPayload['data'] != null) {
        print('Fetched Business Listing: $jsonDecodedPayload');
        return BusinessCategoriesModel.fromJson(jsonDecodedPayload);
      } else {
        throw BizException(message: 'Invalid response structure');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching business listing: $e\n$stackTrace');
      throw BizException(message: 'Unable to fetch business listing');
    }
  }

  Future<StressSuggestionsResponse> fetchStreetSuggestions(
      String query, String country, String state, String city) async {
    try {
      final url = '/api/business-profile/location/suggest?query=$query&country=$country&city=$city&state=$state';
      final response = await _networkService.get(url);
    // log('API street response: $response');
    // Check and extract suggestions
    if (response['data'] != null && response['data']['suggestions'] is List) {
      return StressSuggestionsResponse.fromJson(response);
    } else {
      throw BizException(message: 'Invalid response structure');
    }
    } catch (e, stackTrace) {
      debugPrint('Error fetching street suggestions: $e\n$stackTrace');
      throw BizException(message: 'Unable to fetch street suggestions');
    }
  }

 String cloudinaryApiKey = '877589337471488';
  static const String cloudName = 'dshq6chfl';
  static const String apiKey = "877589337471488";
  static const String apiSecret = "your_api_secret";

  Future<Map<String, dynamic>> getUploadSignature(String folderPath) async {
    final response = await _networkService.get("/api/business-profile/upload-signature?folderPath=$folderPath");
      log('upload-signature $response');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get upload signature");
    }
  }

  Future<Map<String, dynamic>> uploadImage({
    required File imageFile,
    required String folderPath,
    required Map<String, dynamic> signature,
  }) async {
    final uri = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/auto/upload",
    );

    final request = http.MultipartRequest("POST", uri)
      ..fields["folder"] = folderPath
      ..fields["signature"] = signature["signature"]
      ..fields["timestamp"] = signature["timestamp"].toString()
      ..fields["api_key"] = apiKey
      ..files.add(await http.MultipartFile.fromPath("file", imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to upload image");
    }
  }

}
