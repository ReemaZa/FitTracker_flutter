import '../../domain/entities/daily_goal_instance.dart';
import '../../domain/entities/goal.dart';

class DailyGoalInstanceModel extends DailyGoalInstance {
  DailyGoalInstanceModel({
    required super.id,
    required super.title,
    required super.metricType,
    required super.targetValue,
    required super.unit,
    required super.completedValue,
    required super.isCompleted,
  });

  factory DailyGoalInstanceModel.fromJson(Map<String, dynamic> json) {
    final goal = json['goal'];

    return DailyGoalInstanceModel(
      id: (json['id'] as num).toInt(),
      title: goal['title'],
      metricType: MetricTypeX.fromString(goal['metricType']),
      targetValue: (json['targetValue'] as num).toDouble(),
      unit: goal['unit'],
      completedValue: (json['completedValue'] as num).toDouble(),
      isCompleted: json['isCompleted'],
    );
  }
}
