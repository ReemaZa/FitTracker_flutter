import 'package:flutter/material.dart';
import '../../domain/entities/comment.dart';
import '../controllers/post_detail_controller.dart';
import 'reply_box.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final PostDetailController controller;

  const CommentCard({
    super.key,
    required this.comment,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Définir ici car on peut utiliser les paramètres
    final currentUserId = controller.currentUserId;

    final bool canToggleSolution =
        comment.parentCommentId == null && comment.author.id == currentUserId;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(comment.author.avatarUrl),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.author.name),
                    Text('${comment.createdAt}'),
                  ],
                ),
                const Spacer(),
                // ✅ Icône solution
                // ✅ Icône solution
                GestureDetector(
                  onTap: canToggleSolution
                      ? () {
                          controller
                              .toggleSolution(comment.id); // <- enable toggling
                        }
                      : null,
                  child: canToggleSolution
                      ? Icon(
                          Icons.check_circle,
                          size: 22,
                          color: comment.isSolution
                              ? Colors.green
                              : (canToggleSolution
                                  ? Colors.grey
                                  : Colors.transparent),
                        )
                      : SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment.content),
            Row(
              children: [
                TextButton(
                  onPressed: () => controller.replyToComment.value = comment,
                  child: const Text("Reply"),
                ),
              ],
            ),
            // Inline reply box for this comment
            ValueListenableBuilder<Comment?>(
              valueListenable: controller.replyToComment,
              builder: (_, replyTo, __) {
                if (replyTo == null) return const SizedBox.shrink();
                if (replyTo.id != comment.id) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ReplyBox(controller: controller, forPost: false),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
