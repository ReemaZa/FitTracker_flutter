import '../entities/goal.dart';
import '../repositories/goals_repository.dart';

class ToggleGoal {
  final GoalsRepository repository;

  ToggleGoal(this.repository);

  Future<Goal> call(int goalId, int userId) {
    return repository.toggleGoal(goalId, userId);
  }
}
