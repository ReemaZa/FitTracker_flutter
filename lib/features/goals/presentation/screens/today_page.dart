import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/goals_provider.dart';
import '../widgets/daily_goal_card.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  void initState() {
    super.initState();
    // Load today goals once page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GoalsProvider>().loadTodayGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalsProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Today'),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: provider.isTodayLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.todayGoals.isEmpty
          ? const Center(child: Text('No goals for today'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: provider.todayGoals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return DailyGoalCard(
            goal: provider.todayGoals[index],
          );
        },
      ),
    );
  }
}
