import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/error_model.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:bizconnect/service/toast_service.dart';

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>(
        (ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();
 

  bool obscureText = true;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Future login(context) async {
     final SecureStorageService _secureStorageService = getIt<SecureStorageService>();
      String? token = await _secureStorageService.readAccessToken();
      //  router.go('/verify-account');
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isLoading = true;
        notifyListeners();
        final response = await _authService.login(
            emailController.text.toLowerCase(), passController.text);
        emailController.clear();
        passController.clear();

       notifyListeners();
          
      if(response != null) {
      final role = response.role; 
      final verified = response.verified?? false; 

      print(role);
      print(verified);
        if (verified) {
          if (_authService.userRole == 'BUSINESS') {
            // router.go('/setup-business-profile');
          } else if (role == 'CUSTOMER') {
            router.go('/setup-business-profile');
            // router.go('/main_screen');
          }
        } else {
          router.go('/verify-account');
        }
      }


        isLoading = false;
        notifyListeners();
      }
    } on BizException catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error', subTitle: e.message ?? '');
    } catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error', subTitle: '$e.message Something went wrong.');
    }
  }

  void togglePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
