import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/error_model.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:bizconnect/service/toast_service.dart';

final signUpViewModelProvider =
    ChangeNotifierProvider.autoDispose<SignUpViewModel>(
        (ref) => SignUpViewModel());

class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();

  bool obscureText = true;
  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  Future signUp(context) async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isLoading = true;
        notifyListeners();
        await _authService.signup(
          firstNameController.text.toLowerCase(),
          lastNameController.text.toLowerCase(),
          emailController.text.toLowerCase(),
          passController.text.toLowerCase(),
          confirmPassController.text.toLowerCase(),
        );
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passController.clear();
        confirmPassController.clear();
        router.go('/verify-account');
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
          title: 'Error', subTitle: 'Something went wrong. $e');
    }
  }

  void togglePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
