import '../domain/entities/dashboard_stats.dart';
import '../domain/entities/weekly_data.dart';
import '../domain/entities/monthly_data.dart';
import '../domain/entities/activity_breakdown.dart';
import '../domain/entities/dashboard_summary.dart';

class MockDashboardData {
  DashboardStats getStats() {
    return DashboardStats(
      totalWorkouts: 24,
      totalCalories: 12450,
      totalDistance: 48.5,
      totalDuration: 1820, // minutes
    );
  }

  List<WeeklyData> getWeeklyData() {
    return [
      WeeklyData(
        date: '2026-01-23',
        workouts: 2,
        calories: 850,
        distance: 5.2,
        duration: 120,
      ),
      WeeklyData(
        date: '2026-01-24',
        workouts: 3,
        calories: 1200,
        distance: 8.5,
        duration: 180,
      ),
      WeeklyData(
        date: '2026-01-25',
        workouts: 1,
        calories: 450,
        distance: 3.2,
        duration: 60,
      ),
      WeeklyData(
        date: '2026-01-26',
        workouts: 4,
        calories: 1650,
        distance: 12.3,
        duration: 240,
      ),
      WeeklyData(
        date: '2026-01-27',
        workouts: 2,
        calories: 920,
        distance: 6.8,
        duration: 135,
      ),
      WeeklyData(
        date: '2026-01-28',
        workouts: 3,
        calories: 1380,
        distance: 9.5,
        duration: 195,
      ),
      WeeklyData(
        date: '2026-01-29',
        workouts: 2,
        calories: 780,
        distance: 5.0,
        duration: 110,
      ),
    ];
  }

  List<MonthlyData> getMonthlyData() {
    return [
      MonthlyData(
        week: 'Week 1',
        workouts: 12,
        calories: 5240,
        distance: 22.5,
        duration: 680,
      ),
      MonthlyData(
        week: 'Week 2',
        workouts: 15,
        calories: 6820,
        distance: 28.3,
        duration: 825,
      ),
      MonthlyData(
        week: 'Week 3',
        workouts: 11,
        calories: 4950,
        distance: 19.8,
        duration: 615,
      ),
      MonthlyData(
        week: 'Week 4',
        workouts: 17,
        calories: 7430,
        distance: 31.2,
        duration: 940,
      ),
    ];
  }

  List<ActivityBreakdown> getActivityBreakdown() {
    return [
      ActivityBreakdown(
        activityType: 'Running',
        count: 8,
        percentage: 35,
      ),
      ActivityBreakdown(
        activityType: 'Cycling',
        count: 6,
        percentage: 25,
      ),
      ActivityBreakdown(
        activityType: 'Swimming',
        count: 4,
        percentage: 18,
      ),
      ActivityBreakdown(
        activityType: 'Yoga',
        count: 3,
        percentage: 12,
      ),
      ActivityBreakdown(
        activityType: 'Strength',
        count: 3,
        percentage: 10,
      ),
    ];
  }

  DashboardSummary getWeeklySummary() {
    return DashboardSummary(
      averageWorkoutsPerDay: 2.4,
      averageCaloriesPerDay: 1035,
      averageDistancePerDay: 7.2,
      averageDurationPerDay: 148.5,
      totalDays: 7,
    );
  }

  DashboardSummary getMonthlySummary() {
    return DashboardSummary(
      averageWorkoutsPerDay: 1.8,
      averageCaloriesPerDay: 812,
      averageDistancePerDay: 6.1,
      averageDurationPerDay: 125,
      totalDays: 30,
    );
  }
}
