import '../entities/goal.dart';
import '../repositories/goals_repository.dart';
import 'create_goal_params.dart';

class CreateGoal {
  final GoalsRepository repository;

  CreateGoal(this.repository);

  Future<Goal> call(CreateGoalParams params) {
    return repository.createGoal(params);
  }
}
