import '../repositories/goals_repository.dart';

class DeleteGoal {
  final GoalsRepository repository;

  DeleteGoal(this.repository);

  Future<void> call(int goalId, int userId) {
    return repository.deleteGoal(goalId, userId);
  }
}
