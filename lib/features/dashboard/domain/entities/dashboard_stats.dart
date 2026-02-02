class DashboardStats {
  final int totalWorkouts;
  final double totalCalories;
  final double totalDistance;
  final double totalDuration;

  DashboardStats({
    required this.totalWorkouts,
    required this.totalCalories,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalWorkouts: json['totalWorkouts'] ?? 0,
      totalCalories: (json['totalCalories'] ?? 0).toDouble(),
      totalDistance: (json['totalDistance'] ?? 0).toDouble(),
      totalDuration: (json['totalDuration'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalWorkouts': totalWorkouts,
      'totalCalories': totalCalories,
      'totalDistance': totalDistance,
      'totalDuration': totalDuration,
    };
  }
}
