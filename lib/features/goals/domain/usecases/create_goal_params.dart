class CreateGoalParams {
  final String title;
  final String description;
  final String goalType;
  final String metricType;
  final num targetValue;
  final String unit;
  final DateTime? startDate;
  final DateTime? endDate;
  final String frequencyType;
  final List<int> daysOfWeek;

  CreateGoalParams({
    required this.title,
    required this.description,
    required this.goalType,
    required this.metricType,
    required this.targetValue,
    required this.unit,
    this.startDate,
    this.endDate,
    required this.frequencyType,
    required this.daysOfWeek,
  });
}
