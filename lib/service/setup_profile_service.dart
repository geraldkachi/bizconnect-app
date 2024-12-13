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

  Future<void> updateBusiness(Map<String, dynamic> businessPayload, String id) async {
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
      final response = await _networkService.get('/api/business-profile/categories');
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
}
