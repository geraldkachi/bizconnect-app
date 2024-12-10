import 'dart:convert';

import 'package:bizconnect/models/auth_model.dart';
import 'package:bizconnect/models/error_model.dart';
import 'package:flutter/material.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
// import 'package:bizconnect/models/admin_model.dart';
// import 'package:bizconnect/models/error_model.dart';
// import 'package:bizconnect/service/encryption_service.dart';
import 'package:bizconnect/service/network_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:go_router/go_router.dart';

class AuthService {
  final NetworkService _networkService = getIt<NetworkService>();
  final SecureStorageService _secureStorageService =
      getIt<SecureStorageService>();

  AuthModel? _userData;
  AuthModel? get userData => _userData;

  ErrorModel? errorModel;

  String get userRole => _userData?.role ?? ''; // Fetch user role
  bool get userVerified => _userData?.verified ?? false; // Fetch verification status

  Future<void> signup(String firstName, String lastName, String email, String password, String confirmPassword ) async {
    try {
      // Create the payload
      final payload = {
        'firstName' : firstName.trim(),
        'lastName' : lastName.trim(),
        'email': email.trim(),
        'password': password.trim(),
        'confirmPassword': confirmPassword.trim()
      };

      debugPrint('Raw payload $payload');
      // Encrypt the payload
      // final encryptedPayload = _encryptionService.encrypt(payload);

      // Send the encrypted payload to the backend
      final response = await _networkService.post(
        '/api/user/register',
        data: payload,
        // data: {'payload': encryptedPayload},
      );
      if (response != null && response['data'] != null) {
      final token = response['data']['token']; // Extract token
      // debugPrint('Received token: $token');

      // Optional: Decode JWT to get user details
      final parts = token.split('.');
      if (parts.length > 1) {
        final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
        debugPrint('Decoded token payload: $payload');
        _userData = AuthModel.fromJson(jsonDecode(payload)); 
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
      debugPrint('response: $e');
      rethrow;
    }
  }
  
  Future<AuthModel?> login(String email, String password) async {
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
      // final token = response['data']['token']; // Extract token
      // debugPrint('Received token: $token');

       String tokenWithBearer = response['data']['token']; // Extract token with "Bearer"
      debugPrint('Received token with Bearer: $tokenWithBearer');

      // Trim the "Bearer " prefix
      String token = tokenWithBearer.replaceFirst('Bearer ', '').trim();
      debugPrint('Trimmed token: $token');

      

      // Optional: Decode JWT to get user details
      final parts = token.split('.');
      if (parts.length > 1) {
        final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
        debugPrint('Decoded token payload: $payload');
        _userData = AuthModel.fromJson(jsonDecode(payload));
      }

      // Save token securely
      // await _secureStorage.write(key: 'accessToken', value: token);
      await _secureStorageService.writeAccessToken(token: token);

      // Deserialize user data (if provided in response)
      // debugPrint('User data: $_userData');R
    } else {
      throw Exception('Invalid response structure');
    }
    
      // final responsePayload = response;
      // debugPrint('Raw payload $responsePayload');
      // // debugPrint('Raw payload $responsePayload');
      // final token = response['data']['token'];
      // debugPrint('token: $token');
      // debugPrint('encrypted response: $responsePayload');
      // debugPrint('decrypted response: ${response.toString()}');
      // _userData = AuthModel.fromJson(json.decode(responsePayload));
      // debugPrint('userData: $_userData');
      // _secureStorageService.writeAccessToken(token: token);
    } on BizException {
      rethrow;
    } catch (e) {
         debugPrint('response error $e');
      rethrow;
    }
    return userData;
  }


String? getRedirectUrl() {
  // Retrieve the redirect URL logic, or return null for defaults
  return null; // Replace with your actual logic
}

  void logout() {
    _secureStorageService.deleteAccessToken();
    router.go('/');
  }

  Future<void> forgotPassword(
    String email,
  ) async {
    try {
      // Create the payload
      final payload = email.trim();

      debugPrint('Raw payload $payload');
  
      final response = await _networkService.get(
        '/api//user/generate/forgot_password/$payload',
      );
      final responsePayload = response;
      debugPrint('encrypted response: $responsePayload');
      //  final token = response['data']['token'];
      // debugPrint('token: $token');

      debugPrint('decrypted response: ${response.toString()}');
      _userData = AuthModel.fromJson((responsePayload));
      debugPrint('userData: $_userData');
      // _secureStorageService.writeAccessToken(token: token);

    } on BizException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String password, String otp, String email) async {
    try {
      // Create the payload
      final payload =
          {'otp': otp, 'password': password.trim(), 'email': email};

      debugPrint('Raw payload $payload');
      // Encrypt the payload
      // final encryptedPayload = _encryptionService.encrypt(payload);

      // Send the encrypted payload to the backend
      final response = await _networkService.post(
        '/user/reset-password',
        // data: {'payload': encryptedPayload},
        data: {'payload': payload},
      );
      final responsePayload = response['data'];
      debugPrint('encrypted response: $responsePayload');
      // final decryptedResponsePayload =
      //     _encryptionService.decrypt(responsePayload);
      debugPrint('decrypted response: ${responsePayload.toString()}');
      // _userData = AuthModel.fromJson(json.decode(decryptedResponsePayload));
      // _secureStorageService.writeAccessToken(token: token);
    } on BizException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}