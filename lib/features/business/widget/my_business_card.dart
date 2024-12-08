import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MyBusinessDetailsCard extends StatelessWidget {
  final String? businessName;
  final String? businessCategory;
  final String? croppedImageUrl;
  final int followersCount;
  final List<String> orderedDays; // Assume orderedDays are strings for simplicity
  // final Function() onShare;
  // final Function() toggleDropdown;
  // final bool isDropdownVisible;
  final Function(BuildContext) onShare;
  final Function(BuildContext) onViewOpeningHours;

  const MyBusinessDetailsCard({
    super.key,
    required this.businessName,
    required this.businessCategory,
    required this.croppedImageUrl,
    required this.followersCount,
    required this.orderedDays,
    required this.onShare,
    // required this.toggleDropdown,
    // required this.isDropdownVisible,
    required this.onViewOpeningHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF66A1F1), Color(0xFFAD56FF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        // image: const DecorationImage(
        //   image: AssetImage("assets/images/new-arrival/bg-lining.svg"),
        //   fit: BoxFit.cover,
        // ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Business Info Section
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  croppedImageUrl ?? '',
                  width: 66,
                  height: 66,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      businessName ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      businessCategory ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Followers: $followersCount",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons Section
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.start,
                children: [
              ElevatedButton.icon(
                // onPressed: orderedDays.isEmpty ? null : onShare,
                onPressed: () => onShare(context),
                icon: SvgPicture.asset(
                      "assets/svg/share.svg",
                      height: 16,
                    ),
                // Image.asset(
                //   "assets/svg/share.svg",
                //   height: 20,
                // ),
                label: const Text(
                  "Share",
                  style: TextStyle(fontSize: 14, color: red),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF007BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                // onPressed: toggleDropdown,
                onPressed: () => onViewOpeningHours(context),
                icon: SvgPicture.asset(
                  "assets/svg/view-open.svg",
                  height: 20,
                ),
                // Image.asset(
                //   "assets/svg/view-open.svg",
                //   height: 20,
                // ),
                label: const Text(
                  "View Opening Hours",
                  style: TextStyle(fontSize: 14, color: red),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF007BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // const SizedBox(width: 8),
              ],),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   '/register-business',
                  //   arguments: {'update': businessName},
                  // );
                   context.go(
                    '/register-business',
                    extra: {'update': businessName}, // Pass arguments with 'extra'
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Update Business Details",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
