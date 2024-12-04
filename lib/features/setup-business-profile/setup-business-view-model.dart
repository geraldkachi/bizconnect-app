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
  class Slot {
  String day;
  String openTime;
  String closeTime;

  Slot({required this.day, required this.openTime, required this.closeTime});
}

// List<Slot> slots = [];


class SetupBusinessProfileViewModel extends ChangeNotifier {
  final AuthService _authService = getIt<AuthService>();
  final ToastService _toastService = getIt<ToastService>();
  
    List<Slot> slots = [];

   void addSlot(Slot slot) {
    slots.add(slot);
    notifyListeners();
  }

  void deleteSlot(Slot slot) {
    slots.remove(slot);
    notifyListeners();
  }

  bool obscureText = true;
  bool isLoading = false;
  

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController describeYourBusinessController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  // TextEditingController passController = TextEditingController();
  TextEditingController selectCountryController = TextEditingController();
  TextEditingController stateAndProvinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController zipCodePostalCodeController = TextEditingController();
  TextEditingController uploadImage = TextEditingController();

  TextEditingController dayController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();

// void handleAddSlot(BuildContext context) {
//   if (dayController.text.isEmpty ||
//       openTimeController.text.isEmpty ||
//       closeTimeController.text.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('All fields are required')),
//     );
//     return;
//   }

//   final slot = Slot(
//     day: dayController.text,
//     openTime: openTimeController.text,
//     closeTime: closeTimeController.text,
//   );

//   // Add slot to ViewModel's list
//   context.read(setupBusinessProfileViewModelProvider).addSlot(slot);

//   // Clear fields after adding
//   dayController.clear();
//   openTimeController.clear();
//   closeTimeController.clear();
// }

// void handleDeleteSlot(BuildContext context, Slot slot) {
//   context.read(setupBusinessProfileViewModelProvider).deleteSlot(slot);
// }



  // final List<Slot> slots = [];

  // void addSlot(Slot slot) {
  //   slots.add(slot);
  //   notifyListeners();
  // }

  // void deleteSlot(Slot slot) {
  //   slots.remove(slot);
  //   notifyListeners();
  // }
  
void handleAddSlot(BuildContext context, SetupBusinessProfileViewModel viewModel) {
  if (viewModel.dayController.text.isEmpty ||
      viewModel.openTimeController.text.isEmpty ||
      viewModel.closeTimeController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All fields are required')),
    );
    return;
  }

  final slot = Slot(
    day: viewModel.dayController.text,
    openTime: viewModel.openTimeController.text,
    closeTime: viewModel.closeTimeController.text,
  );

  viewModel.addSlot(slot);

  // Clear fields after adding
  viewModel.dayController.clear();
  viewModel.openTimeController.clear();
  viewModel.closeTimeController.clear();
}


  final GlobalKey<FormState> formKey = GlobalKey();

  Future setupProfile(context) async {
      //  router.go('/verify-account');
       if (slots.isEmpty) {
    _toastService.showToast(
      context,
      title: 'Error',
      subTitle: 'You must add at least one slot.',
    );
    return;
  }
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        isLoading = true;
        notifyListeners();
   
        businessCategoryController.clear();
        businessNameController.clear();
        businessEmailController.clear();
        describeYourBusinessController.clear();
        describeYourBusinessController.clear();
        selectCountryController.clear();
        stateAndProvinceController.clear();
        cityController.clear();
        streetController.clear();
        zipCodePostalCodeController.clear();

       notifyListeners();
       
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
