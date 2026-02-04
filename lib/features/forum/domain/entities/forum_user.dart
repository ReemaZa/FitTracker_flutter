class ForumUser {
  final int id;
  final String name;
  final String avatarUrl;
  final int level;
  final List<String> badges;

  ForumUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.level = 1,
    this.badges = const [],
  });

  factory ForumUser.fromJson(Map<String, dynamic> json) {
    return ForumUser(
      id: json['id'],
      name: json['name'] as String,
      avatarUrl: json['avatarUrl']?.toString() ?? '',
      level: json['level'] as int? ?? 1,
      badges: List<String>.from(json['badges'] as List<dynamic>? ?? []),
    );
  }
}
