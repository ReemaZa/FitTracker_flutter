import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

enum GoalTypeUI {
  walking,
  water,
  workout,
  custom,
}

class GoalTypeSelector extends StatelessWidget {
  final GoalTypeUI selected;
  final ValueChanged<GoalTypeUI> onChanged;

  const GoalTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  IconData _icon(GoalTypeUI type) {
    switch (type) {
      case GoalTypeUI.walking:
        return Icons.directions_walk;
      case GoalTypeUI.water:
        return Icons.water_drop;
      case GoalTypeUI.workout:
        return Icons.fitness_center;
      case GoalTypeUI.custom:
        return Icons.flag;
    }
  }

  String _label(GoalTypeUI type) {
    switch (type) {
      case GoalTypeUI.walking:
        return 'Walking';
      case GoalTypeUI.water:
        return 'Water';
      case GoalTypeUI.workout:
        return 'Workout';
      case GoalTypeUI.custom:
        return 'Custom';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: GoalTypeUI.values.map((type) {
        final isSelected = type == selected;

        return GestureDetector(
          onTap: () => onChanged(type),
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? AppColors.secondaryGradient
                  : null,
              color: isSelected ? null : AppColors.grayLight,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: AppColors.brandPrimary.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _icon(type),
                  color: isSelected
                      ? AppColors.white
                      : AppColors.grayDark,
                ),
                const SizedBox(height: 6),
                Text(
                  _label(type),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.grayDark,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
