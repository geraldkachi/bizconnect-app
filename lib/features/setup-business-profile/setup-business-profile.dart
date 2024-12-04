// ignore_for_file: prefer_const_constructors
import 'package:bizconnect/features/setup-business-profile/setup-business-view-model.dart';
import 'package:bizconnect/utils/validator.dart';
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

  bool _validateCurrentForm() {
    // Validate the current form based on the active tab
    return _formKeys[_tabController.index].currentState?.validate() ?? false;
  }

  void _onTabTapped(int index) {
    // Prevent switching tabs unless the form is valid
    if (index > _tabController.index && !_validateCurrentForm()) {
      // _showToast("Please complete the form before proceeding.");
      return;
    }
    prevIndex = index;
    _tabController.index = index;
  }

  final currentYear = DateTime.now().year;
  final dropDownKey = GlobalKey<DropdownSearchState<String>>();

  final ImagePicker _picker = ImagePicker(); // Image picker instance
  // FileImage? _image; // To store the selected image

  File? _image; // Variable to store the selected image
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void _deleteImage() {
    setState(() {
      _image = null; // Remove the selected image
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
                    Column(
                      children: [
                        // Tabs Row
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
                                      print(
                                        prevIndex,
                                      );
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
                                      // Tab Indicator
                                      SizedBox(
                                          width:
                                              10), // Gap between text and bar
                                      Container(
                                        // width: 164, // Width of the bar
                                        height: 4, // Fixed height of the bar
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
                              yield SizedBox(width: 10); // Gap between tabs
                            }).toList()
                              ..removeLast(), // Remove the last gap,
                          ),
                        ),
                        // Content Section
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  "Tell Us About Your Business",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: red),
                                ),
                              ),
                              SizedBox(height: 10),
                              prevIndex == 0 ? 
                              Column(
                                children: [
                                    SizedBox(height: 10),
                                InputField(
                                  controller:
                                      setupProfileWatch.businessNameController,
                                  labelText: "Business name",
                                  hintText: "Enter Business Name",
                                  validator: (value) =>
                                      Validator.validateName(value),
                                ),
                                const SizedBox(height: 5),
                                 ImageUploadField(
                                    labelText: "Upload Image",
                                   hintText: "Upload logo or business flyer",
                              ),
                                const SizedBox(height: 5),
                                InputField(
                                  controller: setupProfileWatch
                                      .describeYourBusinessController,
                                  labelText: "Business Category",
                                  hintText:
                                      "search Business Category",
                                  validator: (value) =>
                                      Validator.validateName(value),
                                      // prefixIcon: ,
                                ),
                                ],
                              )
                               :
                               Column(children: [
                                  SizedBox(height: 10),
                                InputField(
                                  controller:
                                      setupProfileWatch.businessNameController,
                                  labelText: "Business name",
                                  hintText: "Enter Business Name",
                                  validator: (value) =>
                                      Validator.validateName(value),
                                ),
                               ],)
                            ],
                          ),
                        )
                        // ),
                      ],
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
