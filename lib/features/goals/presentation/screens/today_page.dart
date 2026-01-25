import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../mocks/mock_daily_goals.dart';
import '../widgets/daily_goal_card.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mockTodayGoals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return DailyGoalCard(goal: mockTodayGoals[index]);
        },
      ),
    );
  }
}
