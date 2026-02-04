import 'forum_user.dart';

class ForumPost {
  final int id;
  final String title;
  final String content;

  final ForumUser author;
  final String category;
  final List<String> tags;

  final bool isPinned;
  final bool isHot;

  final bool isLiked;
  final bool isShared;
  final int likes;
  final int shares; // ✅ Added shares

  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActivityAt;

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.tags,
    this.isPinned = false,
    this.isHot = false,
    this.isLiked = false,
    this.isShared = false,
    this.likes = 0,
    this.shares = 0, // ✅ Added default shares
    required this.createdAt,
    this.updatedAt,
    this.lastActivityAt,
  });

  ForumPost copyWith({
    int? id,
    String? title,
    String? content,
    ForumUser? author,
    String? category,
    List<String>? tags,
    bool? isPinned,
    bool? isHot,
    bool? isLiked,
    bool? isShared,
    int? likes,
    int? shares, // ✅ Added shares
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActivityAt,
  }) {
    return ForumPost(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isPinned: isPinned ?? this.isPinned,
      isHot: isHot ?? this.isHot,
      isLiked: isLiked ?? this.isLiked,
      isShared: isShared ?? this.isShared,
      likes: likes ?? this.likes,
      shares: shares ?? this.shares, // ✅ Added shares
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
    );
  }

  factory ForumPost.fromJson(Map<String, dynamic> json) {
    return ForumPost(
      id: json['id'],
      title: json['title'] as String,
      content: json['content'] as String,
      author: ForumUser.fromJson(json['author'] as Map<String, dynamic>),
      category: json['category'] as String,
      tags: List<String>.from(json['tags'] as List<dynamic>? ?? []),
      isPinned: json['isPinned'] as bool? ?? false,
      isHot: json['isHot'] as bool? ?? false,
      isLiked: json['isLiked'] as bool? ?? false,
      isShared: json['isShared'] as bool? ?? false,
      likes: json['likes'] as int? ?? 0,
      shares: json['shares'] as int? ?? 0, // ✅ Added shares
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : null,
      lastActivityAt: json['lastActivityAt'] != null
          ? DateTime.parse(json['lastActivityAt'].toString())
          : null,
    );
  }
}
