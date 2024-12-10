import 'dart:convert';
import 'dart:developer';

import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/business_category.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
// import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

class ProfileBusinessService {
  final NetworkService _networkService = getIt<NetworkService>();
  // final SecureStorageService _secureStorageService =
  //     getIt<SecureStorageService>();
  // CategoriesModel? _transactionList;

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
    // return userData;
  }

  Future<BusinessCategoriesModel> allBusinessCategories() async {
    try {
      final response =
          await _networkService.get('/api/business-profile/categories');

      // Decode the response into a JSON map
      final Map<String, dynamic> jsonDecodedPayload = response;

      // Validate that 'data' and 'businessCategories' exist and are of the correct type
      if (jsonDecodedPayload['data'] != null) {
        //  _businessCategories = jsonDecodedPayload['data']['businessCategories'];

        // Debugging output
        print('Fetched Categories: $jsonDecodedPayload');

        // Map the JSON to BusinessCategoriesModel objects
        return BusinessCategoriesModel.fromJson(jsonDecodedPayload);

        // businessCategories
        //     .map((json) => BusinessCategoriesModel.fromJson(json))
        //     .toList();
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
      final response =
          await _networkService.get('/api/business-profile/list');
      // Decode the response into a JSON map
      final Map<String, dynamic> jsonDecodedPayload = response;

      // Validate that 'data' and 'businessCategories' exist and are of the correct type
      if (jsonDecodedPayload['data'] != null) {
        //  _businessCategories = jsonDecodedPayload['data']['businessCategories'];

        // Debugging output
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
}
