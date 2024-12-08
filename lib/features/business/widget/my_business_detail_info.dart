// ignore_for_file: prefer_const_constructors

import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/features/business/widget/read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BusinessDetailsInfo extends StatelessWidget {
  final BusinessProfile? businessDetails;

  const BusinessDetailsInfo({super.key, this.businessDetails});

  @override
  Widget build(BuildContext context) {
    final formattedAddress = businessDetails?.street != null
        ? '${businessDetails?.street}, ${businessDetails?.city}, ${businessDetails?.stateAndProvince}'
        : '${businessDetails?.city}, ${businessDetails?.stateAndProvince}';

    final hasBusinessClosed = determineBusOpTime(businessDetails?.operationDays ?? []);

    List<Map<String, String?>> constructSocialLinks() {
      return [
        {'name': 'instagram-social', 'url': businessDetails?.instagramUrl},
        {'name': 'website-social', 'url': businessDetails?.websiteUrl},
        {'name': 'tiktok-social', 'url': businessDetails?.twitterUrl},
        {'name': 'facebook-social', 'url': businessDetails?.facebookUrl},
        {'name': 'linkedin-social', 'url': businessDetails?.facebookUrl},
      ];
    }

    final socialLinks = constructSocialLinks();
     Future<void> _launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      // if (await canLaunch(uri.toString())) { canLaunchUrl
      if (await canLaunchUrl(uri)) { 
        // await launch(uri.toString()); launchUrl
        await launchUrl(uri); 
      } else {
        throw 'Could not launch $url';
      }
    }

    void handleAddressClick() {
      final mapsUrl = 'https://www.google.com/maps?q=${Uri.encodeComponent(formattedAddress)}';
      _launchURL(mapsUrl);
    }

    void handlePhoneClick() {
      final phoneNumber = businessDetails?.phoneNumber;
      if (phoneNumber != null) {
        _launchURL('tel:$phoneNumber');
      }
    }

    void handleEmailClick() {
      final email = businessDetails?.businessEmail;
      if (email != null) {
        _launchURL('mailto:$email');
      }
    }

   
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Business Details", style: TextStyle(color: red, fontSize: 15, fontWeight: FontWeight.w700)),
            // BusinessHoursStatus(isOpen: hasBusinessClosed.isOpened, closingTime: hasBusinessClosed.closingTime),
            SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(fontSize: 15, color: grey500),
            ),
            // ReadMoreText(text: businessDetails?.description ?? "N/A"),
            ReadMoreText(
              // text: (businessDetails?.description ?? "N/A"),
              text: "This is a very long piece of text that exceeds the maximum length. "
                "You can click on 'Read more' to view the full text or 'Read less' to collapse it.",
              textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: red),
              maxLength: 50, // Customize the max length constraint
            ),

            SizedBox(height: 16),
            Text(
              'Contact Info',
              style: TextStyle(fontSize: 13, color: red),
            ),
            Column(
              children: [
                ContactCard(
                  title: 'Address',
                  tagline: formattedAddress,
                  icon: Icons.location_on,
                  onClick: handleAddressClick,
                ),
                ContactCard(
                  title: 'Mobile',
                  tagline: businessDetails?.phoneNumber ?? 'N/A',
                  icon: Icons.phone,
                  onClick: handlePhoneClick,
                ),
                ContactCard(
                  title: 'Email',
                  tagline: businessDetails?.businessEmail ?? 'N/A',
                  icon: Icons.mail,
                  onClick: handleEmailClick,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Follow our social media', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: red)),
            SizedBox(height: 4),
            SocialLinks(socialLinks: socialLinks),
          ],
        ),
      ),
    );
  }
}

class BusinessProfile {
  final String? street;
  final String? city;
  final String? stateAndProvince;
  final String? facebookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? websiteUrl;
  final String? phoneNumber;
  final String? businessEmail;
  final String? description;
  final bool? isOpened;
  final List<String>? operationDays;

  BusinessProfile({
    this.street,
    this.city,
    this.stateAndProvince,
    this.facebookUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.websiteUrl,
    this.phoneNumber,
    this.businessEmail,
    this.description,
    this.operationDays,
    this.isOpened,
  });
}


class BusinessHoursStatus extends StatelessWidget {
  final bool isOpen;
  final String closingTime;

  const BusinessHoursStatus({super.key, required this.isOpen, required this.closingTime});

  @override
  Widget build(BuildContext context) {
    return Text(isOpen ? 'Open * $closingTime' : 'Closed',);
  }
}

class SocialLinks extends StatelessWidget {
  final List<Map<String, String?>> socialLinks;

  const SocialLinks({super.key, required this.socialLinks});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: socialLinks.map((link) {
        final String? platform = link['name'];
        final String? url = link['url'];

        if (url != null) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.blue,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/svg/$platform.svg', // Ensure the SVG exists in the assets
                height:34,
                width:34,
              ),
              onPressed: () => _launchURL(url),
            ),
          );
        }
        // if (link['url'] != null) {
        //   return IconButton(
        //     icon: Icon(Icons.link),
        //     onPressed: () => _launchURL(link['url']!),
        //   );
        // }
        return SizedBox.shrink();
      }).toList(),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await  launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// class ContactCard extends StatelessWidget {
//   final String title;
//   final String tagline;
//   final IconData icon;
//   final VoidCallback onClick;

//   const ContactCard({
//     super.key,
//     required this.title,
//     required this.tagline,
//     required this.icon,
//     required this.onClick,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onClick,
//       child: Card(
//         child: ListTile(
//           leading: Icon(icon),
//           title: Text(title),
//           subtitle: Text(tagline),
//         ),
//       ),
//     );
//   }
// }


class ContactCard extends StatelessWidget {
  final String title;
  final String tagline;
  final IconData icon;
  final VoidCallback onClick;

  const ContactCard({
    super.key,
    required this.title,
    required this.tagline,
    required this.icon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        // padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(12.0),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.2),
        //       blurRadius: 8.0,
        //       spreadRadius: 2.0,
        //       offset: const Offset(0, 4),
        //     ),
        //   ],
        // ),
        child: Row(
          children: [
            // Leading Icon
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              // decoration: BoxDecoration(
              //   color: Colors.blue.withOpacity(0.1),
              //   shape: BoxShape.circle,
              // ),
              child: Icon(
                icon,
                color: red,
                size: 18.0,
              ),
            ),

            const SizedBox(width: 16.0),

            // Text Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: grey500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    tagline,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: lightBlue100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


bool determineBusOpTime(List<String> operationDays) {
  // You can implement the logic to determine business operation time here
  return true;
}
