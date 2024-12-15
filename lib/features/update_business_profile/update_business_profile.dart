import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/data/country_data.dart';
import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';
import 'package:bizconnect/utils/validator.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:bizconnect/widget/datetime_slot.dart';
import 'package:bizconnect/widget/dotted_line.dart';
import 'package:bizconnect/widget/image_file_upload.dart';
import 'package:bizconnect/widget/input.dart';
import 'package:bizconnect/widget/select_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


class UpdateBusinessProfile extends ConsumerStatefulWidget {
  const UpdateBusinessProfile({super.key});

  @override
  ConsumerState<UpdateBusinessProfile> createState() => _UpdateBusinessProfileState();
}


class _UpdateBusinessProfileState extends ConsumerState<UpdateBusinessProfile>  with SingleTickerProviderStateMixin {
  final currentYear = DateTime.now().year;
  final GlobalKey<DropdownSearchState<String>> dropDownKey =
      GlobalKey<DropdownSearchState<String>>();
  @override
  void initState() {
    super.initState();
    final businessProfileProvider = ref.read(setupBusinessProfileViewModelProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This will run after the build method is completed     
        businessProfileProvider.fetchCategories(context);
    // _loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final setupProfileWatch = ref.watch(setupBusinessProfileViewModelProvider);
    // final setupProfileRead = ref.read(setupBusinessProfileViewModelProvider.notifier);
    final businessProfile = ref.watch(setupBusinessProfileViewModelProvider);

  
  final setupProfileWatch = ref.watch(setupBusinessProfileViewModelProvider);
    final setupProfileRead =
        ref.read(setupBusinessProfileViewModelProvider.notifier);

    return Scaffold(
            appBar: AppBar(title: Text('Update Business Profile')),

      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Form(
          key: setupProfileWatch.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 26),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Spacer(),
                    Text(
                      "Setup Your Business Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: red,
                        letterSpacing: -.5,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              const SizedBox(height: 16),

              // Tab bar and Tab content in a single container
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Tabs Section
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 0.0, vertical: 10.0),
                      //   child:
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(2, (index) {
                            return Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      setupProfileRead.prevIndex = index;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent, // Ensures the whole area is tappable
                                    padding: const EdgeInsets.symmetric(vertical: 4.0), // Increase tappable area
                                    child: Column(
                                      children: [
                                        Text(
                                          index == 0 ? "Business Profile" : "Operations Info",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: setupProfileRead.prevIndex == index
                                                ? const Color(0xFF17BEBB)
                                                : const Color(0xFFDBD8D8),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          height: 4,
                                          color: setupProfileRead.prevIndex == index
                                              ? const Color(0xFF17BEBB)
                                              : const Color(0xFFDBD8D8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                            );
                          }).expand((widget) sync* {
                            yield widget;
                            yield const SizedBox(width: 10);
                          }).toList()
                            ..removeLast(),
                        ),
                      // ),
                      const SizedBox(height: 10),

                      // Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setupProfileRead.prevIndex == 0
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            "Tell Us About Your Business",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: grey500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .businessNameController,
                                          labelText: "Business name",
                                          hintText: "Enter Business Name",
                                          validator: (value) =>
                                              Validator.validateName(value),
                                        ),
                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .describeYourBusinessController,
                                          labelText: "Describe your business",
                                          hintText:
                                              "Short sentence about your business",
                                          validator: (value) =>
                                              Validator.validateName(value),
                                          maxLines: 5,
                                          minLines: 3,
                                        ),
                                        const SizedBox(height: 10),
                                        ImageUploadField(
                                            labelText: "Upload Image",
                                            hintText: "Upload logo or business flyer",
                                            setupProfileWatch:setupProfileWatch),
                                        const SizedBox(height: 10),
                                       
                                        DropdownField<String>(
                                          // dropdownKey: dropDownKey,
                                          // selectedItem: ref.read(setupBusinessProfileViewModelProvider.notifier).selectedBusinessCategory,
                                          selectedItem: setupProfileWatch.selectedBusinessCategory,
                                          labelText: "Business Category",
                                          hintText: "Search Business Category",
                                          // items: setupProfileRead.categoryData.map((e) => e['description'] as String).toList(),
                                          items: [],
                                          asyncItems: (String filter) async {
                                              final filteredCategories = setupProfileRead.categoryData
                                                  .where((category) => category['description'].toLowerCase().contains(filter.toLowerCase()))
                                                  .map((category) => category['description'] as String)
                                                  .toList();
                                              return filteredCategories;  // Return the filtered list
                                            },
                                          popupProps: PopupProps.menu(
                                              // disabledItemFn: (item) => item == 'Item 3',
                                              fit: FlexFit.tight,  isFilterOnline: true),
                                          onChanged: (value) {
                                            // Update the state when an item is selected
                                            setState(() {
                                              setupProfileWatch.selectedBusinessCategory = value;
                                               // Find the selected category's UUID
                                              //  final selectedCategory = setupProfileRead.categoryData.firstWhere((element) => element['description'] == value, orElse: () => null,);
                                                final selectedCategory = setupProfileRead.categoryData.firstWhere((element) => element['description'] == value, orElse: () => null!);
                                                setupProfileWatch.selectBusinessUuid = selectedCategory?['uuid'] as String?;
                                            });
                                            dropDownKey.currentState?.changeSelectedItem(value);
                                            print("Selected: $value, UUID: ${setupProfileWatch.selectBusinessUuid}");
                                          },

                                          validator: (value) => (value == null || value.isEmpty) ? "This business category field is required" : null,
                                          dropdownIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: red,
                                            size: 37.0,
                                          ),
                                          showSearchBox: true,
                                          prefixIcon: Icon(Icons.search,weight: 24.0, size: 34.0,)
                                          //  dropdownBuilder: (context, selectedItem) {
                                          //     return Text(selectedItem ?? ''); // Customize as needed
                                          //   },
                                          // prefixIcon: SvgPicture.asset(
                                          //   'assets/svg/search.svg',
                                          //   width: 14.0,
                                          //   height: 14.0,
                                          // ),
                                        ),
                                        // Country
                                        const SizedBox(height: 10),
                                        DropdownField<String>(
                                          // dropdownKey: dropDownKey,
                                          labelText: "Select Country",
                                          hintText: "Select Country",
                                          items: setupProfileWatch.countries.map((country) => country.name).toList(),
                                          // items: setupProfileWatch.countries.map((e) => e['name'] as String).toList(),
                                        // asyncItems: (String filter) async {
                                        //   // Dynamically fetch and filter countries
                                        //   return setupProfileWatch.countries
                                        //       .where((country) => country['name']
                                        //           .toString()
                                        //           .toLowerCase()
                                        //           .contains(filter.toLowerCase()))
                                        //       .map((e) => e['name'] as String)
                                        //       .toList();
                                        // },
                                          popupProps: PopupProps.menu(
                                              // disabledItemFn: (item) => item == 'Item 3',
                                              fit: FlexFit.tight,
                                              isFilterOnline: true
                                              ),
                                          selectedItem: setupProfileWatch.selectedCountry,
                                          onChanged: (value) async {
                                          // Find the country ISO code
                                           setupProfileWatch.fetchStates(value!);
                                          final countryISO = CountryUtils.getCountryIsoCode(value!);
                                          
                                          // Update selected country
                                          setupProfileRead.selectedCountry = value;
                                          setupProfileRead.selectCity = null;
                                          setupProfileRead.selectCity = null;

                                          // Fetch states for the selected country
                                          if (countryISO.isNotEmpty) {
                                            await setupProfileRead.fetchStates(countryISO);
                                          }
                                          print('Selected Country ISO: $countryISO');
                                        },
                                          validator: (value) => (value == null || value.isEmpty) ? "This country field is required" : null,
                                          dropdownIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: grey400),
                                          showSearchBox: true,
                                        ),
                                        // State and Province
                                        const SizedBox(height: 10),
                                         DropdownField<String>(
  labelText: "State and Province",
  hintText: "State and Province",
  items: setupProfileWatch.stateData.map((state) => state.name).toList(),
  selectedItem: setupProfileWatch.selectCity,
  onChanged: (value) async {
    // Find the state by its name
    final selectedState = setupProfileWatch.stateData.firstWhere(
      (state) => state.name == value,
      orElse: () => null!, // Handle cases where the state is not found
    );
    

    if (selectedState != null) {
      setupProfileRead.selectCity = value;
      setupProfileRead.selectCity = null; // Reset city selection

      // Fetch cities for the selected state using its ISO code
      if (selectedState.isoCode.isNotEmpty) {
        // await setupProfileRead.fetchCities(selectedState.isoCode);
        await  setupProfileWatch.fetchCities(setupProfileWatch.selectedCountry!, selectedState.isoCode!);
      }

      print("Selected State: $value, Code: ${selectedState.isoCode}");
    }
  },
  validator: (value) => (value == null || value.isEmpty) ? "This state field is required" : null,
  dropdownIcon: const Icon(Icons.arrow_drop_down, color: grey400),
  showSearchBox: true,
),

                                        // City
                                        const SizedBox(height: 10),
                                        DropdownField<String>(
                                          // dropdownKey: dropDownKey,
                                          labelText: "City",
                                          hintText: "Select city",
                                          items: setupProfileWatch.cityData,
                                          popupProps: PopupProps.menu(fit: FlexFit.tight, isFilterOnline: true),
                                          // popupProps: PopupProps.modalBottomSheet(fit: FlexFit.tight,  isFilterOnline: true,),
                                          selectedItem: setupProfileWatch.selectCity,
                                         onChanged: (value) async {
                                              setupProfileWatch.selectCity = value;
                                            dropDownKey.currentState?.changeSelectedItem(value);
                                            print("Selected: $value");
                                          },
                                          validator: (value) => (value == null || value.isEmpty) ? "This city field is required" : null,
                                          dropdownIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: grey400),
                                          showSearchBox: true,
                                        ),
                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .streetController,
                                          labelText: "Street",
                                          hintText: "Enter Street name",
                                          validator: (value) =>
                                              Validator.validateName(value),
                                        ),

                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .zipCodePostalCodeController,
                                          labelText: "Zip Code/Postal Code",
                                          hintText: "Enter postal code",
                                          validator: (value) =>
                                              Validator.validateName(value),
                                        ),
                                        const SizedBox(height: 10),

                                        const SizedBox(height: 20),
                                        Button(
                                          text: "Next",
                                          isLoading: false,
                                          onPressed: () async {
                                            // loginRead.login(context);
                                            setState(() {
                                              setupProfileRead.prevIndex = 1;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Center(
                                          child: Text(
                                            "Operations Info",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: grey500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .businessPhoneNumberController,
                                          labelText: "Enter phone number",
                                          hintText: "Enter Phone Number",
                                          validator: (value) =>
                                              Validator.validatePhoneNumber(
                                                  value),
                                        ),
                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .businessEmailController,
                                          labelText: "Business email",
                                          hintText: "Enter Business email",
                                          validator: (value) =>
                                              Validator.validateEmail(value),
                                          suffixIcon: IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/svg/mail.svg',
                                              width: 8.0,
                                              height: 20.03,
                                            ),
                                            onPressed: () {
                                              // signupRead.togglePassword();
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        HorizontalDottedLine(),
                                        const SizedBox(height: 20),
                                        DateTimeSlots(
                                          initialSlots: [
                                            DateTimeSlot(
                                                day: 'Monday',
                                                openTime: '09:00 AM',
                                                closeTime: '05:00 PM'),
                                          ],
                                          onSlotsUpdated: (updatedSlots) {
                                            print(
                                                'Updated Slots: $updatedSlots');
                                          },
                                        ),

                                        const SizedBox(height: 20),
                                        HorizontalDottedLine(),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Upload social media links",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: red,
                                                letterSpacing: -.5,
                                              ),
                                            ),
                                            Text(
                                              "(optional)",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                color: grey500,
                                                letterSpacing: -.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // const SizedBox(height: 20),
                                        InputField(
                                          prefixIcon: SvgPicture.asset(
                                            'assets/svg/instagram.svg',
                                            width: 8.0,
                                            height: 20.03,
                                          ),
                                          controller: setupProfileWatch.instagramController,
                                          labelText: "",
                                          hintText: "copy & paste instagram link here",
                                          inputPaddingH: 28.0,
                                          inputPaddingV: 15.0,
                                        ),
                                        // website
                                        InputField(
                                          prefixIcon: SvgPicture.asset(
                                            'assets/svg/website.svg',
                                            width: 8.0,
                                            height: 20.03,
                                          ),
                                          controller: setupProfileWatch
                                              .websiteController,
                                          labelText: "",
                                          hintText: "copy & paste website link here. e.g personal site, storefront, etc",
                                          inputPaddingH: 28.0,
                                          inputPaddingV: 15.0,
                                        ),
                                        // tiktok
                                        InputField(
                                          prefixIcon: SvgPicture.asset(
                                            'assets/svg/tiktok.svg',
                                            width: 8.0,
                                            height: 20.03,
                                          ),
                                          controller: setupProfileWatch
                                              .tiktokController,
                                          labelText: "",
                                          hintText:"copy & paste tiktok link here",
                                          inputPaddingH: 28.0,
                                          inputPaddingV: 15.0,
                                        ),
                                        // facebook
                                        InputField(
                                          prefixIcon: SvgPicture.asset(
                                            'assets/svg/facebook.svg',
                                            width: 8.0,
                                            height: 20.03,
                                          ),
                                          controller: setupProfileWatch
                                              .facebookController,
                                          labelText: "",
                                          hintText: "copy & paste facebook link here",
                                          inputPaddingH: 28.0,
                                          inputPaddingV: 15.0,
                                        ),

                                        const SizedBox(height: 20),
                                        Button(
                                          text: "Submit Profile",
                                          isLoading:
                                              setupProfileWatch.isLoading,
                                          onPressed: () async {
                                            // context.go('/main_screen');
                                            // setupProfileRead
                                            //     .setupProfileBusiness(context);
                                          },
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Center(
                  child: Text(
                    '$currentYear Bizconnect24. All rights reserved',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: grey500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
