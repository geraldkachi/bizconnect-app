// ignore_for_file: prefer_const_constructors, prefer_const_declarations, avoid_unnecessary_containers
import 'package:bizconnect/app/locator.dart';
import 'package:bizconnect/features/business/tab_view.dart';
import 'package:bizconnect/features/business/widget/my_business_card.dart';
import 'package:bizconnect/features/business/widget/my_business_detail_info.dart';
import 'package:bizconnect/features/my_business/my_buisiness_view_model.dart';
import 'package:bizconnect/models/business%20details_model.dart';
import 'package:bizconnect/models/my_business_list.dart';
import 'package:bizconnect/service/auth_service.dart';
import 'package:bizconnect/widget/button.dart';
import 'package:bizconnect/widget/croppedImage.dart';
import 'package:bizconnect/widget/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessDetailPage extends ConsumerStatefulWidget {
  final String id; // Accept the profile in the constructor
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

    void showSocialShareModal(BuildContext context, String businessName,
        String shareableUrl, String imageUrl) {
      const textConstraint = 60;

      String shortenUrl(String url, int maxLength) {
        return url.length > maxLength
            ? '${url.substring(0, maxLength)}...'
            : url;
      }

      Future<void> handleSocialShare(String platform, String url) async {
        // Same as the handleSocialShare logic in the previous method

        String encodeUrl(String url) => Uri.encodeComponent(url);
        // Handles social share
        final socialUrls = {
          'message': 'sms:?body=Check out this business: ${encodeUrl(url)}',
          'instagram': url,
          'whatsapp':
              'https://wa.me/?text=Check out this business: ${encodeUrl(url)}',
          'x':
              'https://x.com/intent/tweet?url=${encodeUrl(url)}&text=Check out this business',
          'facebook':
              'https://www.facebook.com/sharer/sharer.php?u=${encodeUrl(url)}',
          'gmail':
              'mailto:?subject=Check out this business&body=${encodeUrl(url)}',
          'telegram':
              'https://telegram.me/share/url?url=${encodeUrl(url)}&text=Check out this business',
          'linkedin':
              'https://www.linkedin.com/sharing/share-offsite/?url=${encodeUrl(url)}',
        };

        final shareUrl = socialUrls[platform];
        // if (platform == 'instagram') {
        //   Clipboard.setData(ClipboardData(text: url));
        //   await launchUrl(Uri.parse('https://www.instagram.com/'));
        // } else if (shareUrl != null) {
        //   await launchUrl(Uri.parse(shareUrl));
        // }
        // If the platform is Instagram, copy the URL to the clipboard and optionally open Instagram
        if (platform == 'instagram') {
          Clipboard.setData(ClipboardData(text: url));
          await launchUrl(
              Uri.parse('https://www.instagram.com/')); // Open Instagram
        } else if (platform == 'whatsapp') {
          // For WhatsApp, use the wa.me URL scheme for messaging
          await launchUrl(Uri.parse(socialUrls['whatsapp']!));
        } else if (shareUrl != null) {
          // For other platforms, open the share URL
          await launchUrl(Uri.parse(shareUrl));
        } else {
          // Fallback if the platform isn't supported
          print("Platform not supported for sharing");
        }
      }

      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom drag handle (icon in the center)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 40, // Adjust the width of the handle
                    height: 5, // Adjust the height of the handle
                    decoration: BoxDecoration(
                      color: Colors.grey[400], // Color of the handle
                      borderRadius: BorderRadius.circular(
                          10), // Rounded corners for handle
                    ),
                    margin: const EdgeInsets.only(
                        bottom: 10), // Space below the handle
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "Share via social media",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: red),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                ),

                // Social Share Info
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    businessName,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500, color: red),
                  ),
                  subtitle: Text(shortenUrl(shareableUrl, textConstraint)),
                ),
                const SizedBox(height: 10),

                // Social Media Options
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    'message',
                    'instagram',
                    'whatsapp',
                    'x',
                    'facebook',
                    'gmail',
                    'telegram',
                    'linkedin',
                  ].map((platform) {
                    return GestureDetector(
                      onTap: () => handleSocialShare(platform, shareableUrl),
                      child: SvgPicture.asset(
                        'assets/svg/social/$platform.svg',
                        width: 40,
                        height: 40,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      );
    }

    void showShareModal(BuildContext context, String businessName,
        String shareableUrl, String imageUrl) {
      // const textConstraint = 90;

      // Encode URL for social sharing
      // String encodeUrl(String url) => Uri.encodeComponent(url);

      // // Handles social share
      // Future<void> handleSocialShare(String platform, String url) async {
      //   final socialUrls = {
      //     'message': 'sms:?body=Check out this business: ${encodeUrl(url)}',
      //     'instagram': url,
      //     'whatsapp': 'https://wa.me/?text=Check out this business: ${encodeUrl(url)}',
      //     'x': 'https://x.com/intent/tweet?url=${encodeUrl(url)}&text=Check out this business',
      //     'facebook': 'https://www.facebook.com/sharer/sharer.php?u=${encodeUrl(url)}',
      //     'gmail': 'mailto:?subject=Check out this business&body=${encodeUrl(url)}',
      //     'telegram': 'https://telegram.me/share/url?url=${encodeUrl(url)}&text=Check out this business',
      //     'linkedin': 'https://www.linkedin.com/sharing/share-offsite/?url=${encodeUrl(url)}',
      //   };

      //   final shareUrl = socialUrls[platform];
      //   if (platform == 'instagram') {
      //     Clipboard.setData(ClipboardData(text: url));
      //     await launchUrl(Uri.parse('https://www.instagram.com/'));
      //   } else if (shareUrl != null) {
      //     await launchUrl(Uri.parse(shareUrl));
      //   }
      // }

      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 40, // Adjust the width of the handle
                    height: 5, // Adjust the height of the handle
                    decoration: BoxDecoration(
                      color: Colors.grey[400], // Color of the handle
                      borderRadius: BorderRadius.circular(
                          10), // Rounded corners for handle
                    ),
                    margin: const EdgeInsets.only(
                        bottom: 10), // Space below the handle
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      // SizedBox(width: 20),
                      Text(
                        "Share your business",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: red),
                      ),
                      // IconButton(
                      //   onPressed: () => Navigator.pop(context),
                      //   icon: const Icon(Icons.close, size: 20),
                      // ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                HorizontalDottedLine(),
                // Copy Link Button
                ListTile(
                  leading: SvgPicture.asset('assets/svg/social/get-link.svg'),
                  title: const Text(
                    "Get clickable link",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400, color: red),
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: shareableUrl));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Link copied to clipboard")),
                    );
                  },
                ),

                const SizedBox(height: 20),
                HorizontalDottedLine(),
                // Share via Social Media
                ListTile(
                  leading: SvgPicture.asset('assets/svg/social/via-social.svg'),
                  title: const Text(
                    "Share via social media",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w400, color: red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showSocialShareModal(
                        context, businessName, shareableUrl, imageUrl);
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      );
    }

// void showOpeningHoursModal(BuildContext context, List<OperationDay> orderedDays) {
//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20.0),
//       ),
//     ),
//     builder: (context) {
//       return Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//              Align(
//               alignment: Alignment.topCenter,
//               child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//             SizedBox(width: 20),

//             Text(
//               "Opening Hours",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: red),
//             ),
//               IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: const Icon(Icons.close, size: 20),
//               ),
//             ],),
//             ),

//             const SizedBox(height: 10),
//             ...orderedDays.map((day) {
//               return Text('${day.day}: ${day.openTime} - ${day.closeTime}');
//             }).toList(),
//           ],
//         ),
//       );
//     },
//   );
// }

// Helper function to map days to index (1 = Monday, 7 = Sunday)
    int _getDayIndex(String day) {
      switch (day.toLowerCase()) {
        case 'monday':
          return 1;
        case 'tuesday':
          return 2;
        case 'wednesday':
          return 3;
        case 'thursday':
          return 4;
        case 'friday':
          return 5;
        case 'saturday':
          return 6;
        case 'sunday':
          return 7;
        default:
          return 0;
      }
    }

    void showOpeningHoursModal(
        BuildContext context, List<OperationDay> orderedDays) {
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
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 40, // Adjust the width of the handle
                    height: 5, // Adjust the height of the handle
                    decoration: BoxDecoration(
                      color: Colors.grey[400], // Color of the handle
                      borderRadius: BorderRadius.circular(
                          10), // Rounded corners for handle
                    ),
                    margin: const EdgeInsets.only(
                        bottom: 10), // Space below the handle
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        "Opening Hours",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: red),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, size: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ...orderedDays.map((day) {
                  bool isToday =
                      DateTime.now().weekday == _getDayIndex(day.day);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          day.day,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: isToday ? cyan100 : red,
                          ),
                        ),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isToday ? cyan100 : red,
                          ),
                        ),
                        Text(
                          '${day.openTime} - ${day.closeTime}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: isToday ? cyan100 : red),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 40),
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
                  Navigator.of(context)
                      .pop(); // Navigate back to the previous screen
                }
              },
            ),
            const SizedBox(height: 16),
            // Wrap the scrollable content
            Expanded(
              child: businessDetailWatch.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : profile == null
                      ? const Center(
                          child: Text(
                            'No businesses found.',
                            style: TextStyle(color: grey500),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyBusinessDetailsCard(
                                businessName: profile.name ?? 'Na',
                                businessCategory: profile.description ?? 'Na',
                                croppedImageUrl: constructBizImgUrl(
                                        profile.croppedImageUrl,
                                        type: 'meta') ??
                                    'https://res.cloudinary.com/drwt2qqf9/image/upload/c_fill,h_500,w_500,q_auto/v1721488956/default-img_vhxk4d.jpg',
                                followersCount: profile.followersCount ?? 0,
                                orderedDays: profile.operationDays ?? [],
                                // onShare: showShareModal, // help ensure the reight provides
                                onShare: (context) {
                                  final shareableUrl =
                                      'https://bizconnect24.com/business/${profile.uuid}'; // Construct the URL to share
                                  final businessName = profile.name ?? 'Na';
                                  final imageUrl = constructBizImgUrl(
                                          profile.croppedImageUrl,
                                          type: 'meta') ??
                                      'https://res.cloudinary.com/drwt2qqf9/image/upload/c_fill,h_500,w_500,q_auto/v1721488956/default-img_vhxk4d.jpg';
                                  showShareModal(context, businessName,
                                      shareableUrl, imageUrl);
                                },
                                onViewOpeningHours: (context) =>
                                    showOpeningHoursModal(
                                  context,
                                  profile.operationDays ?? [],
                                ),
                              ),
                              BusinessDetailsInfo(businessDetails: profile),

                              // activeTab: The initial active tab (new-arrivals, orders, revenue, or review-ratings).
                              // TabViewScreen(activeTab: true, businessId: 'active',)
                              TabViewScreen(
                                activeTab: 'new-arrivals',
                                businessId: 'diuchdiwuiwh',
                                businessDetails: const {
                                  'name': 'My Business',
                                  'owner': 'John Doe',
                                  'operationDays': [
                                    'Monday',
                                    'Tuesday',
                                    'Wednesday'
                                  ],
                                },
                                featureFlags: const {
                                  'enableRevenueTab': true,
                                  'enableRatingsTab': true,
                                },
                              ),
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
