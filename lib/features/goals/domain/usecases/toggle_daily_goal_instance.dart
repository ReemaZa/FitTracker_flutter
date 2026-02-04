import '../entities/daily_goal_instance.dart';
import '../repositories/goals_repository.dart';

class ToggleDailyGoalInstance {
  final GoalsRepository repository;

  ToggleDailyGoalInstance(this.repository);

  Future<DailyGoalInstance> call(int instanceId) {
    return repository.toggleDailyInstance(instanceId);
  }
}
