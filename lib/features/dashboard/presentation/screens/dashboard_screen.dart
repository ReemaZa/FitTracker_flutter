import 'package:flutter/material.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/weekly_data.dart';
import '../../domain/entities/monthly_data.dart';
import '../../domain/entities/activity_breakdown.dart';
import '../../data/dashboard_api_service.dart';
import '../../mocks/mock_dashboard_data.dart';
import '../widgets/stat_card.dart';
import '../widgets/calories_line_chart.dart';
import '../widgets/workouts_bar_chart.dart';
import '../widgets/activity_doughnut_chart.dart';

enum DashboardView { weekly, monthly }

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardView _currentView = DashboardView.weekly;
  final DashboardApiService _apiService = DashboardApiService();
  final MockDashboardData _mockData = MockDashboardData();
  
  bool _isLoading = true;
  bool _useMockData = true; // Toggle this to use API or mock data
  String? _error;

  // Data
  DashboardStats? _stats;
  List<WeeklyData> _weeklyData = [];
  List<MonthlyData> _monthlyData = [];
  List<ActivityBreakdown> _activityBreakdown = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_useMockData) {
        // Use mock data
        await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
        setState(() {
          _stats = _mockData.getStats();
          _weeklyData = _mockData.getWeeklyData();
          _monthlyData = _mockData.getMonthlyData();
          _activityBreakdown = _mockData.getActivityBreakdown();
          _isLoading = false;
        });
      } else {
        // Use API
        final stats = await _apiService.getStats();
        final weeklyData = await _apiService.getWeeklyData();
        final monthlyData = await _apiService.getMonthlyData();
        final activityBreakdown = await _apiService.getActivityBreakdown();

        setState(() {
          _stats = stats;
          _weeklyData = weeklyData;
          _monthlyData = monthlyData;
          _activityBreakdown = activityBreakdown;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<double> _getCaloriesData() {
    if (_currentView == DashboardView.weekly) {
      return _weeklyData.map((d) => d.calories).toList();
    } else {
      return _monthlyData.map((d) => d.calories).toList();
    }
  }

  List<int> _getWorkoutsData() {
    if (_currentView == DashboardView.weekly) {
      return _weeklyData.map((d) => d.workouts).toList();
    } else {
      return _monthlyData.map((d) => d.workouts).toList();
    }
  }

  List<String> _getLabels() {
    if (_currentView == DashboardView.weekly) {
      return _weeklyData.map((d) {
        // Format date to show day name (e.g., Mon, Tue)
        final parts = d.date.split('-');
        if (parts.length == 3) {
          final day = int.tryParse(parts[2]) ?? 0;
          return day.toString();
        }
        return d.date;
      }).toList();
    } else {
      return _monthlyData.map((d) => d.week).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_useMockData ? Icons.cloud_off : Icons.cloud),
            onPressed: () {
              setState(() {
                _useMockData = !_useMockData;
              });
              _loadData();
            },
            tooltip: _useMockData ? 'Using Mock Data' : 'Using API Data',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading data',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // View Toggle
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildToggleButton(
                                  'Weekly',
                                  DashboardView.weekly,
                                ),
                              ),
                              Expanded(
                                child: _buildToggleButton(
                                  'Monthly',
                                  DashboardView.monthly,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Stats Cards
                        if (_stats != null) ...[
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.3,
                            children: [
                              StatCard(
                                title: 'Total Workouts',
                                value: _stats!.totalWorkouts.toString(),
                                icon: Icons.fitness_center,
                                color: const Color(0xFF4CAF50),
                              ),
                              StatCard(
                                title: 'Calories Burned',
                                value: _stats!.totalCalories.toStringAsFixed(0),
                                icon: Icons.local_fire_department,
                                color: const Color(0xFFFF5722),
                                unit: 'cal',
                              ),
                              StatCard(
                                title: 'Distance',
                                value: _stats!.totalDistance.toStringAsFixed(1),
                                icon: Icons.location_on,
                                color: const Color(0xFF2196F3),
                                unit: 'km',
                              ),
                              StatCard(
                                title: 'Duration',
                                value: _stats!.totalDuration.toStringAsFixed(0),
                                icon: Icons.timer,
                                color: const Color(0xFF9C27B0),
                                unit: 'min',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Charts
                        if (_getCaloriesData().isNotEmpty) ...[
                          CaloriesLineChart(
                            data: _getCaloriesData(),
                            labels: _getLabels(),
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (_getWorkoutsData().isNotEmpty) ...[
                          WorkoutsBarChart(
                            data: _getWorkoutsData(),
                            labels: _getLabels(),
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (_activityBreakdown.isNotEmpty) ...[
                          ActivityDoughnutChart(
                            activities: _activityBreakdown,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildToggleButton(String title, DashboardView view) {
    final isSelected = _currentView == view;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentView = view;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
