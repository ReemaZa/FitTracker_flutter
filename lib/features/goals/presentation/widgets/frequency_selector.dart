import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum GoalFrequency {
  daily,
  weekly,
}

class FrequencySelector extends StatelessWidget {
  final GoalFrequency selected;
  final ValueChanged<GoalFrequency> onChanged;

  const FrequencySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: GoalFrequency.values.map((frequency) {
        final isSelected = frequency == selected;

        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(frequency),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient:
                isSelected ? AppColors.secondaryGradient : null,
                color: isSelected ? null : AppColors.grayLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  frequency == GoalFrequency.daily
                      ? 'Daily'
                      : 'Weekly',
                  style:
                  Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.grayDark,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
