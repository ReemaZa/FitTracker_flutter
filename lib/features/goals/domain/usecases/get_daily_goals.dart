import '../entities/goal.dart';
import '../repositories/goals_repository.dart';

class GetGoals {
  final GoalsRepository repository;

  GetGoals(this.repository);

  Future<List<Goal>> call(int userId) {
    return repository.getGoals(userId);
  }
}
