import 'daily_goal_instance.dart';

class GoalStepRules {
  static double stepFor({
    required GoalMetricType metricType,
    required String unit,
  }) {
    switch (metricType) {
      case GoalMetricType.duration:
        return _durationStep(unit);

      case GoalMetricType.volume:
        return _volumeStep(unit);

      case GoalMetricType.distance:
        return _distanceStep(unit);

      case GoalMetricType.count:
        return 1;

      case GoalMetricType.binary:
        return 1;
    }
  }

  // ---------------------------
  // Private helpers (clean)
  // ---------------------------

  static double _durationStep(String unit) {
    switch (unit) {
      case 'min':
        return 5;
      case 'hour':
        return 0.25; // 15 min
      default:
        return 1;
    }
  }

  static double _volumeStep(String unit) {
    switch (unit) {
      case 'ml':
        return 250;
      case 'L':
        return 0.25;
      default:
        return 1;
    }
  }

  static double _distanceStep(String unit) {
    switch (unit) {
      case 'm':
        return 100;
      case 'km':
        return 0.5;
      default:
        return 1;
    }
  }
}
