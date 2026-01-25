import '../domain/entities/daily_goal_instance.dart';

final mockTodayGoals = [
  DailyGoalInstance(
    id: '1',
    title: 'Walk',
    metricType: GoalMetricType.duration,
    targetValue: 30,
    unit: 'min',
  ),
  DailyGoalInstance(
    id: '2',
    title: 'Drink Water',
    metricType: GoalMetricType.volume,
    targetValue: 2000,
    unit: 'ml',
  ),
  DailyGoalInstance(
    id: '3',
    title: 'Meditate',
    metricType: GoalMetricType.binary,
    targetValue: 1,
    unit: '',
  ),

  DailyGoalInstance(
    id: '4',
    title: 'Run',
    metricType: GoalMetricType.distance,
    targetValue: 5,
    unit: 'km',
  ),

  DailyGoalInstance(
    id: '5',
    title: 'Drink Water',
    metricType: GoalMetricType.volume,
    targetValue: 2,
    unit: 'L',
  ),

];


