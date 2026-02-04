import 'goal_schedule.dart';

enum GoalType { walking, water, workout, custom }
enum GoalMetricType { duration, count, volume, binary, distance }

class Goal {
  final int id;
  final String title;
  final String description;
  final GoalType goalType;
  final GoalMetricType metricType;
  final num targetValue;
  final String unit;
  final bool isActive;
  final GoalSchedule schedule;

  const Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.goalType,
    required this.metricType,
    required this.targetValue,
    required this.unit,
    required this.isActive,
    required this.schedule,
  });

  /// ✅ CORRECT copyWith
  Goal copyWith({
    int? id,
    String? title,
    String? description,
    GoalType? goalType,
    GoalMetricType? metricType,
    num? targetValue,
    String? unit,
    bool? isActive,
    GoalSchedule? schedule,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      goalType: goalType ?? this.goalType,
      metricType: metricType ?? this.metricType,
      targetValue: targetValue ?? this.targetValue,
      unit: unit ?? this.unit,
      isActive: isActive ?? this.isActive,
      schedule: schedule ?? this.schedule,
    );
  }
}

/// ---------- ENUM HELPERS ----------

extension GoalTypeX on GoalType {
  static GoalType fromString(String value) {
    return GoalType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => GoalType.walking,
    );
  }
}

extension MetricTypeX on GoalMetricType {
  static GoalMetricType fromString(String value) {
    return GoalMetricType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => GoalMetricType.duration,
    );
  }
}
