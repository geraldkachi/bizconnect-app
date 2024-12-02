// // ignore_for_file: prefer_const_constructors
// import 'package:bizconnect/widget/button.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:bizconnect/app/theme/colors.dart';

// class SetupBusinessProfilePage extends ConsumerStatefulWidget {
//   const SetupBusinessProfilePage({super.key});

//   @override
//   ConsumerState<SetupBusinessProfilePage> createState() =>
//       _SetupBusinessProfilePageState();
// }

// class _SetupBusinessProfilePageState extends ConsumerState<SetupBusinessProfilePage> with SingleTickerProviderStateMixin {
//   // bool showSuccess = true; // Tracks the current view
//   late TabController? _tabController;
//   List<String> options = ['Monthly', 'Weekly', 'Daily'];
//   bool _isStatsTabEnabled = false;
//   int? prevIndex = 0;

//    @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentYear = DateTime.now().year;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SingleChildScrollView(
//               child: Form(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 26),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 34, horizontal: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: GestureDetector(
//                           child: TabBar(
//                             controller: _tabController,
//                             dividerColor: const Color(0xff5F5F5F),
//                             indicatorSize: TabBarIndicatorSize.tab,
//                             indicatorPadding: EdgeInsets.zero,
//                             unselectedLabelColor: const Color(0xffA1A6A9),
//                             labelColor: Colors.white,
//                             indicator: UnderlineTabIndicator(
//                               borderSide: BorderSide(
//                                 width: 1.0,
//                                 color: red.withOpacity(0.7),
//                               ),
//                               insets: EdgeInsets.zero,
//                             ),
//                             onTap: (index) {
//                               if (index == 2) {
//                                 print('index $index');
//                                 _tabController?.index = prevIndex!;
//                                 return;
//                               }
//                               prevIndex = index;
//                             },
//                             tabs: [
//                               _buildTab(''),
//                               _buildTab(''),
//                             ],
//                           ),
//                         ),
//                       ),
//                         const SizedBox(height: 20),
//                     // Check your email view

//                     Expanded(
//                       child: TabBarView(
//                     controller: _tabController,
//                     children: const [
                     
//                         SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Text('Tab 1')
//                             ],
//                           ),
//                         ),
//                       // ),
//                       // TransactionsScreen(),
//                       // IgnorePointer(
//                       //     child: StatisticsTab(
//                       //         homeWatch: homeWatch, options: options)),
//                     ],
//                   )),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(36.0),
//               child: Center(
//                 child: Text(
//                   '$currentYear Bizconnect24. All rights reserved',
//                   style: const TextStyle(
//                       fontSize: 12.0,
//                       color: grey500,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _buildTab(String text) {
//   return Tab(
//     text: text,
//     height: 38,
//   );
// }


// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/theme/colors.dart';

class SetupBusinessProfilePage extends ConsumerStatefulWidget {
  const SetupBusinessProfilePage({super.key});

  @override
  ConsumerState<SetupBusinessProfilePage> createState() =>
      _SetupBusinessProfilePageState();
}

class _SetupBusinessProfilePageState
    extends ConsumerState<SetupBusinessProfilePage> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Container(
           padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                      ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 26),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        // dividerColor: cyan100,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: EdgeInsets.zero,
                        // unselectedLabelColor: const Color(0xffA1A6A9),
                        labelColor: Colors.white,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 3.0,
                            color: cyan100,
                          ),
                          // insets: EdgeInsets.zero,
                           insets: const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        onTap: (index) {
                          if (index >= _tabController.length) {
                            _tabController.index = prevIndex;
                            return;
                          }
                          prevIndex = index;
                        },
                        tabs: [
                          _buildForm1(),
                          _buildForm2(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          SingleChildScrollView(
                            child: Column(
                              children: [Text('Tab 1 Content')],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [Text('Tab 2 Content')],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget _buildTab(String text) {
    return Tab(
      text: text,
      height: 38,
    );
  }





  Widget _buildForm1() {
    return Tab(
      height: 68,
      child: Form(
        key: _formKeys[0],
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First Name is required';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last Name is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm2() {
    return Tab(
      height: 68,
      child: Form(
        key: _formKeys[1],
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone Number is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateCurrentForm()) {
                  // _showToast("Form submitted successfully!");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF17BEBB),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}