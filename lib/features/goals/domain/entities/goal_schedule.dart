enum GoalFrequencyType {
  daily,
  weekly,
}

class GoalSchedule {
  final GoalFrequencyType frequencyType;
  final List<int> daysOfWeek;

  const GoalSchedule({
    required this.frequencyType,
    required this.daysOfWeek,
  });
}
