import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Provider for Revenue
final revenueProvider = Provider<Map<String, String>>((ref) {
  return {
    'Today': '\$1,200',
    'This Week': '\$8,400',
    'This Month': '\$36,000',
  };
});

// Revenue Widget
class Revenue extends ConsumerWidget {
  const Revenue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revenue = ref.watch(revenueProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: revenue.entries.map((entry) {
        return ListTile(
          title: Text(entry.key),
          trailing: Text(entry.value),
        );
      }).toList(),
    );
  }
}
