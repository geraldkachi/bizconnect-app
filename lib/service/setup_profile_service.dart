
  // Future<AuthModel?> login(String email, String password) async {
  import 'dart:convert';

import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

class ProfileBusinessService {
 final NetworkService _networkService = getIt<NetworkService>();
  final SecureStorageService _secureStorageService =
      getIt<SecureStorageService>();
Future<void> profileBusiness(String email, String password) async {
    try {
      // Create the payload
      final body = {
        'email': email.trim(),
        'password': password.trim(),
      };

      debugPrint('Raw payload $body');

      final response = await _networkService.post(
        '/api/user/login',
        data: jsonEncode(body),
    );
        debugPrint('response $response');
     // Step 3: Handle the response
    if (response != null && response['data'] != null) {
      final token = response['data']['token']; // Extract token
      // debugPrint('Received token: $token');

      // Optional: Decode JWT to get user details
      final parts = token.split('.');
      if (parts.length > 1) {
        final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
        debugPrint('Decoded token payload: $payload');
        // _userData = ProfileBusinesService.fromJson(jsonDecode(payload)); 
      }

      // Save token securely
      // await _secureStorage.write(key: 'accessToken', value: token);
      await _secureStorageService.writeAccessToken(token: token);

      // Deserialize user data (if provided in response)
      // debugPrint('User data: $_userData');R
    } else {
      throw Exception('Invalid response structure');
    }
    
    } on BizException {
      rethrow;
    } catch (e) {
         debugPrint('response error $e');
      rethrow;
    }
    return null;
    // return userData;
  }

}



  // Future<AuthModel?> login(String email, String password) async {
//   import 'dart:convert';

// import 'package:bizconnect/app/locator.dart';
// import 'package:bizconnect/exceptions/bizcon_exception.dart';
// import 'package:bizconnect/service/network_service.dart';
// import 'package:bizconnect/service/secure_storage_service.dart';
// // import 'package:bizconnect/service/secure_storage_service.dart';
// import 'package:flutter/foundation.dart';

// class ProfileBusinessService {
//  final NetworkService _networkService = getIt<NetworkService>();
//   final SecureStorageService _secureStorageService =
//       getIt<SecureStorageService>();
      
// Future<void> profileBusiness(Map<String, dynamic> businessPayload) async {
//     try {
//       // Create the payload
//       // final body = {
//       //   'email': email.trim(),
//       //   'password': password.trim(),
//       // };
//       // final body = {
//       //   'businessName': businessNameController.text.trim(),
//       //   'businessEmail': businessEmailController.text.trim(),
//       //   'businessPhoneNumber': businessPhoneNumberController.text.trim(),
//       //   'businessCategory': businessCategoryController.text.trim(),
//       //   'description': describeYourBusinessController.text.trim(),
//       //   'country': selectCountryController.text.trim(),
//       //   'state': stateAndProvinceController.text.trim(),
//       //   'city': cityController.text.trim(),
//       //   'street': streetController.text.trim(),
//       //   'zipCode': zipCodePostalCodeController.text.trim(),
//       //   'socialLinks': {
//       //     'instagram': instagramController.text.trim(),
//       //     'website': websiteController.text.trim(),
//       //     'tiktok': tiktokController.text.trim(),
//       //     'facebook': facebookController.text.trim(),
//       //   },
//       //   'slots': slots.map((slot) => slot.toJson()).toList(),
//       // };

//       debugPrint('Raw payload $businessPayload');

//       final response = await _networkService.post(
//         '/api/business-profile/create',
//         data: jsonEncode(businessPayload),
//     );
//         debugPrint('response $response');
//      // Step 3: Handle the response
//     if (response != null && response['data'] != null) {
//       // final token = response['data']['token']; // Extract token
//       // // debugPrint('Received token: $token');

//       // // Optional: Decode JWT to get user details
//       // final parts = token.split('.');
//       // if (parts.length > 1) {
//       //   final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
//       //   debugPrint('Decoded token payload: $payload');
//       //   // _userData = ProfileBusinesService.fromJson(jsonDecode(payload)); 
//       // }

//       // // Save token securely
//       // // await _secureStorage.write(key: 'accessToken', value: token);
//       // await _secureStorageService.writeAccessToken(token: token);

//     } else {
//       throw Exception('Invalid response structure');
//     }
    
//     } on BizException {
//       rethrow;
//     } catch (e) {
//          debugPrint('response error $e');
//       rethrow;
//     }
//     return;
//     // return userData;
//   }

// }