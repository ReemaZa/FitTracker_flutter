class WeeklyData {
  final String date;
  final int workouts;
  final double calories;
  final double distance;
  final double duration;

  WeeklyData({
    required this.date,
    required this.workouts,
    required this.calories,
    required this.distance,
    required this.duration,
  });

  factory WeeklyData.fromJson(Map<String, dynamic> json) {
    return WeeklyData(
      date: json['date'] ?? '',
      workouts: json['workouts'] ?? 0,
      calories: (json['calories'] ?? 0).toDouble(),
      distance: (json['distance'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'workouts': workouts,
      'calories': calories,
      'distance': distance,
      'duration': duration,
    };
  }
}
