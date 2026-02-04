import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/icon_button.dart';
import '../providers/goals_provider.dart';
import '../widgets/goal_card.dart';
import '../widgets/empty_goals_view.dart';
import 'add_goal_page.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();

    // VERY IMPORTANT
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GoalsProvider>().loadGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GoalsProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('My Goals'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: _buildBody(provider),
      floatingActionButton: IconGradientButton(
        icon: Icons.add,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddGoalPage(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(GoalsProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.goals.isEmpty) {
      return EmptyGoalsView(onAddGoal: () {});
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: provider.goals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return GoalCard(goal: provider.goals[index]);
      },
    );
  }
}
