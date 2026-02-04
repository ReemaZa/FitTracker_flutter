import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'data/data_sources/goals_remote_datasource.dart';
import 'data/repositories/goals_repository_impl.dart';

// use cases
import 'domain/usecases/create_goal.dart';
import 'domain/usecases/delete_goal.dart';
import 'domain/usecases/get_daily_goals.dart';
import 'domain/usecases/get_today_daily_goals.dart';

import 'domain/usecases/increment_daily_goal.dart';
import 'domain/usecases/decrement_daily_goal.dart';

// provider
import 'domain/usecases/toggle_daily_goal_instance.dart';
import 'domain/usecases/toggle_goal.dart';
import 'presentation/providers/goals_provider.dart';

final List<ChangeNotifierProvider> goalsProviders = [
  ChangeNotifierProvider<GoalsProvider>(
    create: (_) {
      final client = http.Client();
      final datasource = GoalsRemoteDatasourceImpl(client);
      final repository = GoalsRepositoryImpl(datasource);

      final getGoals = GetGoals(repository);
      final createGoal = CreateGoal(repository);
      final getTodayDailyGoals = GetTodayDailyGoals(repository);
      final incrementDailyGoal = IncrementDailyGoal(repository);
      final decrementDailyGoal = DecrementDailyGoal(repository);
      final toggleGoal = ToggleGoal(repository);
      final deleteGoal = DeleteGoal(repository);
      final toggleDailyGoalInstance = ToggleDailyGoalInstance(repository);
      return GoalsProvider(
        getGoals,
        createGoal,
        getTodayDailyGoals,
        incrementDailyGoal,
        decrementDailyGoal,
        toggleGoal,
        deleteGoal,
          toggleDailyGoalInstance,
      )..loadGoals();
    },
  ),
];
