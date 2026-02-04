import '../../domain/entities/goal.dart';
import 'goal_schedule_model.dart';

class GoalModel extends Goal {
  GoalModel({
    required super.id,
    required super.title,
    required super.description,
    required super.goalType,
    required super.metricType,
    required super.targetValue,
    required super.unit,
    required super.isActive,
    required super.schedule,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      goalType: GoalTypeX.fromString(json['goalType']),
      metricType: MetricTypeX.fromString(json['metricType']),
      targetValue: json['targetValue'],
      unit: json['unit'],
      isActive: json['isActive'],
      schedule: GoalScheduleModel.fromJson(json['schedule']),
    );
  }

}
