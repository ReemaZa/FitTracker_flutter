import '../entities/daily_goal_instance.dart';
import '../repositories/goals_repository.dart';

class GetTodayDailyGoals {
  final GoalsRepository repository;

  GetTodayDailyGoals(this.repository);

  Future<List<DailyGoalInstance>> call(int userId) {
    return repository.getTodayDailyGoals(userId);
  }
}
