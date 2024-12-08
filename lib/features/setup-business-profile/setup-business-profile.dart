// ignore_for_file: prefer_const_constructors
import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';
import 'package:bizconnect/utils/validator.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:bizconnect/widget/datetime_slot.dart';
import 'package:bizconnect/widget/input.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bizconnect/widget/select_dropdown.dart';
import 'package:bizconnect/widget/image_file_upload.dart';
import 'package:bizconnect/widget/dotted_line.dart';

class SetupBusinessProfilePage extends ConsumerStatefulWidget {
  const SetupBusinessProfilePage({super.key});

  @override
  ConsumerState<SetupBusinessProfilePage> createState() =>
      _SetupBusinessProfilePageState();
}

const List<String> countryItems = ["Item 1", "Item 2", "Item 3", "Item 4"];

class _SetupBusinessProfilePageState
    extends ConsumerState<SetupBusinessProfilePage>
    with SingleTickerProviderStateMixin {
  final currentYear = DateTime.now().year;
  // final dropDownKey = GlobalKey<DropdownSearchState<String>>();
  final GlobalKey<DropdownSearchState<String>> dropDownKey =
      GlobalKey<DropdownSearchState<String>>();

        List<String> categoryItems = [];
        bool isLoading = true;


       Future<void> _loadCategories() async {
    final setupProfileRead =
        ref.read(setupBusinessProfileViewModelProvider.notifier);
    final fetchedCategories =
        await setupProfileRead.fetchCategories(context);
    setState(() {
      categoryItems = fetchedCategories.map((e) => e.description).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final setupProfileWatch = ref.watch(setupBusinessProfileViewModelProvider);
    final setupProfileRead =
        ref.read(setupBusinessProfileViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Form(
          key: setupProfileWatch.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 26),
              // Header with back button and title
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/svg/back.svg',
                      height: 24,
                      color: const Color(0xff1B1C1E),
                    ),
                    const Spacer(),
                    Text(
                      "Setup Your Business Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: red,
                        letterSpacing: -.5,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                onTap: () {
                   if (context.canPop()) {
                      context.pop(); // Navigate back to the previous screen
                    }
                },
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(2, (index) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    setupProfileRead.prevIndex = index;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      index == 0 ? "" : "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            setupProfileRead.prevIndex == index
                                                ? Color(0xFF17BEBB)
                                                : Color(0xFFDBD8D8),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      height: 4,
                                      color: setupProfileRead.prevIndex == index
                                          ? Color(0xFF17BEBB)
                                          : Color(0xFFDBD8D8),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).expand((widget) sync* {
                            yield widget;
                            yield const SizedBox(width: 10);
                          }).toList()
                            ..removeLast(),
                        ),
                      ),
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
                                            hintText:
                                                "Upload logo or business flyer",
                                            setupProfileWatch:
                                                setupProfileWatch),
                                        const SizedBox(height: 10),
                                        // InputField(
                                        //   controller: setupProfileWatch
                                        //       .businessCategoryController,
                                        //   labelText: "Business Category",
                                        //   hintText: "Search Business Category",
                                        //   validator: (value) =>
                                        //       Validator.validateName(value),
                                        // ),
                                        // Business Category
                                        DropdownField<String>(
                                          dropdownKey: dropDownKey,
                                          selectedItem: ref.read(setupBusinessProfileViewModelProvider.notifier).selectedBusinessCategory,
                                          // selectedItem: setupProfileWatch.selectedBusinessCategory,
                                          labelText: "Business Category",
                                          hintText: "Search Business Category",
                                          items: setupProfileWatch.fetchCategories
                                              .map((category) => category.description)
                                              .toList(),
                                          // const [
                                          //   "Item 1",
                                          //   'Item 2',
                                          //   'Item 3',
                                          //   'Item 4'
                                          // ],
                                          popupProps: PopupProps.menu(

                                              // disabledItemFn: (item) => item == 'Item 3',
                                              fit: FlexFit.tight,  isFilterOnline: true),
                                          // selectedItem: "Category 1",
                                          onChanged: (value) {
                                            // Update the state when an item is selected
                                            setState(() {
                                              setupProfileWatch
                                                      .selectedBusinessCategory =
                                                  value;
                                            });
                                            dropDownKey.currentState
                                                ?.changeSelectedItem(value);
                                            print("Selected: $value");
                                          },

                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            }
                                            return null;
                                          },
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
                                          dropdownKey: dropDownKey,
                                          labelText: "Select Country",
                                          hintText: "Select Country",
                                          items: countryItems.toSet().toList(),
                                          popupProps: PopupProps.menu(
                                              // disabledItemFn: (item) => item == 'Item 3',
                                              fit: FlexFit.tight,
                                              isFilterOnline: true
                                              ),
                                          selectedItem: setupProfileWatch
                                              .selectStateAndProvinceController,
                                          onChanged: (value) {
                                            setState(() {
                                              setupProfileWatch.selectStateAndProvinceController =value;});
                                            dropDownKey.currentState?.changeSelectedItem(value);
                                            print("Selected: $value");
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            }
                                            return null;
                                          },
                                          dropdownIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: grey400),
                                          showSearchBox: true,
                                        ),
                                        // State and Province
                                        const SizedBox(height: 10),
                                        DropdownField<String>(
                                          dropdownKey: dropDownKey,
                                          labelText: "State and Province",
                                          hintText: "State and Province",
                                          items: const [
                                            "Item 1",
                                            'Item 2',
                                            'Item 3',
                                            'Item 4'
                                          ],
                                          popupProps: PopupProps.menu(
                                              // disabledItemFn: (item) => item == 'Item 3',
                                              fit: FlexFit.tight, isFilterOnline: true),
                                          // selectedItem: "Category 1",
                                          onChanged: (value) {
                                            print("Selected: $value");
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            }
                                            return null;
                                          },
                                          dropdownIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: grey400),
                                          // showSearchBox: true,
                                        ),
                                        // City
                                        const SizedBox(height: 10),
                                        DropdownField<String>(
                                          dropdownKey: dropDownKey,
                                          labelText: "City",
                                          hintText: "Select city",
                                          items: const [
                                            "Item 1",
                                            'Item 2',
                                            'Item 3',
                                            'Item 4'
                                          ],
                                          popupProps: PopupProps.modalBottomSheet(
                                              // disabledItemFn: (item) => item == 'Item 3',
                                              fit: FlexFit.tight,  isFilterOnline: true,),
                                          // selectedItem: "Category 1",
                                          onChanged: (value) {
                                            print("Selected: $value");
                                          },
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            }
                                            return null;
                                          },

                                          dropdownIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: grey400),
                                          // showSearchBox: true,
                                        ),
                                        const SizedBox(height: 10),
                                        InputField(
                                          controller: setupProfileWatch
                                              .stateAndProvinceController,
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

                                        //  DateTimeSlot(
                                        //   dayLabel: "Day",
                                        //   openTimeLabel: "Opening Time",
                                        //   closeTimeLabel: "Closing Time",
                                        //   dayController: setupProfileWatch.dayController,
                                        //   openTimeController: setupProfileWatch.openTimeController,
                                        //   closeTimeController: setupProfileWatch.closeTimeController,
                                        //   onAddSlot: setupProfileWatch.handleAddSlot,
                                        //   onDeleteSlot: setupProfileWatch.handleDeleteSlot,
                                        // ),

                                        //    DateTimeSlot(
                                        //   dayLabel: "Day",
                                        //   openTimeLabel: "Opening Time",
                                        //   closeTimeLabel: "Closing Time",
                                        //   dayController: setupProfileWatch.dayController,
                                        //   openTimeController: setupProfileWatch.openTimeController,
                                        //   closeTimeController: setupProfileWatch.closeTimeController,
                                        //   onAddSlot: () => setupProfileWatch.handleAddSlot(context, setupProfileRead),
                                        //   onDeleteSlot: () {}, // Empty here for individual slots
                                        //   isDeleteButtonVisible: false,
                                        // ),

                                        // Display Slots
                                        // if (setupProfileWatch.slots.isNotEmpty)
                                        //   ListView.builder(
                                        //     shrinkWrap: true,
                                        //     physics: const NeverScrollableScrollPhysics(),
                                        //     itemCount: setupProfileWatch.slots.length,
                                        //     itemBuilder: (context, index) {
                                        //       final slot = setupProfileWatch.slots[index];
                                        //       return ListTile(
                                        //         title: Text("${slot.day}: ${slot.openTime} - ${slot.closeTime}"),
                                        //         trailing: IconButton(
                                        //           icon: const Icon(Icons.delete, color: Colors.red),
                                        //           onPressed: () => setupProfileRead.deleteSlot(slot),
                                        //         ),
                                        //       );
                                        //     },
                                        //   ),

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
                                          controller: setupProfileWatch
                                              .instagramController,
                                          labelText: "",
                                          hintText:
                                              "copy & paste instagram link here",
                                          validator: (value) =>
                                              Validator.validateName(value),
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
                                          hintText:
                                              "copy & paste website link here. e.g personal site, storefront, etc",
                                          validator: (value) =>
                                              Validator.validateName(value),
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
                                          hintText:
                                              "copy & paste tiktok link here",
                                          validator: (value) =>
                                              Validator.validateName(value),
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
                                          hintText:
                                              "copy & paste facebook link here",
                                          validator: (value) =>
                                              Validator.validateName(value),
                                          inputPaddingH: 28.0,
                                          inputPaddingV: 15.0,
                                        ),

                                        const SizedBox(height: 20),
                                        Button(
                                          text: "Submit Profile",
                                          isLoading:
                                              setupProfileWatch.isLoading,
                                          onPressed: () async {
                                            setupProfileRead
                                                .setupProfileBusiness(context);
                                            // setState(() {
                                            //   // prevIndex = 2;
                                            // });
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
