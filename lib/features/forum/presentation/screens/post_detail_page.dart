import 'package:fit_tracker/features/forum/domain/entities/comment.dart';
import 'package:fit_tracker/features/forum/domain/entities/forum_post.dart';
import 'package:fit_tracker/features/forum/presentation/controllers/post_detail_controller.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/comment_thread.dart';
import '../widgets/loading_view.dart';
import '../widgets/reply_box.dart';

class PostDetailPage extends StatefulWidget {
  final int postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late final PostDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = PostDetailController(widget.postId);
    controller.loadPost();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Post Detail"),
        backgroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: AppColors.secondaryPurple,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: AppColors.secondaryPurple),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: controller.isLoading,
        builder: (_, loading, __) {
          if (loading) return const LoadingView();

          // Show error message if any
          if (controller.errorMessage.value != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadPost,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final post = controller.post.value;
          if (post == null) {
            return const Center(child: Text('Post not found'));
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HEADER
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(post.author.avatarUrl),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              post.author.name,
                              style: const TextStyle(
                                color: AppColors.secondaryPurple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        post.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.secondaryPurple,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        post.content,
                        style: const TextStyle(color: AppColors.grayDark),
                      ),
                      const SizedBox(height: 12),

                      // TAGS
                      Wrap(
                        spacing: 8,
                        children: post.tags
                            .map(
                              (tag) => Chip(
                                label: Text(
                                  '#$tag',
                                  style: const TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                                backgroundColor: AppColors.secondaryPurple,
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 16),

                      // ACTIONS
                      ValueListenableBuilder<ForumPost?>(
                        valueListenable: controller.post,
                        builder: (context, post, _) {
                          if (post == null) return const SizedBox();

                          return Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  post.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppColors.secondaryPurple,
                                ),
                                onPressed: controller.onLikePost,
                              ),
                              const SizedBox(width: 16),
                              const Icon(Icons.comment_outlined,
                                  color: AppColors.secondaryPurple),
                              const Spacer(),
                              IconButton(
                                icon: Icon(
                                  controller.post.value?.isShared == true
                                      ? Icons
                                          .share // or use a filled share icon if you have one
                                      : Icons.share_outlined,
                                ),
                                color: AppColors.secondaryPurple,
                                onPressed: controller.onSharePost,
                              ),
                            ],
                          );
                        },
                      ),

                      const Divider(height: 32),

                      // REPLY BOX (only for post)
                      ValueListenableBuilder<Comment?>(
                        valueListenable: controller.replyToComment,
                        builder: (_, replyTo, __) {
                          if (replyTo != null) {
                            return const SizedBox.shrink();
                          }
                          return ReplyBox(
                            controller: controller,
                            forPost: true,
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // COMMENTS
                      Text(
                        'Comments',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.brandPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12),

                      ValueListenableBuilder<List<Comment>>(
                        valueListenable: controller.comments,
                        builder: (_, comments, __) {
                          if (comments.isEmpty) {
                            return const Text('No comments yet');
                          }

                          return Column(
                            children: comments
                                .map(
                                  (c) => CommentThread(
                                    comment: c,
                                    controller: controller,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
