import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/icon_button.dart';
import '../../mocks/mock_goals.dart';
import '../widgets/goal_card.dart';
import '../widgets/empty_goals_view.dart';
import 'add_goal_page.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('My Goals'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: mockGoals.isEmpty
          ? EmptyGoalsView(
        onAddGoal: () {},
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: mockGoals.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return GoalCard(goal: mockGoals[index]);
        },
      ),
      floatingActionButton: IconGradientButton(
        icon: Icons.add,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddGoalPage(),
              ),
            );
          }
      ),
    );
  }
}
