import 'package:flutter/material.dart';
import '../controllers/post_detail_controller.dart';
import 'package:fit_tracker/core/theme/app_colors.dart';

class ReplyBox extends StatelessWidget {
  final PostDetailController controller;
  final bool forPost; // true when replying to post, false for comment

  const ReplyBox({super.key, required this.controller, this.forPost = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!forPost)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: controller.replyToComment,
                    builder: (_, value, __) {
                      final name = value?.author.name ?? '';
                      return Text('Replying to @$name',
                          style: const TextStyle(
                              color: AppColors.secondaryPurple,
                              fontWeight: FontWeight.w600));
                    },
                  ),
                ),
                IconButton(
                  icon:
                      const Icon(Icons.close, color: AppColors.secondaryPurple),
                  onPressed: controller.onCancelReply,
                ),
              ],
            ),
          ),
        TextField(
          controller: controller.commentTextController,
          focusNode: controller.commentFocusNode,
          maxLines: forPost ? 4 : 3,
          decoration: InputDecoration(
            hintText: forPost ? 'Share your thoughts...' : 'Write a reply...',
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.grayLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.secondaryPurple,
                width: 2,
              ),
            ),
          ),
          onChanged: (_) {},
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.secondaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ValueListenableBuilder<bool>(
                  valueListenable: controller.canSubmit,
                  builder: (_, can, __) {
                    return ElevatedButton(
                      onPressed: can
                          ? () async {
                              await controller.onSubmitComment();
                              // Show error if any
                              if (controller.errorMessage.value != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        controller.errorMessage.value ?? ''),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: controller.isSubmitting,
                        builder: (_, submitting, __) {
                          return Text(
                            submitting
                                ? 'Posting...'
                                : (forPost ? 'Post' : 'Reply'),
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            if (!forPost) const SizedBox(width: 8),
            if (!forPost)
              OutlinedButton(
                onPressed: controller.onCancelReply,
                child: const Text('Cancel'),
              ),
          ],
        ),
      ],
    );
  }
}
