class MonthlyData {
  final String week;
  final int workouts;
  final double calories;
  final double distance;
  final double duration;

  MonthlyData({
    required this.week,
    required this.workouts,
    required this.calories,
    required this.distance,
    required this.duration,
  });

  factory MonthlyData.fromJson(Map<String, dynamic> json) {
    return MonthlyData(
      week: json['week'] ?? '',
      workouts: json['workouts'] ?? 0,
      calories: (json['calories'] ?? 0).toDouble(),
      distance: (json['distance'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'week': week,
      'workouts': workouts,
      'calories': calories,
      'distance': distance,
      'duration': duration,
    };
  }
}
