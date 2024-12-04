import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/error_model.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/service/secure_storage_service.dart';
import 'package:bizconnect/service/toast_service.dart';

final setupBusinessProfileViewModelProvider =
    ChangeNotifierProvider.autoDispose<SetupBusinessProfileViewModel>(
        (ref) => SetupBusinessProfileViewModel());

class SetupBusinessProfileViewModel extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();
 

  bool obscureText = true;
  bool isLoading = false;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController describeYourBusinessController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  // TextEditingController passController = TextEditingController();
  TextEditingController selectCountryController = TextEditingController();
  TextEditingController stateAndProvinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController zipCodePostalCodeController = TextEditingController();
  TextEditingController uploadImage = TextEditingController();



  final GlobalKey<FormState> formKey = GlobalKey();

  Future setupProfile(context) async {
      //  router.go('/verify-account');
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isLoading = true;
        notifyListeners();
        // final response = await _authService.profileBusiness(
        //     businessNameController.text.toLowerCase(), 
        //     describeYourBusinessController.text.toLowerCase(),
        //     businessCategoryController.text.toLowerCase(),
        //     selectCountryController.text.toLowerCase(),
        //     stateAndProvinceController.text.toLowerCase(),
        //     cityController.text.toLowerCase(),
        //     streetController.text.toLowerCase(),
        //     zipCodePostalCodeController.text.toLowerCase(),
        //     );


        businessCategoryController.clear();
        businessNameController.clear();
        describeYourBusinessController.clear();
        describeYourBusinessController.clear();
        selectCountryController.clear();
        stateAndProvinceController.clear();
        cityController.clear();
        streetController.clear();
        zipCodePostalCodeController.clear();

        // passController.clear();

       notifyListeners();
          
      // if(response != null) {
      // final role = response.role; 
      // final verified = response.verified?? false; 

      // print(role);
      // print(verified);
      //   if (verified) {
      //     if (_authService.userRole == 'BUSINESS') {
      //       router.go('/setup-business-profile');
      //     } else if (role == 'CUSTOMER') {
      //       router.go('/main_screen');
      //     }
      //   } else {
      //     router.go('/verify-account');
      //   }
      // }


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
          title: 'Error', subTitle: 'Something went wrong.');
    }
  }

  void togglePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }
  // for imaage

}
