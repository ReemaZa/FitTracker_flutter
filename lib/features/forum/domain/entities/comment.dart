import 'forum_user.dart';

class Comment {
  final int id;
  final String content;
  final ForumUser author;
  final int postId;
  final int? parentCommentId;
  final DateTime createdAt;
  int likes;
  bool isSolution;
  List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.postId,
    this.parentCommentId,
    required this.createdAt,
    this.likes = 0,
    this.isSolution = false,
    this.replies = const [],
  });

  Comment copyWith({
    int? id,
    String? content,
    ForumUser? author,
    int? postId,
    int? parentCommentId,
    DateTime? createdAt,
    int? likes,
    bool? isSolution,
    List<Comment>? replies,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      author: author ?? this.author,
      postId: postId ?? this.postId,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      isSolution: isSolution ?? this.isSolution,
      replies: replies ?? this.replies,
    );
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'] as String,
      author: ForumUser.fromJson(json['author'] as Map<String, dynamic>),
      postId: json['postId'],
      parentCommentId:
          json['parentCommentId'] != null ? json['parentCommentId'] : null,
      createdAt: DateTime.parse(json['createdAt'].toString()),
      likes: json['likes'] as int? ?? 0,
      isSolution: json['isSolution'] as bool? ?? false,
      replies: json['replies'] != null
          ? List<Comment>.from(
              (json['replies'] as List<dynamic>).map(
                (reply) => Comment.fromJson(reply as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}
