import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BusinessCard extends StatelessWidget {
  final Profile profile;
  final Profile? selectedBusiness;
  final Function(Profile) onSelectBusiness;
  final Function(Profile) onShareProfile;

  const BusinessCard({
    super.key,
    required this.profile,
    required this.selectedBusiness,
    required this.onSelectBusiness,
    required this.onShareProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelectBusiness(profile),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: selectedBusiness?.uuid == profile.uuid
                ? Colors.blue
                : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Stack(
              children: [
                InkWell(
                  onTap: () => context.go('/main_screen/business_details'),
                  child: Container(
                    height: 324,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      // overflow: DecorationOverflow.clip,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        profile.croppedImageUrl ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: progress.expectedTotalBytes != null
                                  ? progress.cumulativeBytesLoaded /
                                      (progress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => onSelectBusiness(profile),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: profile.averageRatings > 0
                                ? Colors.yellow
                                : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            profile.averageRatings.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Business Name
            Text(
              profile.name ?? '',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: red
              ),
            ),
            // Business Description
            const SizedBox(height: 4),
            Text(
              profile.description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                height: 1.5,
                color: grey500,
                fontWeight: FontWeight.w400
              ),
            ),
            const SizedBox(height: 8),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/main_screen/business_details');
                      // Navigator.pushNamed(
                      //   context,
                      //   '/register-business',
                      //   arguments: {'update': profile.uuid},
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7F2FF),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Set border radius to 5px
                      ),
                    ),
                    child: const Text('Update Business Details', style: TextStyle(color: red),),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => onShareProfile(profile),
                  child:  Container(
                    padding: const EdgeInsets.all(10.0),
                    color: white200,
                    child: SvgPicture.asset(
                    'assets/svg/business-share.svg',
                                  width: 8.0,
                                  height: 20.0,
                                ), )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Profile {
  final String uuid;
  final String? name;
  final String? description;
  final double averageRatings;
  final String? croppedImageUrl;

  Profile({
    required this.uuid,
    this.name,
    this.description,
    this.averageRatings = 0.0,
    this.croppedImageUrl,
  });
}
