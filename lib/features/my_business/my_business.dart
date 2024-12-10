import 'package:bizconnect/features/auth/login/login_view_modal.dart';
import 'package:bizconnect/features/my_business/my_buisiness_view_model.dart';
import 'package:bizconnect/widget/business_card.dart';
import 'package:bizconnect/widget/croppedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class MyBusinessPage extends ConsumerStatefulWidget {
//   const MyBusinessPage({super.key});

//   @override
//   ConsumerState<MyBusinessPage> createState() => _MyBusinessPageState();
// }

// class _MyBusinessPageState extends ConsumerState<MyBusinessPage> {
//   Profile? selectedBusiness;

// // expect a data from an endpoint
//   final List<Profile> profiles = [
//     Profile(
//       uuid: "1",
//       name: "Business 1",
//       description: "Description of Business 1",
//       averageRatings: 4.5,
//       croppedImageUrl: "https://picsum.photos/200/300",
//     ),
//     Profile(
//       uuid: "2",
//       name: "Business 2",
//       description: "Description of Business 2",
//       averageRatings: 3.8,
//       croppedImageUrl: "https://picsum.photos/200",
//     ),
//   ];

//    void initState() {
//     super.initState();
//     final myBusinessWatchRead = ref.read(myBusinessViewModelProvider.notifier);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // This will run after the build method is completed     
//         myBusinessWatchRead.allBusinessList(context);
//     // _loadCategories();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//      final myBusinessWatch = ref.watch(myBusinessViewModelProvider);
//     final myBusinessWatchRead = ref.read(myBusinessViewModelProvider.notifier);

   

//     return Scaffold(
//       backgroundColor: grey50,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "My Businesses",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: red,
//                           ),
//                         ),
//                         Text(
//                           "Here is a list of all business associated \nwith your account.",
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                             color: grey500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     InkWell(
//                       onTap: () {
//                         // Add your click action here
//                       },
//                       child: SvgPicture.asset(
//                         'assets/svg/notification.svg'),
//                     ),
//                   ],
//                 ),
//               ),

//               // Business List Section
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: profiles.length,
//                   itemBuilder: (context, index) {
//                     final profile = profiles[index];
//                     return BusinessCard(
//                       profile: profile,
//                       selectedBusiness: selectedBusiness,
//                       onSelectBusiness: (selected) {
//                         setState(() {
//                           selectedBusiness = selected;
//                         });
//                       },
//                       onShareProfile: (profile) {},
//                     );
//                   },
//                 ),
//               ),

//               // Footer Section
//               // Padding(
//               //   padding: const EdgeInsets.only(top: 20, bottom: 10),
//               //   child: Center(
//               //     child: Text(
//               //       '$currentYear Bizconnect24. All rights reserved',
//               //       style: TextStyle(
//               //         fontSize: 12.0,
//               //         color: grey500,
//               //         fontWeight: FontWeight.w400,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class MyBusinessPage extends ConsumerStatefulWidget {
  const MyBusinessPage({super.key});

  @override
  ConsumerState<MyBusinessPage> createState() => _MyBusinessPageState();
}

class _MyBusinessPageState extends ConsumerState<MyBusinessPage> {
  Profile? selectedBusiness;

  @override
  void initState() {
    super.initState();
    final myBusinessWatchRead = ref.read(myBusinessViewModelProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myBusinessWatchRead.allBusinessList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myBusinessWatch = ref.watch(myBusinessViewModelProvider);
    final businessListData = myBusinessWatch.businessListData;

    return Scaffold(
      backgroundColor: grey50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        // Notification click action
                      },
                      child: SvgPicture.asset('assets/svg/notification.svg'),
                    ),
                  ],
                ),
              ),

              // Business List Section
              Expanded(
                child: myBusinessWatch.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : businessListData.isEmpty
                        ? const Center(
                            child: Text(
                              'No businesses found.',
                              style: TextStyle(color: grey500),
                            ),
                          )
                        : ListView.builder(
                            itemCount: businessListData.length,
                            itemBuilder: (context, index) {
                              final business = businessListData[index];
                              return BusinessCard(
                                profile: Profile(
                                  uuid: business['uuid'],
                                  name: business['name'],
                                  description: business['description'],
                                  croppedImageUrl: constructBizImgUrl(
                                            business['croppedImageUrl'],
                                            type: 'meta',
                                          ),
                                  averageRatings: business['averageRatings'] ?? 0.0,
                                ),
                                selectedBusiness: selectedBusiness,
                                onSelectBusiness: (selected) {
                                  setState(() {
                                    selectedBusiness = selected;
                                  });
                                },
                                onShareProfile: (profile) {
                                  // Handle share profile
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
