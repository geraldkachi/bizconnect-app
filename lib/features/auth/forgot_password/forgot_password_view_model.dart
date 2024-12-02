import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/toast_service.dart';
import 'package:go_router/go_router.dart';

final forgotPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordViewModel>(
        (ref) => ForgotPasswordViewModel());

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();

  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  void clearField() {
    emailController.text = '';
  }

//   Future<void> forgotPassword(context) async {
//     try {
//       if (formKey.currentState!.validate()) {
//         formKey.currentState!.save();
//         isLoading = true;
//         notifyListeners();
//         await _authService.forgotPassword(emailController.text.toLowerCase());
//         // emailController.clear();
//         router.go('/forgot_password/reset_password');
//         // clearField();
//         isLoading = false;
//         notifyListeners();
//       }
//     } on BizException catch (e) {
//       isLoading = false;
//       notifyListeners();
//       _toastService.showToast(context,
//           title: 'Error', subTitle: e.message ?? '');
//     } catch (e) {
//       isLoading = false;
//       notifyListeners();
//       _toastService.showToast(context,
//           title: 'Error', subTitle: 'Something went wrong.');
//     }
//   }
// }


 Future<void> forgotPassword(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isLoading = true;
        notifyListeners();

        await _authService.forgotPassword(emailController.text.toLowerCase());
        emailController.clear();
        clearField();
        
        isLoading = false;
        notifyListeners();
      }
    } on Exception catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(
        context,
        title: 'Error',
        subTitle: e.toString(),
      );
    }
  }
}