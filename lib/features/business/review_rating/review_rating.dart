import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for Review Ratings
final reviewRatingProvider = Provider<List<Map<String, dynamic>>>((ref) {
  return [
    {'name': 'User 1', 'rating': 4.5, 'review': 'Great service!'},
    {'name': 'User 2', 'rating': 3.0, 'review': 'Good, but could improve.'},
    {'name': 'User 3', 'rating': 5.0, 'review': 'Excellent experience!'},
  ];
});

// Review Rating Widget
class ReviewRating extends ConsumerWidget {
    final Map<String, dynamic> businessDetails;

  const ReviewRating({Key? key, required this.businessDetails})
      : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewRatingProvider);

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ListTile(
          title: Text(review['name']),
          subtitle: Text(review['review']),
          trailing: Text('${review['rating']} ⭐'),
        );
      },
    );
  }
}
