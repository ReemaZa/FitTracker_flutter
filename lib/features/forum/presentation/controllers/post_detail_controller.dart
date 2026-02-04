import 'dart:async';
import 'dart:collection';
import 'package:fit_tracker/features/forum/data/datasources/mock_forum.dart';
import 'package:fit_tracker/features/forum/data/datasources/forum_api_service.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/forum_post.dart';
import '../../domain/entities/comment.dart';

class PostDetailController {
  final int postId;
  final currentUserId = 1;
  final post = ValueNotifier<ForumPost?>(null);
  final comments = ValueNotifier<List<Comment>>([]);
  final isLoading = ValueNotifier<bool>(true);
  final isSubmitting = ValueNotifier<bool>(false);
  final errorMessage = ValueNotifier<String?>(null);

  final replyToComment = ValueNotifier<Comment?>(null);
  final commentTextController = TextEditingController();
  final commentFocusNode = FocusNode();

  /// Indicates whether the comment can be submitted (non-empty & not submitting)
  final canSubmit = ValueNotifier<bool>(false);

  final ForumApiService _apiService = ForumApiService();
  bool useApiServer = true; // Set to true to use API, false for mock data

  PostDetailController(this.postId) {
    commentTextController.addListener(_updateCanSubmit);
    isSubmitting.addListener(_updateCanSubmit);
    replyToComment.addListener(_onReplyTargetChanged);
  }

  void _updateCanSubmit() {
    final enabled =
        commentTextController.text.trim().isNotEmpty && !isSubmitting.value;
    if (canSubmit.value != enabled) canSubmit.value = enabled;
  }

  void _onReplyTargetChanged() {
    final target = replyToComment.value;
    if (target != null) {
      final pre = '@${target.author.name} ';
      commentTextController.text = pre;
      commentTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: commentTextController.text.length));
      commentFocusNode.requestFocus();
    }
    _updateCanSubmit();
  }

  void dispose() {
    commentTextController.removeListener(_updateCanSubmit);
    isSubmitting.removeListener(_updateCanSubmit);
    replyToComment.removeListener(_onReplyTargetChanged);
    commentTextController.dispose();
    commentFocusNode.dispose();
    canSubmit.dispose();
    errorMessage.dispose();
    post.dispose();
    comments.dispose();
    isLoading.dispose();
    isSubmitting.dispose();
  }

  bool get canSubmitComment =>
      commentTextController.text.trim().isNotEmpty && !isSubmitting.value;

  Future<void> loadPost() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      if (useApiServer) {
        // Call real API
        final mockPost = await _apiService.fetchPostById(postId);
        final mockComments = await _apiService.fetchComments(postId);
        post.value = mockPost;
        comments.value = mockComments;
      } else {
        // Use mock data
        await Future.delayed(const Duration(milliseconds: 500));
        final mockPost = MockForum.getPost(postId);
        final mockComments = MockForum.getCommentsForPost(postId);
        post.value = mockPost;
        comments.value = mockComments;
      }
      errorMessage.value = null;
    } on ForumApiException catch (e) {
      errorMessage.value = e.message;
      debugPrint('Load post error: ${e.message}');
    } catch (e) {
      errorMessage.value = 'Failed to load post';
      debugPrint('Load post error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<Comment> insertReplyBFS({
    required List<Comment> comments,
    required Comment newComment,
  }) {
    final List<Comment> updated = [];
    final Queue<Comment> queue = Queue();

    // Copie initiale
    for (final c in comments) {
      queue.add(c);
      updated.add(c);
    }

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();

      // 🎯 Parent trouvé
      if (current.id == newComment.parentCommentId) {
        final updatedReplies = [...current.replies, newComment];

        // Remplacer le parent dans l’arbre
        _replaceComment(
          updated,
          current.id,
          current.copyWith(replies: updatedReplies),
        );
        break;
      }

      // Continuer BFS
      for (final reply in current.replies) {
        queue.add(reply);
      }
    }

    return updated;
  }

  void _replaceComment(
    List<Comment> comments,
    int targetId,
    Comment updatedComment,
  ) {
    for (int i = 0; i < comments.length; i++) {
      if (comments[i].id == targetId) {
        comments[i] = updatedComment;
        return;
      }

      if (comments[i].replies.isNotEmpty) {
        _replaceComment(comments[i].replies, targetId, updatedComment);
      }
    }
  }

  void onCancelReply() {
    replyToComment.value = null;
  }

  void onLikePost() {
    final p = post.value;
    if (p == null) return;

    // Toggle isLiked
    final liked = !p.isLiked;

    // Update likes count accordingly
    final newLikes =
        liked ? (p.likes + 1) : (p.likes - 1).clamp(0, double.infinity).toInt();

    post.value = p.copyWith(
      isLiked: liked,
      likes: newLikes,
    );
  }

  void onSharePost() {
    final p = post.value;
    if (p == null) return;

    // Toggle isShared
    final shared = !p.isShared;

    // Optionally increase/decrease a shares count
    final newShares = shared
        ? ((p.shares ?? 0) + 1)
        : ((p.shares ?? 1) - 1).clamp(0, double.infinity).toInt();

    post.value = p.copyWith(
      isShared: shared,
      shares: newShares,
    );
  }

  // Optional: implement platform share sheet
  // e.g., using 'share_plus' package: Share.share(p.content);

  /// Organize flat comments into threads
  List<Comment> organizeCommentsIntoThreads() {
    final map = {for (var c in comments.value) c.id: c.copyWith(replies: [])};
    final roots = <Comment>[];

    for (var c in comments.value) {
      if (c.parentCommentId != null) {
        final parent = map[c.parentCommentId!];
        parent?.replies.add(map[c.id]!);
      } else {
        roots.add(map[c.id]!);
      }
    }
    return roots;
  }

  void toggleSolution(int commentId) {
    // BFS search to find the comment and toggle `isSolution`
    final updatedComments = comments.value.map((c) {
      return _toggleSolutionRecursive(c, commentId);
    }).toList();

    comments.value = updatedComments;
  }

  Comment _toggleSolutionRecursive(Comment comment, int targetId) {
    if (comment.id == targetId) {
      // Toggle isSolution
      return comment.copyWith(isSolution: !comment.isSolution);
    }

    if (comment.replies.isNotEmpty) {
      final updatedReplies = comment.replies
          .map((reply) => _toggleSolutionRecursive(reply, targetId))
          .toList();
      return comment.copyWith(replies: updatedReplies);
    }

    return comment;
  }

  Future<void> onSubmitComment() async {
    if (!canSubmitComment || post.value == null) return;

    isSubmitting.value = true;
    errorMessage.value = null;

    try {
      if (useApiServer) {
        // Call real API
        final newCommentModel = await _apiService.submitComment(
          postId: post.value!.id,
          content: commentTextController.text,
          parentCommentId: replyToComment.value?.id,
          userId: currentUserId,
        );

        // Map CommentModel -> Comment entity
        final newComment = Comment(
          id: newCommentModel.id,
          content: newCommentModel.content,
          author: newCommentModel.author, // ensure type matches Comment.author
          postId: newCommentModel.postId,
          parentCommentId: newCommentModel.parentCommentId,
          createdAt: newCommentModel.createdAt,
          likes: newCommentModel.likes,
          isSolution: newCommentModel.isSolution,
          replies: [],
        );

        // Insert reply or top-level comment
        if (newComment.parentCommentId != null) {
          comments.value = insertReplyBFS(
            comments: comments.value,
            newComment: newComment,
          );
        } else {
          comments.value = [...comments.value, newComment];
        }
      } else {
        // Mock submission
        final newComment = Comment(
          id: DateTime.now().millisecondsSinceEpoch,
          content: commentTextController.text,
          author: MockForum.currentUser,
          postId: post.value!.id,
          parentCommentId: replyToComment.value?.id,
          createdAt: DateTime.now(),
          likes: 0,
          isSolution: false,
          replies: [],
        );

        if (newComment.parentCommentId != null) {
          comments.value = insertReplyBFS(
            comments: comments.value,
            newComment: newComment,
          );
        } else {
          comments.value = [newComment, ...comments.value];
        }
      }

      // Clear input & reply target
      commentTextController.clear();
      replyToComment.value = null;
      errorMessage.value = null;
    } on ForumApiException catch (e) {
      errorMessage.value = e.message;
      debugPrint('Submit comment error: ${e.message}');
    } catch (e) {
      errorMessage.value = 'Failed to submit comment';
      debugPrint('Submit comment error: $e');
    } finally {
      isSubmitting.value = false;
    }
  }
}
