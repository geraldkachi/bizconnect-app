// import 'package:bizconnect/service/network_service.dart';
// import 'package:bizconnect/service/setup_profile_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:bizconnect/app/locator.dart';
// import 'package:bizconnect/app/router.dart';
// import 'package:bizconnect/exceptions/bizcon_exception.dart';
// import 'package:bizconnect/models/error_model.dart';
// import 'package:bizconnect/service/auth_service.dart';
// import 'package:bizconnect/service/secure_storage_service.dart';
// import 'package:bizconnect/service/toast_service.dart';

// final setupBusinessProfileViewModelProvider =
//     ChangeNotifierProvider.autoDispose<SetupBusinessProfileViewModel>(
//         (ref) => SetupBusinessProfileViewModel());
//   class Slot {
//   String day;
//   String openTime;
//   String closeTime;

//   Slot({required this.day, required this.openTime, required this.closeTime});
// }

// class SetupBusinessProfileViewModel extends ChangeNotifier {
//     // final ProfileBusinessService _profileBusinessService = getIt<ProfileBusinessService>();
//   // final AuthService _authService = getIt<AuthService>();
//   final ToastService _toastService = getIt<ToastService>();
  
//     List<Slot> slots = [];

//    void addSlot(Slot slot) {
//     slots.add(slot);
//     notifyListeners();
//   }

//   void deleteSlot(Slot slot) {
//     slots.remove(slot);
//     notifyListeners();
//   }

//   bool obscureText = true;
//   bool isLoading = false;
//   int prevIndex = 0;

//   TextEditingController businessNameController = TextEditingController();
//   TextEditingController businessEmailController = TextEditingController();
//   TextEditingController businessPhoneNumberController = TextEditingController();
//   TextEditingController describeYourBusinessController = TextEditingController();
//   TextEditingController businessCategoryController = TextEditingController();
//   // TextEditingController passController = TextEditingController();
//   TextEditingController selectCountryController = TextEditingController();
//   TextEditingController stateAndProvinceController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController streetController = TextEditingController();
//   TextEditingController zipCodePostalCodeController = TextEditingController();
//   TextEditingController uploadImage = TextEditingController();

//   TextEditingController instagramController = TextEditingController();
//   TextEditingController websiteController = TextEditingController();
//   TextEditingController tiktokController = TextEditingController();
//   TextEditingController facebookController = TextEditingController();

//   TextEditingController dayController = TextEditingController();
//   TextEditingController openTimeController = TextEditingController();
//   TextEditingController closeTimeController = TextEditingController();

// void handleAddSlot(BuildContext context, SetupBusinessProfileViewModel viewModel) {
//   if (viewModel.dayController.text.isEmpty ||
//       viewModel.openTimeController.text.isEmpty ||
//       viewModel.closeTimeController.text.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('All fields are required')),
//     );
//     return;
//   }

//   final slot = Slot(
//     day: viewModel.dayController.text,
//     openTime: viewModel.openTimeController.text,
//     closeTime: viewModel.closeTimeController.text,
//   );

//   viewModel.addSlot(slot);

//   // Clear fields after adding
//   viewModel.dayController.clear();
//   viewModel.openTimeController.clear();
//   viewModel.closeTimeController.clear();
// }


//   final GlobalKey<FormState> formKey = GlobalKey();

//   Future<void> setupProfileBusiness(context) async {
//       //  router.go('/verify-account');
//        if (slots.isEmpty) {
//       _toastService.showToast(context, title: 'Error', subTitle: 'You must add at least one slot.');
//       return;
//     }

//     try {
//       // if (formKey.currentState!.validate()) {
//       //   formKey.currentState!.save();
//       //   isLoading = true;
//       //   notifyListeners();
        
//       //    await _profileBusinessService.profileBusiness(
//       //     businessCategoryController.text.toLowerCase(),
//       //     businessNameController.text.toLowerCase(),
//       //     // businessEmailController.text.toLowerCase(),
//       //     // describeYourBusinessController.text.toLowerCase(),
//       //     // selectCountryController.text.toLowerCase(),
//       //   );
   
//       //   businessCategoryController.clear();
//       //   businessNameController.clear();
//       //   businessEmailController.clear();
//       //   describeYourBusinessController.clear();
//       //   describeYourBusinessController.clear();
//       //   selectCountryController.clear();
//       //   stateAndProvinceController.clear();
//       //   cityController.clear();
//       //   streetController.clear();
//       //   zipCodePostalCodeController.clear();

//       //  notifyListeners();
//       //  router.go('/main_screen');
       
//       //   isLoading = false;
//       //   notifyListeners();
//       // }

//       isLoading = true;
//       notifyListeners();

//       final payload = {
//         'businessName': businessNameController.text.trim(),
//         'businessEmail': businessEmailController.text.trim(),
//         'businessPhoneNumber': businessPhoneNumberController.text.trim(),
//         'businessCategory': businessCategoryController.text.trim(),
//         'description': describeYourBusinessController.text.trim(),
//         'country': selectCountryController.text.trim(),
//         'state': stateAndProvinceController.text.trim(),
//         'city': cityController.text.trim(),
//         'street': streetController.text.trim(),
//         'zipCode': zipCodePostalCodeController.text.trim(),
//         'socialLinks': {
//           'instagram': instagramController.text.trim(),
//           'website': websiteController.text.trim(),
//           'tiktok': tiktokController.text.trim(),
//           'facebook': facebookController.text.trim(),
//         },
//         // 'slots': slots.map((slot) => slot.toJson()).toList(),
//       };

//       // await _profileBusinessService.profileBusiness(payload);
//       void clearAllFields() {
//     for (final controller in [
//       businessNameController,
//       businessEmailController,
//       businessPhoneNumberController,
//       describeYourBusinessController,
//       businessCategoryController,
//       selectCountryController,
//       stateAndProvinceController,
//       cityController,
//       streetController,
//       zipCodePostalCodeController,
//       instagramController,
//       websiteController,
//       tiktokController,
//       facebookController,
//     ]) {
//       controller.clear();
//     }
//   }
//       // Clear all fields
//       clearAllFields();
//       router.go('/main_screen');
//     } on BizException catch (e) {
//       // isLoading = false;
//       notifyListeners();
//       _toastService.showToast(context,
//           title: 'Error', subTitle: e.message ?? '');
//     } catch (e) {
//       isLoading = false;
//       notifyListeners();
//       _toastService.showToast(context,
//           title: 'Error', subTitle: 'Something went wrong.');
//     } finally {
//       isLoading = false;
//       notifyListeners();
//   }

//   void togglePassword() {
//     obscureText = !obscureText;
//     notifyListeners();
//   }
//   // for imaage

//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/service/setup_profile_service.dart';
import 'package:bizconnect/service/toast_service.dart';
import 'package:bizconnect/utils/business_profile_data.dart';
import 'package:bizconnect/widget/datetime_slot.dart';
// import 'package:bizconnect/service/profile_business_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

// class Slot {
//   String day;
//   String openTime;
//   String closeTime;

//   Slot({required this.day, required this.openTime, required this.closeTime});

//   Map<String, String> toJson() => {
//         'day': day,
//         'openTime': openTime,
//         'closeTime': closeTime,
//       };
// }

final setupBusinessProfileViewModelProvider =
    ChangeNotifierProvider.autoDispose<SetupBusinessProfileViewModel>(
        (ref) => SetupBusinessProfileViewModel());

class SetupBusinessProfileViewModel extends ChangeNotifier {
  final ProfileBusinessService _profileBusinessServiceProfileBusinessService = getIt<ProfileBusinessService>();
  final ToastService _toastService = getIt<ToastService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessPhoneNumberController = TextEditingController();
  TextEditingController describeYourBusinessController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController selectCountryController = TextEditingController();
  TextEditingController stateAndProvinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController zipCodePostalCodeController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController linkedinUrlController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  // Slot-related
  TextEditingController dayController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();

  int prevIndex = 0;
  bool obscureText = true;
  bool isLoading = false;

  // List<Slot> slots = [];
  // void addSlot(Slot slot) {
  //   slots.add(slot);
  //   notifyListeners();
  // }

  // void deleteSlot(Slot slot) {
  //   slots.remove(slot);
  //   notifyListeners();
  // }

  void togglePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  // void handleAddSlot(BuildContext context) {
  //   if (dayController.text.isEmpty || openTimeController.text.isEmpty || closeTimeController.text.isEmpty) {
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

  //   addSlot(slot);

  //   // Clear fields
  //   dayController.clear();
  //   openTimeController.clear();
  //   closeTimeController.clear();
  // }

  // image 
  File? selectedImage;
  String? fileName;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
        selectedImage = File(image.path);
        fileName = image.name;
        notifyListeners();
      await cropImage(); // Prompt user to crop immediately after selecting an image
    }
  }

   Future<void> cropImage() async {
    if (selectedImage == null) return;
     notifyListeners();

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: selectedImage!.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Colors.blue,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );

    if (croppedImage != null) {
        selectedImage = File(croppedImage.path);
        fileName = croppedImage.path.split('/').last;
    }
     notifyListeners();
  }


  void deleteImage() {
      selectedImage = null;
      fileName = null;
      notifyListeners();
  }

// for Slot and DateTime 
   List<DateTimeSlot> slots = [
          DateTimeSlot(
              day: 'Monday', openTime: '09:00 AM', closeTime: '05:00 PM'),
        ];

  void addSlot() {
    if (slots.length >= 7) return;

    final daysWithSlots = slots.map((slot) => slot.day).toSet();
    final nextAvailableDay = BusinessProfileData.daysOfWeek
        .firstWhere((day) => !daysWithSlots.contains(day), orElse: () => '');

    if (nextAvailableDay.isNotEmpty) {
      // setState(() {
        slots.add(DateTimeSlot(
          day: nextAvailableDay,
          openTime: '09:00 AM',
          closeTime: '05:00 PM',
        ));
      // });
      // widget.onSlotsUpdated?.call(slots);
      notifyListeners();
    }
  }

  void deleteSlot(int index) {
    // setState(() {
      slots.removeAt(index);
    // });
    // widget.onSlotsUpdated?.call(slots);
     notifyListeners();
  }

  void updateSlot(int index, DateTimeSlot updatedSlot) {
    // setState(() {
      slots[index] = updatedSlot;
    // });
    // widget.onSlotsUpdated?.call(slots);
    notifyListeners();
  }


  Future<void> setupProfileBusiness(BuildContext context) async {
    if (slots.isEmpty) {
      _toastService.showToast(context, title: 'Error', subTitle: 'You must add at least one slot.');
      return;
    }

    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      notifyListeners();

      // final payload = {
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

       final payload = {
      'name': businessNameController.text.trim(),
      'description': describeYourBusinessController.text.trim(),
      'businessCategoryUuid': businessCategoryController.text.trim(),
      'country': selectCountryController.text.trim(),
      'stateAndProvince': stateAndProvinceController.text.trim(),
      'city': cityController.text.trim(),
      'street': streetController.text.trim(),
      'postalCode': zipCodePostalCodeController.text.trim(),
      'phoneNumber': businessPhoneNumberController.text.trim(),
      'businessEmail': businessEmailController.text.trim(),
      'operationDays': slots.map((slot) => slot.toJson()).toList(),
      'websiteUrl': websiteController.text.trim(),
      'linkedinUrl': linkedinUrlController.text.trim(),
      'instagramUrl': instagramController.text.trim(),
      'facebookUrl': facebookController.text.trim(),
      'image': null, 
      'cloudinaryConfig': null, 
      'streetCoordinates': {
        'lat': 0.0, 
        'lng': 0.0,
      },
    };

      await _profileBusinessServiceProfileBusinessService.profileBusiness(payload);

      // Clear all fields
      clearAllFields();
      router.go('/main_screen');
    } on BizException catch (e) {
      debugPrint(e.message);
      _toastService.showToast(context, title: 'Error', subTitle: e.message ?? 'Unknown error');
    } catch (e) {
      // debugPrint(e);
      _toastService.showToast(context, title: 'Error', subTitle: 'Something went wrong.');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearAllFields() {
    for (final controller in [
      businessNameController,
      businessEmailController,
      businessPhoneNumberController,
      describeYourBusinessController,
      businessCategoryController,
      selectCountryController,
      stateAndProvinceController,
      cityController,
      streetController,
      zipCodePostalCodeController,
      instagramController,
      websiteController,
      linkedinUrlController,
      tiktokController,
      facebookController,
    ]) {
      controller.clear();
    }
  }
}
