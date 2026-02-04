import 'package:fit_tracker/features/forum/domain/entities/comment.dart';
import 'package:fit_tracker/features/forum/presentation/controllers/post_detail_controller.dart';
import 'package:fit_tracker/features/forum/presentation/widgets/comment_card.dart';
import 'package:flutter/material.dart';

class CommentThread extends StatefulWidget {
  final Comment comment;
  final PostDetailController controller;
  final int depth; // 👈 niveau

  const CommentThread({
    super.key,
    required this.comment,
    required this.controller,
    this.depth = 0, // par défaut : commentaire principal
  });

  @override
  State<CommentThread> createState() => _CommentThreadState();
}

class _CommentThreadState extends State<CommentThread> {
  bool _showReplies = false;

  @override
  Widget build(BuildContext context) {
    final comment = widget.comment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentCard(
          comment: comment,
          controller: widget.controller,
        ),
        if (comment.replies.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: widget.depth == 0 ? 24.0 : 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => setState(() => _showReplies = !_showReplies),
                  child: Text(_showReplies
                      ? 'Hide replies (${comment.replies.length})'
                      : 'Show replies (${comment.replies.length})'),
                ),
                if (_showReplies)
                  Column(
                    children: comment.replies
                        .map(
                          (reply) => CommentThread(
                            comment: reply,
                            controller: widget.controller,
                            depth: widget.depth + 1,
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
