import '../../domain/entities/comment.dart';
import '../../domain/entities/forum_user.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.id,
    required super.content,
    required super.author,
    required super.postId,
    super.parentCommentId,
    required super.createdAt,
    super.likes,
    super.isSolution,
    super.replies,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as int,
      content: json['content'],
      author: ForumUser(
        id: json['author']['id'],
        name: json['author']['nom'],
        avatarUrl: json['author']['avatarUrl'] ??
            json['author']['image'] ??
            'https://i.pravatar.cc/150?img=2',
      ),

      // ✅ CORRECTION ICI
      postId: json['postId'] ??
          (json['post'] != null ? json['post']['id'] as int : 0),

      // ✅ CORRECTION ICI
      parentCommentId: json['parentCommentId'] ??
          (json['parentComment'] != null
              ? json['parentComment']['id'] as int
              : null),

      createdAt: DateTime.parse(json['createdAt']),
      likes: json['likes'] ?? 0,
      isSolution: json['isSolution'] ?? false,

      // ❌ NE PAS TOUCHER
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
