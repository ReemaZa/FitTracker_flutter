import '../entities/daily_goal_instance.dart';
import '../repositories/goals_repository.dart';

class IncrementDailyGoal {
  final GoalsRepository repository;

  IncrementDailyGoal(this.repository);

  Future<DailyGoalInstance> call(int id, num value) {
    return repository.incrementDailyGoal(id, value);
  }
}
