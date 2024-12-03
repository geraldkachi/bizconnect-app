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

    final dropDownKey = GlobalKey<DropdownSearchState<String>>();


  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final setupProfileWatch = ref.watch(setupBusinessProfileViewModelProvider);
    final setupProfileRead = ref.read(setupBusinessProfileViewModelProvider.notifier);

     Future<List<String>> fetchItems(String filter) async {
    // Simulate fetching data with a delay
    await Future.delayed(Duration(seconds: 1));
    
    // Example static list of items
    List<String> allItems = ['Item1', 'Item2', 'Item3', 'Item4'];
    
    // Filter based on the input
    return allItems.where((item) => item.toLowerCase().contains(filter.toLowerCase())).toList();
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
                    // TabBar
                    TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.zero,
                      labelColor: Colors.white,
                      unselectedLabelColor: const Color(0xffA1A6A9),
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 3.0,
                          color: cyan100,
                        ),
                        insets: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onTap: (index) {
                        if (index >= _tabController.length) {
                          _tabController.index = prevIndex;
                          return;
                        }
                        prevIndex = index;
                      },
                      tabs: const [
                        Tab(
                          text: "",
                          height: 38,
                        ),
                        Tab(
                          text: "",
                          height: 38,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // TabBarView
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
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
                                InputField(
                                  controller:
                                      setupProfileWatch.businessNameController,
                                  labelText: "Business name",
                                  hintText: "Enter Business Name",
                                  validator: (value) => Validator.validateName(value),),
                                InputField(
                                  controller: setupProfileWatch
                                      .describeYourBusinessController,
                                  labelText: "Describe your business",
                                  hintText:
                                      "Short Sentence about your business",
                                  validator: (value) => Validator.validateName(value),),
                                Text("Upload Logo"),
                                InputField(
                                  controller: setupProfileWatch
                                      .businessCategoryController,
                                  labelText: "Business Category*",
                                  hintText: "search Business Category",
                                  validator: (value) => Validator.validateName(value),),
                                InputField(
                                  controller:
                                      setupProfileWatch.selectCountryController,
                                  labelText: "Select Country*",
                                  hintText: "select Country",
                                  validator: (value) => Validator.validateName(value),),
                                DropdownField<String>(
                                  dropdownKey: dropDownKey,
                                  labelText: "Select Category",
                                  hintText: "Choose an option",
                                  items: const ['Category 1', 'Category 2', 'Category 3'],
                                  selectedItem: "Category 1",
                                  onChanged: (value) {
                                    print("Selected: $value");
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  dropdownIcon: const Icon(Icons.arrow_drop_down,color: grey400),
                                  // showSearchBox: true,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: const [
                                Text(
                                  'Tab 2 Content',
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 20),
                                Text('Additional content for Tab 2'),
                              ],
                            ),
                          ),
                        ],
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
