import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/app/router.dart';
import 'package:bizconnect/data/country_data.dart';
import 'package:bizconnect/exceptions/bizcon_exception.dart';
import 'package:bizconnect/models/business_category.dart';
import 'package:bizconnect/models/city_model.dart';
import 'package:bizconnect/models/google_place_result.dart';
import 'package:bizconnect/models/state_province_model.dart';
import 'package:bizconnect/service/setup_profile_service.dart';
import 'package:bizconnect/service/toast_service.dart';
import 'package:bizconnect/utils/business_profile_data.dart';
import 'package:bizconnect/widget/datetime_slot.dart';
import 'package:dio/dio.dart';
// import 'package:bizconnect/service/profile_business_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final setupBusinessProfileViewModelProvider =
    ChangeNotifierProvider.autoDispose<SetupBusinessProfileViewModel>(
        (ref) => SetupBusinessProfileViewModel());

class SetupBusinessProfileViewModel extends ChangeNotifier {
  final ProfileBusinessService _profileBusinessServiceProfileBusinessService =
      getIt<ProfileBusinessService>();
  final ToastService _toastService = getIt<ToastService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BusinessCategoriesModel categories = BusinessCategoriesModel();
  StressSuggestionsResponse streetSuggestions = StressSuggestionsResponse();
  List<Map<String, dynamic>> categoryData = [];

  // Text controllers
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessPhoneNumberController = TextEditingController();
  TextEditingController describeYourBusinessController =
      TextEditingController();

  TextEditingController streetController = TextEditingController();
  TextEditingController zipCodePostalCodeController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController linkedinUrlController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController facebookController = TextEditingController();

  String? selectedBusinessCategory;
  String? selectBusinessUuid;
  File? selectedOriginalImage;
  File? selectedCroppedImage;
  String? originalImageUrl;
  String? croppedImageUrl;

  List<Country> countries = CountryUtils.getAllCountries();
  List<Location> stateData = [];
  List<String> cityData = [];
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  Timer? _debounce;
  List<String> streetSuggestionsList = [];
// List<Map<String, dynamic>> streetSuggestionsList = [];


  // Slot-related
  TextEditingController dayController = TextEditingController();
  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();

  int prevIndex = 0;
  bool obscureText = true;
  bool isLoading = false;

  // image
  File? selectedImage;
  String? fileName;

  Future<void> fetchStreetSuggestions(BuildContext context, String query,
      String country, String state, String city) async {
    // if (query.isEmpty) return;
    if (query.isEmpty || country.isEmpty || state.isEmpty || city.isEmpty) {
      print('Error: One or more parameters are null or empty');
      return;
    }
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        // Fetch street suggestions as before
         streetSuggestions = await _profileBusinessServiceProfileBusinessService
            .fetchStreetSuggestions(query, country, state, city);
            streetSuggestionsList = streetSuggestions.data!.suggestions
          .map((suggestion) => suggestion.name)
            // .map((e) => {'name' : e.name})
          .toList() ?? [];
        isLoading = false;
        notifyListeners();
      } catch (e) {
        _toastService.showToast(
          context,
          title: "Error",
          subTitle: 'Error fetching street suggestions $e',
        );
        isLoading = false;
        notifyListeners();
        rethrow;
      }
    });
  }

  void updateStreetSuggestions(List<String> suggestions) {
  // void updateStreetSuggestions(List<Map<String, dynamic>> suggestions) {
    streetSuggestionsList = suggestions;
    notifyListeners();
  }

  // Method to select a street
  void selectStreet(String street) {
    streetController.text = street;
    notifyListeners();
  }

  // Validation for required fields
  bool validateRequiredFields(
      BuildContext context, Map<String, dynamic> values) {
    bool isError = false;

    // Example required fields
    List<String> requiredFields = [
      "businessName",
      "description",
      "businessCategoryUuid",
      "country",
      "stateAndProvince",
      "city",
      "street",
      "postalCode",
    ];
    for (var field in requiredFields) {
      if (values[field] == null || values[field].isEmpty) {
        _toastService.showToast(
          context,
          title: "Error",
          subTitle: 'Please fill all required fields. Missing: $field',
        );
        isError = true;
      }
    }

    // Check operational days (example logic)
    if (values['operationDays'] != null) {
      for (var day in values['operationDays']) {
        if (day['openTime'] == null || day['closeTime'] == null) {
          _toastService.showToast(context,
              title: 'Error',
              subTitle: 'Opening and closing time are required.');
          isError = true;
        }
        if (day['openTime'] == day['closeTime']) {
          _toastService.showToast(
            context,
            title: 'Error',
            subTitle: 'Opening and closing time cannot be the same.',
          );
          isError = true;
        }
      }
    }

    return isError;
  }

  // Handle navigation to the next tab
  void handleNextButton(BuildContext context, Map<String, dynamic> values) {
    if (!validateRequiredFields(context, values)) {
      prevIndex = 1;
      notifyListeners();
    }
  }

  Future<void> fetchStates(String countryCode) async {
    try {
      final String response = await rootBundle
          .loadString('assets/data/locations/$countryCode/states.json');
      final List<dynamic> data = json.decode(response);

      stateData = data.map((e) => Location.fromJson(e)).toList();
      selectedState = null; // Reset state
      selectedCity = null; // Reset city
      cityData = [];
      streetController.text = '';
      notifyListeners();
    } catch (error) {
      print("Error fetching states: $error");
      stateData = [];
      notifyListeners();
    }
  }

  Future<void> fetchCities(String countryCode, String stateCode) async {
    try {
      final String response = await rootBundle
          .loadString('assets/data/locations/$countryCode/cities.json');
      final Map<String, dynamic> data = json.decode(response); // Decode as Map
      // Get the cities for the provided state code
      final List<dynamic> cities =
          data[stateCode] ?? []; // Handle case where stateCode doesn't exist
      cityData = cities
          .map((city) => city[0]
              .toString()) // Assuming the city name is the first element in the list
          .toList();
      selectedCity = null; // Reset city
      streetController.text = '';
      notifyListeners();
    } catch (error) {
      print("Error fetching cities: $error");
      cityData = [];
      notifyListeners();
    }
  }

  void togglePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

// image
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      fileName = image.name;
      notifyListeners();
      await cropImage();
    }
  }

  Future<void> cropImage() async {
    if (selectedImage == null) return;

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
      // where would i get croppedImageMetadata
      // croppedImageMetadata = {
      //   'width': croppedImage.width,
      //   'height': croppedImage.height,
      // };
      notifyListeners();
    }
  }

  void deleteImage() {
    selectedImage = null;
    fileName = null;
    notifyListeners();
  }

// for Slot and DateTime
  List<DateTimeSlot> slots = [
    DateTimeSlot(day: 'Monday', openTime: '09:00 AM', closeTime: '05:00 PM'),
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

  Future<String?> encodeImage(File image) async {
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> setupProfileBusiness(BuildContext context) async {
    // router.go('/main_screen');
    if (slots.isEmpty) {
      _toastService.showToast(context,
          title: 'Error', subTitle: 'You must add at least one slot.');
      return;
    }

    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      notifyListeners();

      final payload = {
        'name': businessNameController.text.trim(),
        'description': describeYourBusinessController.text.trim(),
        'businessCategoryUuid': selectBusinessUuid,
        'country': selectedCountry,
        'stateAndProvince': selectedState,
        'city': selectedCity,
        // 'city': "saint gerald",
        'street': streetController.text.trim(),
        'postalCode': zipCodePostalCodeController.text.trim(),
        'phoneNumber': businessPhoneNumberController.text.trim(),
        'businessEmail': businessEmailController.text.trim(),
        'operationDays': slots.map((slot) => slot.toJson()).toList(),
        'websiteUrl': websiteController.text.trim(),
        'linkedinUrl': linkedinUrlController.text.trim(),
        'instagramUrl': instagramController.text.trim(),
        'facebookUrl': facebookController.text.trim(),
        'image':
            selectedImage != null ? await encodeImage(selectedImage!) : null,
        // 'image': selectedImage != null ? MultipartFile.fromFileSync(selectedImage!.path, filename: fileName) : null,
        // 'image': selectedImage, // Placeholder for an uploaded business image
        'cloudinaryConfig': null, // Placeholder for cloud storage configuration
        'streetCoordinates': {
          'lat': 0.0,
          'lng': 0.0,
        },
      };
      log('payload setup $payload');

      await _profileBusinessServiceProfileBusinessService
          .profileBusiness(payload);

      // Clear all fields
      clearAllFields();
      // router.go('/main_screen');
    } on BizException catch (e) {
      debugPrint(e.message);
      _toastService.showToast(context,
          title: 'Error', subTitle: e.message ?? 'Unknown error');
    } catch (e) {
      // debugPrint(e);
      _toastService.showToast(context,
          title: 'Error', subTitle: 'Something went wrong.');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfileBusiness(BuildContext context) async {
    // router.go('/main_screen');
    if (slots.isEmpty) {
      _toastService.showToast(context,
          title: 'Error', subTitle: 'You must add at least one slot.');
      return;
    }

    if (!formKey.currentState!.validate()) return;

    log('selectedImage $selectedImage');
    log('fileName $fileName');
    try {
      isLoading = true;
      notifyListeners();

      final payload = {
        'name': businessNameController.text.trim(),
        'description': describeYourBusinessController.text.trim(),
        'businessCategoryUuid': selectBusinessUuid,
        'country': selectedCountry,
        'stateAndProvince': selectedState,
        'city': selectedCity,
        'street': streetController.text.trim(),
        'postalCode': zipCodePostalCodeController.text.trim(),
        'phoneNumber': businessPhoneNumberController.text.trim(),
        'businessEmail': businessEmailController.text.trim(),
        'operationDays': slots.map((slot) => slot.toJson()).toList(),
        'websiteUrl': websiteController.text.trim(),
        'linkedinUrl': linkedinUrlController.text.trim(),
        'instagramUrl': instagramController.text.trim(),
        'facebookUrl': facebookController.text.trim(),
        'image': selectedImage, // Placeholder for an uploaded business image
        'cloudinaryConfig': null, // Placeholder for cloud storage configuration
        'streetCoordinates': {
          'lat': 0.0,
          'lng': 0.0,
        },
      };

      await _profileBusinessServiceProfileBusinessService.updateBusiness(
          payload, '');

      // Clear all fields
      clearAllFields();
      router.go('/main_screen');
    } on BizException catch (e) {
      debugPrint(e.message);
      _toastService.showToast(context,
          title: 'Error', subTitle: e.message ?? 'Unknown error');
    } catch (e) {
      // debugPrint(e);
      _toastService.showToast(context,
          title: 'Error', subTitle: 'Something went wrong.');
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
      // selectBusinessUuid,
      // selectedBusinessCategory,
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
      categories = await _profileBusinessServiceProfileBusinessService
          .allBusinessCategories();
      // categoryData = categories.data!.businessCategories.map((e) => e.description).toList();
      categoryData = categories.data!.businessCategories
          .map((e) => {'uuid': e.uuid, 'description': e.description})
          .toList();
      log('category ${categories.data!.businessCategories.map((e) => e.description)}');
      isLoading = false;
      notifyListeners();
      // return categories;
    } on BizException catch (e) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error', subTitle: e.message ?? '');
      // return [];
    } catch (e, stack) {
      isLoading = false;
      notifyListeners();
      _toastService.showToast(context,
          title: 'Error', subTitle: 'Something went wrong.');
      debugPrint('fetch categories error: $e\n$stack');
      // return [];
    }
  }
}
