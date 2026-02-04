import '../../domain/entities/forum_post.dart';
import '../../domain/entities/forum_user.dart';

class ForumPostModel extends ForumPost {
  ForumPostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.author,
    required super.category,
    required super.tags,
    super.isPinned,
    super.isHot,
    super.isLiked,
    super.isShared,
    super.likes,
    super.shares, // ✅ Added shares
    required super.createdAt,
    super.updatedAt,
    super.lastActivityAt,
  });

  factory ForumPostModel.fromJson(Map<String, dynamic> json) {
    return ForumPostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      isPinned: json['isPinned'] as bool? ?? false,
      isHot: json['isHot'] as bool? ?? false,
      isLiked: json['isLiked'] as bool? ?? false,
      isShared: json['isShared'] as bool? ?? false,
      likes: json['likes'] as int? ?? 0,
      shares: json['shares'] as int? ?? 0, // ✅ Added shares
      author: ForumUser(
        id: json['author']['id'],
        name: json['author']['nom'],
        avatarUrl:
            json['author']['avatarUrl'] ?? 'https://i.pravatar.cc/150?img=2',
      ),
      category: json['category'],
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      lastActivityAt: json['lastActivityAt'] != null
          ? DateTime.parse(json['lastActivityAt'])
          : null,
    );
  }
}
