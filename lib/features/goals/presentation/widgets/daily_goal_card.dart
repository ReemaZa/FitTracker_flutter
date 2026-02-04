import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/goal_metrics.dart';
import '../../domain/entities/daily_goal_instance.dart';
import '../../domain/entities/goal.dart';
import '../../domain/entities/goal_step_rules.dart';
import '../providers/goals_provider.dart';
import 'stepper_control.dart';

class DailyGoalCard extends StatelessWidget {
  final DailyGoalInstance goal;

  const DailyGoalCard({super.key, required this.goal});

  void _increase(BuildContext context) {
    final step = GoalStepRules.stepFor(
      metricType: goal.metricType,
      unit: goal.unit,
    );

    context.read<GoalsProvider>().incrementToday(goal, step);
  }

  void _decrease(BuildContext context) {
    final step = GoalStepRules.stepFor(
      metricType: goal.metricType,
      unit: goal.unit,
    );

    context.read<GoalsProvider>().decrementToday(goal, step);
  }

  void _toggleBinary(BuildContext context) {
    context
        .read<GoalsProvider>()
        .toggleBinaryDailyGoal(goal);
  }


  @override
  Widget build(BuildContext context) {
    final progress =
    (goal.completedValue / goal.targetValue).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.grayMedium.withOpacity(0.25),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  goal.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (goal.isCompleted)
                const Icon(Icons.check_circle, color: Colors.green),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            'Target: ${goal.targetValue} ${goal.unit}',
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.grayLight,
            valueColor: AlwaysStoppedAnimation(
              goal.isCompleted
                  ? AppColors.brandPrimary
                  : AppColors.secondaryPurple,
            ),
          ),

          const SizedBox(height: 12),

          /// Controls
          goal.metricType == GoalMetricType.binary
              ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _toggleBinary(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding:
                const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: goal.isCompleted
                      ? AppColors.secondaryGradient
                      : AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    goal.isCompleted
                        ? 'Mark as undone'
                        : 'Mark as done',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
          )
              : StepperControl(
            onMinus: () => _decrease(context),
            onPlus: () => _increase(context),
            label:
            '${goal.completedValue} / ${goal.targetValue} ${goal.unit}',
          ),
        ],
      ),
    );
  }
}
