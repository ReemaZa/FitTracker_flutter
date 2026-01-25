enum GoalMetricType {
  duration,
  count,
  volume,
  binary,
  distance,
}

class DailyGoalInstance {
  final String id;
  final String title;
  final GoalMetricType metricType;
  final double targetValue;
  final String unit;

  double completedValue;
  bool isCompleted;

  DailyGoalInstance({
    required this.id,
    required this.title,
    required this.metricType,
    required this.targetValue,
    required this.unit,
    this.completedValue = 0,
    this.isCompleted = false,
  });
}
