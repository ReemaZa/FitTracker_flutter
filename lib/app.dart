import 'package:fit_tracker/features/forum/presentation/screens/forum_page.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'core/widgets/gradient_icon.dart';
import 'features/goals/presentation/screens/goal_page.dart';
import 'features/goals/presentation/screens/today_page.dart';
import 'features/dashboard/presentation/screens/dashboard_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final _pages = const [
    DashboardScreen(), // Dashboard
    GoalsPage(),
    TodayPage(),
    ForumPage(), // ForumPage
    Placeholder(), // ProfilePage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        elevation: 10,
        unselectedItemColor: AppColors.grayMedium,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _navItem(Icons.home, 'Dashboard', 0),
          _navItem(Icons.flag, 'Goals', 1),
          _navItem(Icons.calendar_today, 'Today', 2),
          _navItem(Icons.forum, 'Forum', 3),
          _navItem(Icons.person, 'Profile', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(
    IconData icon,
    String label,
    int index,
  ) {
    final isSelected = _currentIndex == index;

    return BottomNavigationBarItem(
      label: label,
      icon: isSelected
          ? GradientIcon(
              icon: icon,
              gradient: AppColors.secondaryGradient,
            )
          : Icon(
              icon,
              color: AppColors.grayMedium,
            ),
    );
  }
}
