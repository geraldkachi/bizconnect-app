import 'dart:convert';
import 'dart:developer';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/business%20details_model.dart';
import 'package:bizconnect/models/my_business_list.dart';
import 'package:bizconnect/models/profile_business.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

class MyBusinessService {
  final NetworkService _networkService = getIt<NetworkService>();

  // List<Map<String, dynamic>> _businessCategories = [];
  // List<Map<String, dynamic>> get businessCategories => _businessCategories;


  Future<MyBusinessListModel> allBusinessList() async {
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
        return MyBusinessListModel.fromJson(jsonDecodedPayload);
      } else {
        throw BizException(message: 'Invalid response structure');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching business listing: $e\n$stackTrace');
      throw BizException(message: 'Unable to fetch business listing');
    }
  }
  
// Fetches single business details by ID
  Future<BusinessProfileDetailModel> getBusinessDetails(String id,) async {
    try {
      final response = await _networkService.get('/api/business-profile/list/$id?tid=${DateTime.now().millisecondsSinceEpoch}');
      final Map<String, dynamic> jsonDecodedPayload = response;
      if (jsonDecodedPayload['data'] != null &&
          jsonDecodedPayload['data']['details'] != null) {
        return BusinessProfileDetailModel.fromJson(jsonDecodedPayload['data']['details']);
      } else {
        throw BizException(message: 'Invalid response structure');
      }
    } catch (e, stackTrace) {
      debugPrint('Error fetching business details: $e\n$stackTrace');
      throw BizException(message: 'Unable to fetch business details');
    }
  }

}
