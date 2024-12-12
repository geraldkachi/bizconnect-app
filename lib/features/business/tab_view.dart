import 'package:bizconnect/app/theme/colors.dart';
// import 'package:bizconnect/features/business/new_arrivals/new_arrivals.dart';
// import 'package:bizconnect/features/business/orders/orders.dart';
// import 'package:bizconnect/features/business/revenue/revenue.dart';
// import 'package:bizconnect/features/business/review_rating/review_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabViewScreen extends StatefulWidget {
  final String activeTab;
  final String businessId;
  final Map<String, dynamic> businessDetails;
  final Map<String, dynamic> featureFlags;

  const TabViewScreen({
    Key? key,
    required this.activeTab,
    required this.businessId,
    required this.businessDetails,
    required this.featureFlags,
  }) : super(key: key);

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {
  late String activeTab;

  @override
  void initState() {
    super.initState();
    activeTab = widget.activeTab;
  }

  void setActiveTab(String tab) {
    setState(() {
      activeTab = tab;
    });
  }

  Widget buildTab({
    required String label,
    required String tabKey,
    required String activeIcon,
    required String inactiveIcon,
    bool hasIcon = true,
    bool prefetch = false,
  }) {
    final isActive = activeTab == tabKey;
    return GestureDetector(
      onTap: () => setActiveTab(tabKey),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? red : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (hasIcon) ...[
              // Image.asset(
              //   isActive ? activeIcon : inactiveIcon,
              //   height: 20,
              //   width: 20,
              // ),
              SvgPicture.asset(
                isActive ? activeIcon : inactiveIcon,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 10),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // Tab bar
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildTab(
                  label: "New Arrivals & Offers",
                  // label: "Product listing",
                  tabKey: "new-arrivals",
                  activeIcon: "assets/svg/new-arrivals.svg",
                  inactiveIcon: "assets/svg/new-arrival.svg",
                ),
                const SizedBox(width: 10),
                buildTab(
                  label: "Orders",
                  tabKey: "orders",
                  activeIcon: "assets/svg/new-arrivals.svg",
                  // activeIcon: "assets/svg/new-arrivals.-act.png",
                  inactiveIcon: "assets/svg/new-arrivals.svg",
                  // inactiveIcon: "assets/svg/orders.png",
                ),
                const SizedBox(width: 10),
                buildTab(
                  label: "Revenue",
                  tabKey: "revenue",
                  activeIcon: "assets/svg/new-arrivals.svg",
                  inactiveIcon: "assets/svg/new-arrivals.svg",
                  // inactiveIcon: "assets/svg/revenue.png",
                ),
                const SizedBox(width: 10),
                buildTab(
                  label: "⭐ Reviews & Ratings",
                  tabKey: "review-ratings",
                  activeIcon: "",
                  inactiveIcon: "",
                  hasIcon: false,
                ),
              ],
            ),
          ),
          const Divider(),
          // Tab content
          if (activeTab == "new-arrivals")
            NewArrivals(
              businessId: widget.businessId,
              businessDetails: widget.businessDetails,
              featureFlags: widget.featureFlags,
            )
            // Text('G')
          else if (activeTab == "orders")
            const Orders()
          else if (activeTab == "revenue")
            const Revenue()
          else if (activeTab == "review-ratings")
            ReviewRating(businessDetails: widget.businessDetails),
        ],
      ),
    );
  }
}

// Placeholder Widgets for Tab Content
class NewArrivals extends StatelessWidget {
  final String businessId;
  final Map<String, dynamic> businessDetails;
  final Map<String, dynamic> featureFlags;

  const NewArrivals({
    Key? key,
    required this.businessId,
    required this.businessDetails,
    required this.featureFlags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("New Arrivals Content"));
  }
}

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Orders Content"));
  }
}

class Revenue extends StatelessWidget {
  const Revenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Revenue Content"));
  }
}

class ReviewRating extends StatelessWidget {
  final Map<String, dynamic> businessDetails;

  const ReviewRating({Key? key, required this.businessDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Reviews & Ratings Content"));
  }
}
