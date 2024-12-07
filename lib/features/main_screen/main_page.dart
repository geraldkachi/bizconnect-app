import 'package:bizconnect/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:bizconnect/features/admin/admin_homepage.dart';
// import 'package:bizconnect/features/health/health_home_page.dart';
import 'package:bizconnect/features/home/home_viewmodel.dart';
// import 'package:bizconnect/features/home/homepage.dart';
import 'package:bizconnect/features/main_screen/main_screen_view_model.dart';
// import 'package:bizconnect/features/profile/profile_page.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final mainWatch = ref.watch(mainScreenViewModelProvider);
    final mainRead = ref.read(mainScreenViewModelProvider.notifier);

    return Scaffold(
      body: mainWatch.pages[ref.watch(homeViemodelProvider).screenIndex ??
          mainWatch.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: cyan100,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: ref.watch(homeViemodelProvider).screenIndex ??
            mainWatch.currentIndex,
        onTap: mainRead.onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: mainRead.getIcon(
              'assets/svg/selected_business.svg',
              'assets/svg/unselected_business.svg',
              0,
            ),
            label: 'My Businesses',
          ),
          BottomNavigationBarItem(
            icon: mainRead.getIcon(
              'assets/svg/selected_discovery_business.svg',
              'assets/svg/unselected_discovery_business.svg',
              1,
            ),
            label: '  Discover \nBusinesses',
            
          ),
          BottomNavigationBarItem(
            icon: mainRead.getIcon(
              'assets/svg/explore_business.svg',
              'assets/svg/explore_business.svg',
              2,
            ),
            label: 'Explore Business',
          ),
          BottomNavigationBarItem(
            icon: mainRead.getIcon(
              'assets/svg/more.svg',
              'assets/svg/more.svg',
              2,
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
