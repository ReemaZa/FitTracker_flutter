import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class WeekDaysSelector extends StatelessWidget {
  final List<int> selectedDays;
  final ValueChanged<List<int>> onChanged;

  const WeekDaysSelector({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  static const _days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: List.generate(7, (index) {
        final isSelected = selectedDays.contains(index);

        return GestureDetector(
          onTap: () {
            final updated = [...selectedDays];
            isSelected ? updated.remove(index) : updated.add(index);
            onChanged(updated);
          },
          child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: isSelected ? AppColors.secondaryGradient : null,
              color: isSelected ? null : AppColors.grayLight,
              shape: BoxShape.circle,
            ),
            child: Text(
              _days[index],
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.grayDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }
}
