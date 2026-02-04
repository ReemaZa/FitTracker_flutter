import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:fit_tracker/features/forum/domain/entities/forum_post.dart';
import 'package:fit_tracker/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final ForumPost post;
  final void Function(int) onLike;
  final void Function(int postId) onPin;

  const PostCard(
      {super.key,
      required this.post,
      required this.onLike,
      required this.onPin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            //Text(post.excerpt),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.postDetail,
                    arguments: post.id,
                  );
                },
                child: const Text('See More'),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.access_time_outlined,
                  size: 16,
                  color: AppColors.secondaryPurple,
                ),
                const SizedBox(width: 4),
                Text(
                  formatDateTime(post.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryPurple,
                  ),
                ),
                const Spacer(),
                Text(post.category),
                IconButton(
                  icon: Icon(
                    post.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  ),
                  onPressed: () => onPin(post.id),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime date) {
    return DateFormat('dd MMM yyyy • HH:mm').format(date);
  }
}
