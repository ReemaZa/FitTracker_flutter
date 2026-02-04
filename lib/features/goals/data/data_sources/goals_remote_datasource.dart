import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/goal.dart';
import '../../domain/usecases/create_goal_params.dart';
import '../models/daily_goal_instance_model.dart';
import '../models/goal_model.dart';

abstract class GoalsRemoteDatasource {
  Future<List<GoalModel>> getGoals(int userId);
  Future<GoalModel> createGoal(CreateGoalParams params);
  Future<List<DailyGoalInstanceModel>> getTodayDailyGoals(int userId);
  Future<DailyGoalInstanceModel> increment(int id, num value);
  Future<DailyGoalInstanceModel> decrement(int id, num value);
  Future<Goal> toggleGoal(int goalId, int userId);
  Future<void> deleteGoal(int goalId, int userId);
  Future<DailyGoalInstanceModel> toggleDailyInstance(int instanceId);

}

class GoalsRemoteDatasourceImpl implements GoalsRemoteDatasource {
  final http.Client client;

  GoalsRemoteDatasourceImpl(this.client);
  static const baseUrl = 'http://192.168.1.14:3001';

  @override
  Future<List<GoalModel>> getGoals(int userId) async {


    print("getting goalsllllll");


    try {
      final response = await client
          .get(
        Uri.parse('http://192.168.1.14:3001/goals'),
        headers: {
          'accept': '*/*',
          'x-user-id': userId.toString(),
        },
      )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List decoded = json.decode(response.body);
        print(decoded);
        return decoded.map((e) => GoalModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load goals');
      }
    } catch (e) {
      print('HTTP ERROR: $e');
      throw Exception('Network error');
    }




  }

  @override
  Future<GoalModel> createGoal(CreateGoalParams params) async {
    print('creating goal');
    final response = await client.post(
      Uri.parse('http://192.168.1.14:3001/goals'),
      headers: {
        'Content-Type': 'application/json',
        'x-user-id': '1',
      },
      body: jsonEncode({
        'title': params.title,
        'description': params.description,
        'goalType': params.goalType,
        'metricType': params.metricType,
        'targetValue': params.targetValue,
        'unit': params.unit,
        'startDate': params.startDate?.toIso8601String(),
        'endDate': params.endDate?.toIso8601String(),
        'frequencyType': params.frequencyType,
        'daysOfWeek': params.daysOfWeek,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {

      return GoalModel.fromJson(jsonDecode(response.body));
    } else {
      print('ressss');
      print(response);
      throw Exception('Failed to create goal');
    }
  }

  @override
  Future<List<DailyGoalInstanceModel>> getTodayDailyGoals(int userId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/goals/daily-goals/today'),
      headers: {'x-user-id': userId.toString()},
    );
  print("getting todayyyyyy daily goals ");
    final List decoded = jsonDecode(response.body);
    return decoded
        .map((e) => DailyGoalInstanceModel.fromJson(e))
        .toList();
  }

  @override
  Future<DailyGoalInstanceModel> increment(int id, num value) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/goals/instances/$id/increment'),
      headers: {
        'Content-Type': 'application/json',
        'x-user-id': '1',
      },
      body: jsonEncode({'value': value}),
    );

    return DailyGoalInstanceModel.fromJson(
      jsonDecode(response.body),
    );
  }

  @override
  Future<DailyGoalInstanceModel> decrement(int id, num value) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/goals/instances/$id/decrement'),
      headers: {
        'Content-Type': 'application/json',
        'x-user-id': '1',
      },
      body: jsonEncode({'value': value}),
    );

    return DailyGoalInstanceModel.fromJson(
      jsonDecode(response.body),
    );
  }

  @override
  Future<Goal> toggleGoal(int goalId, int userId) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/goals/$goalId/toggle'),
      headers: {
        'accept': '*/*',
        'x-user-id': userId.toString(),
      },
    );
    print('toggle goal callleeeeeeeeeeeeed');
    return GoalModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<void> deleteGoal(int goalId, int userId) async {
    await client.delete(
      Uri.parse('$baseUrl/goals/$goalId'),
      headers: {
        'accept': '*/*',
        'x-user-id': userId.toString(),
      },
    );
  }

  @override
  Future<DailyGoalInstanceModel> toggleDailyInstance(int instanceId) async {
    final response = await client.patch(
      Uri.parse('$baseUrl/goals/instances/$instanceId/toggle'),
      headers: {
        'accept': '*/*',
        'x-user-id': '1',
      },
    );

    if (response.statusCode == 200) {
      return DailyGoalInstanceModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to toggle daily goal instance');
    }
  }


}
