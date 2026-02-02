import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/goals/presentation/screens/today_page.dart';
import '../features/goals/presentation/screens/goal_page.dart';
import '../features/goals/presentation/screens/add_goal_page.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String today = '/today';
  static const String goals = '/goals';
  static const String addGoal = '/add-goal';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      
      case today:
        return MaterialPageRoute(builder: (_) => const TodayPage());
      
      case goals:
        return MaterialPageRoute(builder: (_) => const GoalsPage());
      
      case addGoal:
        return MaterialPageRoute(builder: (_) => const AddGoalPage());
      
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    today: (context) => const TodayPage(),
    goals: (context) => const GoalsPage(),
    addGoal: (context) => const AddGoalPage(),
    dashboard: (context) => const DashboardScreen(),
  };
}
