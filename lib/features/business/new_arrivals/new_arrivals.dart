import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Step 1: Define a Provider (State or Future provider)
final newArrivalProvider = Provider<List<String>>((ref) {
  // Replace this with your actual data fetching or logic
  return ['Item 1', 'Item 2', 'Item 3'];
});

// Step 2: Create the Widget
class NewArrivals extends ConsumerWidget {
 final String businessId;
  final Map<String, dynamic> businessDetails;
  final Map<String, dynamic> featureFlags;

  const NewArrivals({
    super.key,
    required this.businessId,
    required this.businessDetails,
    required this.featureFlags,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the provider to get data
    final newArrivals = ref.watch(newArrivalProvider);

    return 
    ListView.builder(
      itemCount: newArrivals.length,
      itemBuilder: (context, index) {
        return 
        ListTile(
          title: Text(newArrivals[index]),
        );
      },
    );
  }
}
