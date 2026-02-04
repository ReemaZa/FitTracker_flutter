class PostStats {
  final int likes;
  final int comments;
  final int saves;
  final int views;

  PostStats({
    this.likes = 0,
    this.comments = 0,
    this.saves = 0,
    this.views = 0,
  });

  PostStats copyWith({int? likes, int? comments, int? saves, int? views}) {
    return PostStats(
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      saves: saves ?? this.saves,
      views: views ?? this.views,
    );
  }

  factory PostStats.fromJson(Map<String, dynamic> json) {
    return PostStats(
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      saves: json['saves'] as int? ?? 0,
      views: json['views'] as int? ?? 0,
    );
  }
}
