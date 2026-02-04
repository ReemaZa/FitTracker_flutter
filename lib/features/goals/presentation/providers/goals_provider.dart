import 'package:flutter/material.dart';
import '../../domain/entities/daily_goal_instance.dart';
import '../../domain/entities/goal.dart';
import '../../domain/usecases/create_goal.dart';
import '../../domain/usecases/create_goal_params.dart';
import '../../domain/usecases/decrement_daily_goal.dart';
import '../../domain/usecases/delete_goal.dart';
import '../../domain/usecases/get_daily_goals.dart';
import '../../domain/usecases/get_today_daily_goals.dart';
import '../../domain/usecases/increment_daily_goal.dart';
import '../../domain/usecases/toggle_daily_goal_instance.dart';
import '../../domain/usecases/toggle_goal.dart';

class GoalsProvider extends ChangeNotifier {
  final GetGoals getGoals;
  final CreateGoal createGoal;
  final ToggleGoal toggleGoal;
  final DeleteGoal deleteGoal;
  // 👇 ADD THESE
  final GetTodayDailyGoals getTodayDailyGoals;
  final IncrementDailyGoal incrementDailyGoal;
  final DecrementDailyGoal decrementDailyGoal;
  final ToggleDailyGoalInstance toggleDailyGoalInstance;

  GoalsProvider(this.getGoals,
      this.createGoal,
      this.getTodayDailyGoals,
      this.incrementDailyGoal,
      this.decrementDailyGoal,
      this.toggleGoal,
      this.deleteGoal,
      this.toggleDailyGoalInstance,
      );

  List<Goal> _goals = [];
  bool _isLoading = false;
  List<DailyGoalInstance> _todayGoals = [];
  bool _todayLoading = false;

  List<Goal> get goals => _goals;

  bool get isLoading => _isLoading;

  List<DailyGoalInstance> get todayGoals => _todayGoals;

  bool get isTodayLoading => _todayLoading;

  Future<void> loadGoals() async {
    _isLoading = true;
    notifyListeners();

    try {
      _goals = await getGoals(1); // 👈 userId = 1 (temporary)
    } catch (e) {
      _goals = [];
    }

    _isLoading = false;
    notifyListeners();
  }


  Future<void> addGoal(CreateGoalParams params) async {
    try {
      final newGoal = await createGoal(params);
      _goals.insert(0, newGoal);
      notifyListeners();
      await loadTodayGoals();

    } catch (e) {
      rethrow;
    }
  }

  Future<void> loadTodayGoals() async {
    _todayLoading = true;
    notifyListeners();

    _todayGoals = await getTodayDailyGoals(1);

    _todayLoading = false;
    notifyListeners();
  }

  Future<void> incrementToday(DailyGoalInstance goal, num value) async {
    final updated = await incrementDailyGoal(goal.id, value);
    _replaceToday(updated);
  }

  Future<void> decrementToday(DailyGoalInstance goal, num value) async {
    final updated = await decrementDailyGoal(goal.id, value);
    _replaceToday(updated);
  }

  void _replaceToday(DailyGoalInstance updated) {
    final i = _todayGoals.indexWhere((g) => g.id == updated.id);
    if (i != -1) {
      _todayGoals[i] = updated;
      notifyListeners();
    }
  }

  Future<void> toggle(int goalId) async {
    final index = _goals.indexWhere((g) => g.id == goalId);
    if (index == -1) return;

    // optimistic UI
    _goals[index] = _goals[index].copyWith(
      isActive: !_goals[index].isActive,
    );
    notifyListeners();

    final updated = await toggleGoal(goalId, 1);
    _goals[index] = updated;
    notifyListeners();
    await loadTodayGoals();
  }

  Future<void> remove(int goalId) async {
    _goals.removeWhere((g) => g.id == goalId);
    notifyListeners();

    await deleteGoal(goalId, 1);
    await loadTodayGoals();

  }

  Future<void> toggleBinaryDailyGoal(DailyGoalInstance instance) async {
    final index = _todayGoals.indexWhere((g) => g.id == instance.id);
    if (index == -1) return;

    // optimistic UI
    final current = _todayGoals[index];
    _todayGoals[index] = DailyGoalInstance(
      id: current.id,
      title: current.title,
      metricType: current.metricType,
      targetValue: current.targetValue,
      unit: current.unit,
      completedValue: current.isCompleted ? 0 : 1,
      isCompleted: !current.isCompleted,
    );
    notifyListeners();

    try {
      final updated =
      await toggleDailyGoalInstance(instance.id);
      _todayGoals[index] = updated;
      notifyListeners();
    } catch (e) {
      _todayGoals[index] = current;
      notifyListeners();
      rethrow;
    }
  }


}