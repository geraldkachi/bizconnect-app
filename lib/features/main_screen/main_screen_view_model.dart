import 'package:bizconnect/features/discover_business/discover_business.dart';
import 'package:bizconnect/features/explore_products/explore_products.dart';
import 'package:bizconnect/features/more/more.dart';
import 'package:bizconnect/features/my_business/my_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bizconnect/app/locator.dart';
// import 'package:bizconnect/features/admin/admin_homepage.dart';
// import 'package:bizconnect/features/health/health_home_page.dart';
// import 'package:bizconnect/features/home/home_viemodel.dart';
// import 'package:bizconnect/features/home/homepage.dart';
// import 'package:bizconnect/features/profile/profile_page.dart';
import 'package:bizconnect/service/navigator_service.dart';

final mainScreenViewModelProvider =
    ChangeNotifierProvider<MainScreenViewModel>((ref) => MainScreenViewModel());

class MainScreenViewModel extends ChangeNotifier {
  final NavigatorService _navigatorService = getIt<NavigatorService>();

  int get currentIndex => _navigatorService.currentIndex;
  final List<Widget> pages = [
    const MyBusinessPage(),
    const DiscoverBusinessPage(),
    const ExploreProductsPage(),
    const MorePage(),
  ];

  void onTabTapped(int index) {
    _navigatorService.currentIndex = index;
    notifyListeners();
  }

  Widget getIcon(String selectedIcon, String unselectedIcon, int index) {
    return SvgPicture.asset(
      currentIndex == index ? selectedIcon : unselectedIcon,
      width: 24,
      height: 24,
    );
  }
}
