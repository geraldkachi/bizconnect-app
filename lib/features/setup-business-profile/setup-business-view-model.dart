import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/data/country_data.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/business_category.dart';
import 'package:bizconnect/models/city_model.dart';
import 'package:bizconnect/models/state_province_model.dart';
import 'package:bizconnect/service/setup_profile_service.dart';
import 'package:bizconnect/service/toast_service.dart';
import 'package:bizconnect/utils/business_profile_data.dart';
import 'package:bizconnect/widget/datetime_slot.dart';
// import 'package:bizconnect/service/profile_business_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class SetupBusinessProfileState {
  final String? selectedCountry;
  final String? selectedState;
  final String? selectedCity;
  final List<dynamic> states;
  final List<dynamic> cities;

  SetupBusinessProfileState({
    this.selectedCountry,
    this.selectedState,
    this.selectedCity,
    this.states = const [],
    this.cities = const [],
  });

  SetupBusinessProfileState copyWith({
    String? selectedCountry,
    String? selectedState,
    String? selectedCity,
    List<dynamic>? states,
    List<dynamic>? cities,
  }) {
    return SetupBusinessProfileState(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedState: selectedState ?? this.selectedState,
      selectedCity: selectedCity ?? this.selectedCity,
      states: states ?? this.states,
      cities: cities ?? this.cities,
    );
  }
}


final setupBusinessProfileViewModelProvider =
    ChangeNotifierProvider.autoDispose<SetupBusinessProfileViewModel>(
        (ref) => SetupBusinessProfileViewModel());

class SetupBusinessProfileViewModel extends ChangeNotifier {
  final ProfileBusinessService _profileBusinessServiceProfileBusinessService = getIt<ProfileBusinessService>();
  final ToastService _toastService = getIt<ToastService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // List<Map<String, dynamic>> get businessCategories => _profileBusinessServiceProfileBusinessService.businessCategories;
  BusinessCategoriesModel categories = BusinessCategoriesModel();
  List<String> categoryData = [];

      //  RefreshController(initialRefresh: false);
      //  RefreshController refreshController = RefreshController(initialRefresh: false);

    // AdminModel get userData => _authService.userData ?? AdminModel();


  // Text controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessPhoneNumberController = TextEditingController();
  TextEditingController describeYourBusinessController = TextEditingController();
  
  TextEditingController streetController = TextEditingController();
  TextEditingController zipCodePostalCodeController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController linkedinUrlController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  
  String? selectedBusinessCategory;
  String? selectedBusinessCountry;
  String? selectStateAndProvince;
  String? selectCity;

  // List<Map<String, dynamic>> countryData = []; how can i it here its on a different file
  final List<Map<String, String?>> countries = countryData;
  List<String> stateData = [];
  List<String> cityData = [];
  // Slot-related
  TextEditingController dayController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();

  int prevIndex = 0;
  bool obscureText = true;
  bool isLoading = false;


Future<void> fetchStates(String countryCode) async {
    try {
      final String response = await rootBundle.loadString('assets/data/locations/$countryCode/states.json');
      final List<dynamic> data = json.decode(response);
      stateData = data.map((e) => e['name'].toString()).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching states: $error");
    }
  }

  Future<void> fetchCities(String stateCode) async {
    try {
      final String response = await rootBundle.loadString('assets/data/locations/$stateCode/cities.json');
      final List<dynamic> data = json.decode(response);
      cityData = data.map((e) => e['name'].toString()).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching cities: $error");
    }
  }

// // 
//   Future<List<StateProvinceModel>> fetchStates(String countryCode) async {
//     final String response = await rootBundle.loadString('assets/data/locations/$countryCode/states.json');
//     final List<dynamic> data = json.decode(response);
//     return data.map((item) => StateProvinceModel.fromJson(item)).toList();
//   }

//    // Fetch the cities based on selected state code
//   // Future<void> fetchCities(String stateCode) async {
//   //   // Fetch city data (similarly you can get it from a JSON file or API)
//   //   String jsonData = await rootBundle.loadString('assets/locations/${stateCode}_cities.json');
//   //   List<dynamic> citiesData = jsonDecode(jsonData);
//   //   state = state.copyWith(cities: citiesData);
//   // }


// Future<void> fetchCities(String stateCode) async {
//   // Load the city data from a JSON file based on the selected state code
//   String jsonData = await rootBundle.loadString('assets/locations/${stateCode}/cities.json');
//   List<dynamic> citiesData = jsonDecode(jsonData);
//   // Convert the List<dynamic> into a List<City> using the City model
//   List<City> cities = citiesData.map((cityJson) => City.fromJson(List<String>.from(cityJson))).toList();
//   // Now you can use the cities list as needed, for example:
//   print(cities);  // Just printing the cities for now
// }

void togglePassword() {
  obscureText = !obscureText;
  notifyListeners();
}

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
      // router.go('/main_screen');
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
      // 'businessCategoryUuid': businessCategoryController.text.trim(),
      'country': selectedBusinessCountry,
      'stateAndProvince': selectStateAndProvince,
      'city': selectCity,
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
      // businessCategoryController,
      // selectCountryController,
      // stateAndProvinceController,
      // cityController,
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


Future<void> fetchCategories(BuildContext context) async {
  try {
    isLoading = true;
    notifyListeners();
    categories = await _profileBusinessServiceProfileBusinessService.allBusinessCategories();
    categoryData = categories.data!.businessCategories.map((e) => e.description).toList(); 
    log('category ${categories.data!.businessCategories.map((e) => e.description) }');
    isLoading = false;
    notifyListeners();
    // return categories;
  } on BizException catch (e) { 
    isLoading = false;
    notifyListeners();
    _toastService.showToast(context, title: 'Error', subTitle: e.message ?? '');
    // return [];
  } catch (e, stack) {
    isLoading = false;
    notifyListeners();
    _toastService.showToast(context, title: 'Error', subTitle: 'Something went wrong.');
    debugPrint('fetch categories error: $e\n$stack');
    // return [];
  }
}



  //  Future<void> fetchCategories(context) async {
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     await _profileBusinessServiceProfileBusinessService.allBusinessCategories();
  //     // searchFacilities = _healthFacilitiesService.facilitiesModel!;
  //     isLoading = false;
  //     // onInit = true;
      
  //     notifyListeners();
  //   } on BizException catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     _toastService.showToast(context,
  //         title: 'Error', subTitle: e.message ?? '');
  //   } catch (e, stack) {
  //     isLoading = false;
  //     notifyListeners();
  //     _toastService.showToast(context,
  //         title: 'Error', subTitle: 'Something went wrong.');
  //     debugPrint('fetch categories error: $e\ns$stack');
  //   }
  // }
}
