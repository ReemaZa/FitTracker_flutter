enum GoalType {
  walking,
  water,
  workout,
  custom,
}

class Goal {
  final String id;
  final String title;
  final String description;
  final GoalType type;
  final num targetValue;
  final String unit;
  final bool isActive;

  const Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.targetValue,
    required this.unit,
    required this.isActive,
  });
}
