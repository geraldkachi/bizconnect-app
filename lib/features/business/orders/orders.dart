import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for Orders
final ordersProvider = Provider<List<String>>((ref) {
  return ['Order #123', 'Order #124', 'Order #125'];
});

// Orders Widget
class Orders extends ConsumerWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(orders[index]),
        );
      },
    );
  }
}
