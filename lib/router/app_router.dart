import 'package:flutter/material.dart';
import 'package:fit_tracker/features/forum/presentation/screens/forum_page.dart';
import 'package:fit_tracker/features/forum/presentation/screens/post_detail_page.dart';
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
  static const String forum = '/forum';
  static const String postDetail = '/post-detail';

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
      
      case forum:
        return MaterialPageRoute(
          builder: (_) => const ForumPage(),
          settings: settings,
        );
      
      case postDetail:
        final postId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => PostDetailPage(postId: postId),
          settings: settings,
        );
      
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
    forum: (context) => const ForumPage(),
  };
}
