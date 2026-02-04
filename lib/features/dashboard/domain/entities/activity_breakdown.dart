class ActivityBreakdown {
  final String activityType;
  final int count;
  final double percentage;

  ActivityBreakdown({
    required this.activityType,
    required this.count,
    required this.percentage,
  });

  factory ActivityBreakdown.fromJson(Map<String, dynamic> json) {
    return ActivityBreakdown(
      activityType: json['activityType'] ?? '',
      count: json['count'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activityType': activityType,
      'count': count,
      'percentage': percentage,
    };
  }
}
