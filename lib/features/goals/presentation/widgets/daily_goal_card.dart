import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/daily_goal_instance.dart';
import '../../domain/entities/goal_step_rules.dart';
import 'stepper_control.dart';

class DailyGoalCard extends StatefulWidget {
  final DailyGoalInstance goal;

  const DailyGoalCard({super.key, required this.goal});

  @override
  State<DailyGoalCard> createState() => _DailyGoalCardState();
}

class _DailyGoalCardState extends State<DailyGoalCard> {
  void _increase() {
    final step = GoalStepRules.stepFor(
      metricType: widget.goal.metricType,
      unit: widget.goal.unit,
    );

    setState(() {
      widget.goal.completedValue =
          (widget.goal.completedValue + step)
              .clamp(0, widget.goal.targetValue);
      _checkCompletion();
    });
  }

  void _decrease() {
    final step = GoalStepRules.stepFor(
      metricType: widget.goal.metricType,
      unit: widget.goal.unit,
    );

    setState(() {
      widget.goal.completedValue =
          (widget.goal.completedValue - step)
              .clamp(0, widget.goal.targetValue);
      _checkCompletion();
    });
  }

  void _toggleBinary() {
    setState(() {
      widget.goal.isCompleted = !widget.goal.isCompleted;
      widget.goal.completedValue = widget.goal.isCompleted ? 1 : 0;
    });
  }

  void _checkCompletion() {
    widget.goal.isCompleted =
        widget.goal.completedValue >= widget.goal.targetValue;
  }

  @override
  Widget build(BuildContext context) {
    final progress =
    (widget.goal.completedValue / widget.goal.targetValue)
        .clamp(0.0, 1.0);

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
                  widget.goal.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (widget.goal.isCompleted)
                const Icon(Icons.check_circle, color: Colors.green),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            'Target: ${widget.goal.targetValue} ${widget.goal.unit}',
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.grayLight,
            valueColor: AlwaysStoppedAnimation(
              widget.goal.isCompleted
                  ? AppColors.brandPrimary
                  : AppColors.secondaryPurple,
            ),
          ),

          const SizedBox(height: 12),

          /// Controls
          widget.goal.metricType == GoalMetricType.binary
              ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _toggleBinary,
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
                  gradient: widget.goal.isCompleted
                      ? AppColors.secondaryGradient
                      : AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    widget.goal.isCompleted
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
            onMinus: _decrease,
            onPlus: _increase,
            label:
            '${widget.goal.completedValue} / ${widget.goal.targetValue} ${widget.goal.unit}',
          ),
        ],
      ),
    );
  }
}
