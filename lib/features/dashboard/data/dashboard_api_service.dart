import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/entities/dashboard_stats.dart';
import '../domain/entities/weekly_data.dart';
import '../domain/entities/monthly_data.dart';
import '../domain/entities/activity_breakdown.dart';
import '../domain/entities/dashboard_summary.dart';

class DashboardApiService {
  final String baseUrl;

  DashboardApiService({this.baseUrl = 'http://localhost:3001/api/dashboard'});

  Future<DashboardStats> getStats() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/stats'));
      
      if (response.statusCode == 200) {
        return DashboardStats.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load stats: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching stats: $e');
    }
  }

  Future<List<WeeklyData>> getWeeklyData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/weekly'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => WeeklyData.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load weekly data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weekly data: $e');
    }
  }

  Future<List<MonthlyData>> getMonthlyData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/monthly'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => MonthlyData.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load monthly data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching monthly data: $e');
    }
  }

  Future<List<ActivityBreakdown>> getActivityBreakdown() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/activity-breakdown'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => ActivityBreakdown.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load activity breakdown: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching activity breakdown: $e');
    }
  }

  Future<DashboardSummary> getWeeklySummary() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/summary/weekly'));
      
      if (response.statusCode == 200) {
        return DashboardSummary.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load weekly summary: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weekly summary: $e');
    }
  }

  Future<DashboardSummary> getMonthlySummary() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/summary/monthly'));
      
      if (response.statusCode == 200) {
        return DashboardSummary.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load monthly summary: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching monthly summary: $e');
    }
  }
}
