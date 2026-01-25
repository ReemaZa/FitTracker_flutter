enum GoalMetricType {
  duration,
  distance,
  volume,
  count,
  binary,
}

class GoalMetricConfig {
  static const Map<GoalMetricType, List<String>> units = {
    GoalMetricType.duration: ['minutes', 'hours'],
    GoalMetricType.distance: ['km', 'meters'],
    GoalMetricType.volume: ['ml', 'liters'],
    GoalMetricType.count: ['times'],
    GoalMetricType.binary: ['yes / no'],
  };

  static String label(GoalMetricType type) {
    switch (type) {
      case GoalMetricType.duration:
        return 'Duration';
      case GoalMetricType.distance:
        return 'Distance';
      case GoalMetricType.volume:
        return 'Volume';
      case GoalMetricType.count:
        return 'Count';
      case GoalMetricType.binary:
        return 'Binary';
    }
  }
}
