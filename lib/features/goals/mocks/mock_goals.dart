import '../domain/entities/goal.dart';

final mockGoals = [
  Goal(
    id: '1',
    title: 'Walk',
    description: 'Daily walking goal',
    type: GoalType.walking,
    targetValue: 30,
    unit: 'min',
    isActive: true,
  ),
  Goal(
    id: '2',
    title: 'Drink water',
    description: 'Stay hydrated',
    type: GoalType.water,
    targetValue: 1000,
    unit: 'ml',
    isActive: true,
  ),
  Goal(
    id: '3',
    title: 'Meditation',
    description: 'Mindfulness session',
    type: GoalType.custom,
    targetValue: 1,
    unit: 'session',
    isActive: false,
  ),
];
