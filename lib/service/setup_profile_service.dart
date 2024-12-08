
//   // Future<AuthModel?> login(String email, String password) async {
//   import 'dart:convert';

// import 'package:bizconnect/app/locator.dart';
// import 'package:bizconnect/exceptions/bizcon_exception.dart';
// import 'package:bizconnect/service/network_service.dart';
// import 'package:bizconnect/service/secure_storage_service.dart';
// import 'package:flutter/foundation.dart';

// class ProfileBusinesService {
//  final NetworkService _networkService = getIt<NetworkService>();
//   final SecureStorageService _secureStorageService =
//       getIt<SecureStorageService>();
// Future<void> profileBusiness(String email, String password) async {
//     try {
//       // Create the payload
//       final body = {
//         'email': email.trim(),
//         'password': password.trim(),
//       };

//       debugPrint('Raw payload $body');

//       final response = await _networkService.post(
//         '/api/user/login',
//         data: jsonEncode(body),
//     );
//         debugPrint('response $response');
//      // Step 3: Handle the response
//     if (response != null && response['data'] != null) {
//       final token = response['data']['token']; // Extract token
//       // debugPrint('Received token: $token');

//       // Optional: Decode JWT to get user details
//       final parts = token.split('.');
//       if (parts.length > 1) {
//         final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
//         debugPrint('Decoded token payload: $payload');
//         // _userData = ProfileBusinesService.fromJson(jsonDecode(payload)); 
//       }

//       // Save token securely
//       // await _secureStorage.write(key: 'accessToken', value: token);
//       await _secureStorageService.writeAccessToken(token: token);

//       // Deserialize user data (if provided in response)
//       // debugPrint('User data: $_userData');R
//     } else {
//       throw Exception('Invalid response structure');
//     }
    
//     } on BizException {
//       rethrow;
//     } catch (e) {
//          debugPrint('response error $e');
//       rethrow;
//     }
//     return null;
//     // return userData;
//   }

// }



  // Future<AuthModel?> login(String email, String password) async {
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
      // Create the payload
      // final body = {
      //   'email': email.trim(),
      //   'password': password.trim(),
      // };
      // final body = {
      //   'businessName': businessNameController.text.trim(),
      //   'businessEmail': businessEmailController.text.trim(),
      //   'businessPhoneNumber': businessPhoneNumberController.text.trim(),
      //   'businessCategory': businessCategoryController.text.trim(),
      //   'description': describeYourBusinessController.text.trim(),
      //   'country': selectCountryController.text.trim(),
      //   'state': stateAndProvinceController.text.trim(),
      //   'city': cityController.text.trim(),
      //   'street': streetController.text.trim(),
      //   'zipCode': zipCodePostalCodeController.text.trim(),
      //   'socialLinks': {
      //     'instagram': instagramController.text.trim(),
      //     'website': websiteController.text.trim(),
      //     'tiktok': tiktokController.text.trim(),
      //     'facebook': facebookController.text.trim(),
      //   },
      //   'slots': slots.map((slot) => slot.toJson()).toList(),
      // };

      debugPrint('Raw payload $businessPayload');

      final response = await _networkService.post(
        '/api/business-profile/create',
        data: jsonEncode(businessPayload),
    );
        debugPrint('response $response');
     // Step 3: Handle the response
    if (response != null && response['data'] != null) {
      // final token = response['data']['token']; // Extract token
      // // debugPrint('Received token: $token');
    } else {
      throw Exception('Invalid response structure');
    }
    
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
    final response = await _networkService.get('/api/business-profile/categories');
    
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


//   Future<List<BusinessCategoriesModel>> allBusinessCategories() async {
//   try {
//     final response = await _networkService.get('/api/business-profile/categories');
    
//     // Decode the response into a JSON map
//     final Map<String, dynamic> jsonDecodedPayload = json.decode(response);

//     // Validate that 'data' and 'businessCategories' exist and are of the correct type
//     if (jsonDecodedPayload['data'] != null &&
//         jsonDecodedPayload['data']['businessCategories'] is List) {
//       final List<dynamic> businessCategories = jsonDecodedPayload['data']['businessCategories'];

//       // Debugging output
//       debugPrint('Fetched Categories: $businessCategories');

//       // Map the JSON to BusinessCategoriesModel objects
//       return businessCategories
//           .map((json) => BusinessCategoriesModel.fromJson(json))
//           .toList();
//     } else {
//       throw BizException(message: 'Invalid response structure');
//     }
//   } catch (e, stackTrace) {
//     debugPrint('Error fetching categories: $e\n$stackTrace');
//     throw BizException(message: 'Unable to fetch categories');
//   }
// }


// Future<List<BusinessCategoriesModel>> allBusinessCategories() async {
//   try {
//     final response = await _networkService.get('/api/business-profile/categories');
//     final Map<String, dynamic> jsonDecodedPayload = json.decode(response);

//     // Access the businessCategories array within the data object
//     final List<dynamic> businessCategories = jsonDecodedPayload['data']['businessCategories'];

//     // Print out the categories for debugging purposes
//     debugPrint('Fetched Categories: $businessCategories');
//     // Map each JSON object to a BusinessCategoriesModel
//     return businessCategories
//         .map((json) => BusinessCategoriesModel.fromJson(json))
//         .toList();
//   } catch (e) {
//     debugPrint('Error fetching categories: $e');
//     throw BizException(message: 'Unable to fetch categories');
//   }
// }

// Future<List<BusinessCategoriesModel>> allBusinessCategories() async {
//   try {
//     final response = await _networkService.get('/api/business-profile/categories');
//     final List<dynamic> jsonDecodedPayload = json.decode(response);
//     return jsonDecodedPayload
//         .map((json) => BusinessCategoriesModel.fromJson(json))
//         .toList();
//         debugPrint(jsonDecodedPayload.data.businessCategories);
//   } catch (e) {
//     debugPrint('Error fetching categories: $e');
//     throw BizException(message: 'Unable to fetch categories');
//   }
// }

  //   Future<void> allBusinessCategories() async {
  //   // Send the request to the backend
  //   try {
  //     final response = await _networkService.get(
  //       '/api/business-profile/categories',
  //     );

  //     debugPrint('decrypted response: ${response}');
  //     // List jsonDecodedPayload = json.decode(response);

  //     List<dynamic> jsonDecodedPayload = json.decode(response);
  //     log('log data list $jsonDecodedPayload');
  //   final categories = jsonDecodedPayload
  //       .map((value) => BusinessCategoriesModel.fromJson(value))
  //       .toList();

  //       print(categories);
  //     log('log data categories $categories');

  //   // debugPrint('Parsed categories: $categories');
  //   // return categories;
  //     // _categoriesModel = jsonDecodedPayload
  //     //     .map((value) => CategoriesModel.fromJson(value))
  //     //     .toList();
  //   } on BizException {
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

}