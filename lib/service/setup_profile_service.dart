
  // Future<AuthModel?> login(String email, String password) async {
  import 'dart:convert';

import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:flutter/foundation.dart';

class ProfileBusinesService {
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