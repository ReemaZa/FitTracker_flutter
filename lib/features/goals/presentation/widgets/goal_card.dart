import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_toggle.dart';
import '../../domain/entities/goal.dart';
import '../../domain/entities/goal_schedule.dart';
import '../providers/goals_provider.dart';
class GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback? onTap;

  const GoalCard({
    super.key,
    required this.goal,
    this.onTap,
  });

  IconData _iconForType(GoalType type) {
    switch (type) {
      case GoalType.walking:
        return Icons.directions_walk;
      case GoalType.water:
        return Icons.water_drop;
      case GoalType.workout:
        return Icons.fitness_center;
      case GoalType.custom:
        return Icons.flag;
    }
  }

  String _scheduleText(Goal goal) {
    final schedule = goal.schedule;

    switch (schedule.frequencyType) {
      case GoalFrequencyType.daily:
        return 'Every day';

      case GoalFrequencyType.weekly:
        if (schedule.daysOfWeek.isEmpty) {
          return 'Weekly';
        }

        const labels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

        return schedule.daysOfWeek
            .map((d) => labels[d])
            .join(', ');

    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayMedium.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.brandPrimary.withOpacity(0.15),
            child: Icon(
              _iconForType(goal.goalType),
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(width: 16),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '${goal.targetValue} ${goal.unit}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.grayMedium),
                ),
                const SizedBox(height: 2),
                Text(
                  _scheduleText(goal),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    color: AppColors.brandPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// TOGGLE
          GradientToggle(
            value: goal.isActive,
            onChanged: (_) {
              context.read<GoalsProvider>().toggle(goal.id);
            },
          ),

          const SizedBox(width: 8),

          /// DELETE
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: Colors.red,
            onPressed: () {
              context.read<GoalsProvider>().remove(goal.id);
            },
          ),
        ],
      ),
    );
  }
}

