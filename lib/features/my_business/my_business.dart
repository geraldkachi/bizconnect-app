// // ignore_for_file: prefer_const_constructors

// import 'package:bizconnect/features/auth/login/login_view_modal.dart';
// import 'package:bizconnect/widget/business_card.dart';
// import 'package:bizconnect/widget/button.dart';
// import 'package:bizconnect/widget/input.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:bizconnect/app/theme/colors.dart';
// import 'package:bizconnect/utils/string_utils.dart';
// import 'package:bizconnect/utils/validator.dart';

// class MyBusinessPage extends ConsumerStatefulWidget {
//   const MyBusinessPage({
//     super.key,
//   });

//   @override
//   ConsumerState<MyBusinessPage> createState() => _MyBusinessPageState();
// }

// class _MyBusinessPageState extends ConsumerState<MyBusinessPage> {
//   Profile? selectedBusiness;

//   final List<Profile> profiles = [
//     Profile(
//       uuid: "1",
//       name: "Business 1",
//       description: "Description of Business 1",
//       averageRatings: 4.5,
//       croppedImageUrl: "https://via.placeholder.com/150",
//     ),
//     Profile(
//       uuid: "2",
//       name: "Business 2",
//       description: "Description of Business 2",
//       averageRatings: 3.8,
//       croppedImageUrl: "https://via.placeholder.com/150",
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final loginWatch = ref.watch(loginViewModelProvider);
//     final loginRead = ref.read(loginViewModelProvider.notifier);
//     final currentYear = DateTime.now().year;

//     return Scaffold(
//         body: SizedBox.expand(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
//         child: SingleChildScrollView(
//             child: Expanded(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // color: cyan100,
//                   child: Expanded(
//                     child: SingleChildScrollView(
//                       child: Expanded(
//                         child: SingleChildScrollView(
//                           child: ListView.builder(
//                             itemCount: profiles.length,
//                             itemBuilder: (context, index) {
//                               final profile = profiles[index];
//                               return BusinessCard(
//                                 profile: profile,
//                                 selectedBusiness: selectedBusiness,
//                                 onSelectBusiness: (selected) {
//                                   selectedBusiness = selected;
//                                   print("Selected: ${selected.name}");
//                                 },
//                                 onShareProfile: (profile) {
//                                   print("Share profile: ${profile.name}");
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                      Text('MyBusinessPage'),
//                 Text(""),
//                 // this shoule be at the botton of the screen
//                 const SizedBox(height: 45),
//                 Padding(
//                   padding: const EdgeInsets.all(36.0),
//                   child: Center(
//                     child: Text(
//                       '$currentYear Bizconnect24. All rights reserved',
//                       style: const TextStyle(
//                           fontSize: 12.0,
//                           color: grey500,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                 )
//               ]),
//         )),
//       ),
//     ));
//   }
// }

// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:bizconnect/features/auth/login/login_view_modal.dart';
import 'package:bizconnect/widget/business_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBusinessPage extends ConsumerStatefulWidget {
  const MyBusinessPage({super.key});

  @override
  ConsumerState<MyBusinessPage> createState() => _MyBusinessPageState();
}

class _MyBusinessPageState extends ConsumerState<MyBusinessPage> {
  Profile? selectedBusiness;

  final List<Profile> profiles = [
    Profile(
      uuid: "1",
      name: "Business 1",
      description: "Description of Business 1",
      averageRatings: 4.5,
      croppedImageUrl: "https://picsum.photos/200/300",
      // croppedImageUrl: "business-test.svg",
    ),
    Profile(
      uuid: "2",
      name: "Business 2",
      description: "Description of Business 2",
      averageRatings: 3.8,
      croppedImageUrl: "https://picsum.photos/200",
      // croppedImageUrl: "https://via.placeholder.com/150",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Scaffold(
      backgroundColor: grey50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "My Businesses",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: red,
                          ),
                        ),
                        Text(
                          "Here is a list of all business associated \nwith your account.",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: grey500,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // Add your click action here
                      },
                      child: SvgPicture.asset(
                        'assets/svg/notification.svg'),
                    ),
                  ],
                ),
              ),

              // Business List Section
              Expanded(
                child: ListView.builder(
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return BusinessCard(
                      profile: profile,
                      selectedBusiness: selectedBusiness,
                      onSelectBusiness: (selected) {
                        setState(() {
                          selectedBusiness = selected;
                        });
                      },
                      onShareProfile: (profile) {},
                    );
                  },
                ),
              ),

              // Footer Section
              // Padding(
              //   padding: const EdgeInsets.only(top: 20, bottom: 10),
              //   child: Center(
              //     child: Text(
              //       '$currentYear Bizconnect24. All rights reserved',
              //       style: TextStyle(
              //         fontSize: 12.0,
              //         color: grey500,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
