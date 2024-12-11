import 'package:bizconnect/features/my_business/my_buisiness_view_model.dart';
import 'package:bizconnect/widget/business_card.dart';
import 'package:bizconnect/widget/croppedImage.dart';
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
    // print( 'businessListData $businessListData');

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
                            reverse: true,
                            itemCount: businessListData.length,
                            itemBuilder: (context, index) {
                              final business = businessListData[index];
                                // onTba oi i want to send the enit
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
