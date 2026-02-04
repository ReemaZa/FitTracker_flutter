import '../entities/daily_goal_instance.dart';
import '../entities/goal.dart';
import '../usecases/create_goal_params.dart';

abstract class GoalsRepository {
  Future<List<Goal>> getGoals(int userId);
  Future<Goal> createGoal(CreateGoalParams params);
  Future<List<DailyGoalInstance>> getTodayDailyGoals(int userId);
  Future<DailyGoalInstance> incrementDailyGoal(int instanceId, num value);
  Future<DailyGoalInstance> decrementDailyGoal(int instanceId, num value);
  Future<Goal> toggleGoal(int goalId, int userId);
  Future<void> deleteGoal(int goalId, int userId);
  Future<DailyGoalInstance> toggleDailyInstance(int instanceId);

}
