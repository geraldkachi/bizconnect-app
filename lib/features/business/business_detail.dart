// ignore_for_file: prefer_const_constructors, prefer_const_declarations, avoid_unnecessary_containers
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/features/business/widget/my_business_card.dart';
import 'package:bizconnect/features/business/widget/my_business_detail_info.dart';
import 'package:bizconnect/features/my_business/my_buisiness_view_model.dart';
import 'package:bizconnect/models/my_business_list.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bizconnect/app/theme/colors.dart';

class BusinessDetailPage extends ConsumerStatefulWidget {
  final String id;  // Accept the profile in the constructor
  // final BusinessProfile profile;  // Accept the profile in the constructor
  const BusinessDetailPage({super.key, required this.id});

  @override
  ConsumerState<BusinessDetailPage> createState() => _BusinessDetailPageState();
}
class _BusinessDetailPageState extends ConsumerState<BusinessDetailPage> {

 @override
  void initState() {
    super.initState();
    final myBusinessWatchRead = ref.read(myBusinessViewModelProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myBusinessWatchRead.fetchBusinessDetails(context, id: widget.id);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final businessDetailWatch = ref.watch(myBusinessViewModelProvider);
    final profile = businessDetailWatch.businessDetails;

    // final profile = widget.profile;

    // Dummy Data
//     const String businessName = "Tech Solutions Inc.";
//     final String businessCategory = "Software Development";
//     final String croppedImageUrl =
//         "https://picsum.photos/200/300"; // Placeholder image
//     final int followersCount = 1250;
//     final List<String> orderedDays = [
//       "Monday: 9 AM - 5 PM",
//       "Tuesday: 9 AM - 5 PM",
//       "Wednesday: 9 AM - 5 PM",
//       "Thursday: 9 AM - 5 PM",
//       "Friday: 9 AM - 5 PM",
//     ];

//     // Dummy Data for BusinessProfile
//     final businessDetails = BusinessProfile(
//       uuid: "",
//       userUuid: "",
//       name: 'german',
//       imageUrl: [''],
//       street: '123 Tech Avenue',
//       city: 'Tech City',
//       stateAndProvince: 'Bizconnect State',
//       facebookUrl: 'https://facebook.com/bizconnect24',
//       instagramUrl: 'https://instagram.com/bizconnect24',
//       twitterUrl: 'https://twitter.com/bizconnect24',
//       websiteUrl: 'https://bizconnect24.com',
//       phoneNumber: '123-456-7890',
//       businessEmail: 'info@bizconnect.com',
//       description: 'We provide business innovative tech solutions.',
//       isOwner: true,
//       daysOfOperation: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
//     );

// // Example Usage in a Scaffold
//     final List<String> openingHours = [
//       "Monday: 9 AM - 5 PM",
//       "Tuesday: 9 AM - 5 PM",
//       "Wednesday: 9 AM - 5 PM",
//     ];
    //  Usage Example
    void showShareModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        context.pop();
                        // homeRead.clearFlagBottomSheetFields();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20.0,
                      )),
                ),
                const Text(
                  "Share this business!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Share via Social Media"),
                ),
              ],
            ),
          );
        },
      );
    }

    void showOpeningHoursModal(BuildContext context, List<String> orderedDays) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        context.pop();
                        // homeRead.clearFlagBottomSheetFields();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 20.0,
                      )),
                ),
                const Text(
                  "Opening Hours",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...orderedDays.map((day) => Text(day)).toList(),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
  backgroundColor: grey50,
  body: Padding(
    padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
    child: Column(
      children: [
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/svg/back.svg',
                height: 20,
                color: const Color(0xff1B1C1E),
              ),
              const Spacer(),
              Text(
                "Business Details",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: red,
                  letterSpacing: -.5,
                ),
              ),
              const Spacer(),
            ],
          ),
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // Navigate back to the previous screen
            }
          },
        ),
        const SizedBox(height: 16),
        // Wrap the scrollable content
         Expanded(
          child: SingleChildScrollView(
            child:  businessDetailWatch.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : profile == null
                        ? const Center(
                            child: Text(
                              'No businesses found.',
                              style: TextStyle(color: grey500),
                            ),
                          )
                        : 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 MyBusinessDetailsCard(
                    businessName: profile.name ?? 'Business Name',
                    businessCategory: profile.description ?? 'Category',
                    croppedImageUrl: profile.croppedImageUrl ?? 'https://res.cloudinary.com/drwt2qqf9/image/upload/c_fill,h_500,w_500,q_auto/v1721488956/default-img_vhxk4d.jpg',
                    followersCount: profile.followersCount ?? 0,
                    orderedDays: profile.operationDays?.map((e) => e.day).toList() ?? [],
                    onShare: showShareModal,
                    onViewOpeningHours: (context) =>
                        showOpeningHoursModal(context, profile.operationDays?.map((e) => e.day).toList() ?? []),
                  ),
                  BusinessDetailsInfo(businessDetails: profile),
          
              
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

  }
}
