import '../entities/daily_goal_instance.dart';
import '../repositories/goals_repository.dart';

class DecrementDailyGoal {
  final GoalsRepository repository;

  DecrementDailyGoal(this.repository);

  Future<DailyGoalInstance> call(int id, num value) {
    return repository.decrementDailyGoal(id, value);
  }
}
