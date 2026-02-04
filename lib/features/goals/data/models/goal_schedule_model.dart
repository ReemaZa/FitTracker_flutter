import '../../domain/entities/goal_schedule.dart';

class GoalScheduleModel extends GoalSchedule {
  const GoalScheduleModel({
    required super.frequencyType,
    required super.daysOfWeek,
  });

  factory GoalScheduleModel.fromJson(Map<String, dynamic> json) {
    return GoalScheduleModel(
      frequencyType: GoalFrequencyType.values.firstWhere(
            (e) => e.name == json['frequencyType'],
      ),
      daysOfWeek: List<int>.from(json['daysOfWeek'] ?? []),
    );
  }
}
