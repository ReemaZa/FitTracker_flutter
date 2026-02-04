class DashboardSummary {
  final double averageWorkoutsPerDay;
  final double averageCaloriesPerDay;
  final double averageDistancePerDay;
  final double averageDurationPerDay;
  final int totalDays;

  DashboardSummary({
    required this.averageWorkoutsPerDay,
    required this.averageCaloriesPerDay,
    required this.averageDistancePerDay,
    required this.averageDurationPerDay,
    required this.totalDays,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      averageWorkoutsPerDay: (json['averageWorkoutsPerDay'] ?? 0).toDouble(),
      averageCaloriesPerDay: (json['averageCaloriesPerDay'] ?? 0).toDouble(),
      averageDistancePerDay: (json['averageDistancePerDay'] ?? 0).toDouble(),
      averageDurationPerDay: (json['averageDurationPerDay'] ?? 0).toDouble(),
      totalDays: json['totalDays'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageWorkoutsPerDay': averageWorkoutsPerDay,
      'averageCaloriesPerDay': averageCaloriesPerDay,
      'averageDistancePerDay': averageDistancePerDay,
      'averageDurationPerDay': averageDurationPerDay,
      'totalDays': totalDays,
    };
  }
}
