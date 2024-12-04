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
import 'package:image_picker/image_picker.dart'; // To pick an image
import 'dart:io';
import 'package:bizconnect/widget/image_file_upload.dart';
import 'package:bizconnect/widget/dotted_line.dart';

class SetupBusinessProfilePage extends ConsumerStatefulWidget {
  const SetupBusinessProfilePage({super.key});

  @override
  ConsumerState<SetupBusinessProfilePage> createState() =>
      _SetupBusinessProfilePageState();
}

class _SetupBusinessProfilePageState
    extends ConsumerState<SetupBusinessProfilePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  int prevIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
 
  final currentYear = DateTime.now().year;
  final dropDownKey = GlobalKey<DropdownSearchState<String>>();

  @override
  Widget build(BuildContext context) {
    final setupProfileWatch = ref.watch(setupBusinessProfileViewModelProvider);
    final setupProfileRead = ref.read(setupBusinessProfileViewModelProvider.notifier);

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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
              onTap: () => context.canPop(),
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
                                  prevIndex = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    index == 0 ? "Tab 1" : "Tab 2",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: prevIndex == index
                                          ? Color(0xFF17BEBB)
                                          : Color(0xFFDBD8D8),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 4,
                                    color: prevIndex == index
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
                            prevIndex == 0
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
                                      ),
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
                                        labelText: "Business Category",
                                        hintText: "Search Business Category",
                                        items: const [
                                          "Item 1",
                                          'Item 2',
                                          'Item 3',
                                          'Item 4'
                                        ],
                                        popupProps: PopupProps.modalBottomSheet(
                                            // disabledItemFn: (item) => item == 'Item 3',
                                            fit: FlexFit.tight),
                                        // selectedItem: "Category 1",
                                        onChanged: (value) {
                                          print("Selected: $value");
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This field is required";
                                          }
                                          return null;
                                        },
                                        dropdownIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: grey400),
                                        // showSearchBox: true,
                                      ),
                                      // Country
                                      const SizedBox(height: 10),
                                      DropdownField<String>(
                                        dropdownKey: dropDownKey,
                                        labelText: "Select Country",
                                        hintText: "Select Country",
                                        items: const [
                                          "Item 1",
                                          'Item 2',
                                          'Item 3',
                                          'Item 4'
                                        ],
                                        popupProps: PopupProps.modalBottomSheet(
                                            // disabledItemFn: (item) => item == 'Item 3',
                                            fit: FlexFit.tight),
                                        // selectedItem: "Category 1",
                                        onChanged: (value) {
                                          print("Selected: $value");
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This field is required";
                                          }
                                          return null;
                                        },
                                        dropdownIcon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: grey400),
                                        // showSearchBox: true,
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
                                        popupProps: PopupProps.modalBottomSheet(
                                            // disabledItemFn: (item) => item == 'Item 3',
                                            fit: FlexFit.tight),
                                        // selectedItem: "Category 1",
                                        onChanged: (value) {
                                          print("Selected: $value");
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
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
                                            fit: FlexFit.tight),
                                        // selectedItem: "Category 1",
                                        onChanged: (value) {
                                          print("Selected: $value");
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
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
                                        text: "Submit",
                                        isLoading: false,
                                        onPressed: () async {
                                          // loginRead.login(context);
                                          setState(() {
                                            prevIndex = 1;
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
                                            .businessNameController,
                                        labelText: "Business name",
                                        hintText: "Enter Business Name",
                                        validator: (value) =>
                                            Validator.validateName(value),
                                      ),
                                      const SizedBox(height: 10),
                                      InputField(
                                        controller: setupProfileWatch
                                            .businessEmailController,
                                        labelText: "Business email",
                                        hintText: "Enter Business email",
                                        validator: (value) =>
                                            Validator.validateName(value),
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
                                      //     DateTimeSlots(
                                      //   initialSlots: [
                                      //     DateTimeSlot(day: 'Monday', openTime: '09:00 AM', closeTime: '05:00 PM'),
                                      //   ],
                                      //   onSlotsUpdated: (updatedSlots) {
                                      //     print('Updated Slots: $updatedSlots');
                                      //   },
                                      // ),
                                     

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

                                       DateTimeSlot(
                                      dayLabel: "Day",
                                      openTimeLabel: "Opening Time",
                                      closeTimeLabel: "Closing Time",
                                      dayController: setupProfileWatch.dayController,
                                      openTimeController: setupProfileWatch.openTimeController,
                                      closeTimeController: setupProfileWatch.closeTimeController,
                                      onAddSlot: () => setupProfileWatch.handleAddSlot(context, setupProfileRead),
                                      onDeleteSlot: () {}, // Empty here for individual slots
                                      isDeleteButtonVisible: false,
                                    ),
                                    const SizedBox(height: 20),

                          // Display Slots
                          if (setupProfileWatch.slots.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: setupProfileWatch.slots.length,
                              itemBuilder: (context, index) {
                                final slot = setupProfileWatch.slots[index];
                                return ListTile(
                                  title: Text("${slot.day}: ${slot.openTime} - ${slot.closeTime}"),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => setupProfileRead.deleteSlot(slot),
                                  ),
                                );
                              },
                            ),

                                      const SizedBox(height: 20),
                                      HorizontalDottedLine(),
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
                                            .businessNameController,
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
                                            .businessNameController,
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
                                            .businessNameController,
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
                                            .businessNameController,
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
                                        text: "Submit",
                                        isLoading: false,
                                        onPressed: () async {
                                          // loginRead.login(context);
                                          setState(() {
                                            prevIndex = 2;
                                          });
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
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      text: text,
      height: 38,
    );
  }
// }
}
