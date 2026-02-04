import '../../domain/entities/daily_goal_instance.dart';
import '../../domain/entities/goal.dart';
import '../../domain/repositories/goals_repository.dart';
import '../../domain/usecases/create_goal_params.dart';
import '../data_sources/goals_remote_datasource.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsRemoteDatasource remoteDatasource;

  GoalsRepositoryImpl(this.remoteDatasource);

  @override
  @override
  Future<List<Goal>> getGoals(int userId) async {
    final models = await remoteDatasource.getGoals(userId);
    return models.map<Goal>((m) => m).toList();
  }


  @override
  Future<Goal> createGoal(CreateGoalParams params) async {
    final model = await remoteDatasource.createGoal(params);
    return model;
  }

  @override
  Future<List<DailyGoalInstance>> getTodayDailyGoals(int userId) async {
    final models = await remoteDatasource.getTodayDailyGoals(userId);
    return models.map<DailyGoalInstance>((m) => m).toList();
  }


  @override
  Future<DailyGoalInstance> incrementDailyGoal(int id, num value) async {
    final model = await remoteDatasource.increment(id, value);
    return model;
  }

  @override
  Future<DailyGoalInstance> decrementDailyGoal(int id, num value) async {
    final model = await remoteDatasource.decrement(id, value);
    return model;
  }

  @override
  Future<Goal> toggleGoal(int goalId, int userId) async {
    final model = await remoteDatasource.toggleGoal(goalId, userId);
    return model;
  }


  @override
  Future<void> deleteGoal(int goalId, int userId) {
    return remoteDatasource.deleteGoal(goalId, userId);
  }
  @override
  Future<DailyGoalInstance> toggleDailyInstance(int instanceId) {
    return remoteDatasource.toggleDailyInstance(instanceId);
  }


}
