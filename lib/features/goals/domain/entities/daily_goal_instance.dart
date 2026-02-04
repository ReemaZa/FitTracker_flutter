// domain/entities/daily_goal_instance.dart
import 'goal.dart';

class DailyGoalInstance {
  final int id;
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
    required this.completedValue,
    required this.isCompleted,
  });
}
