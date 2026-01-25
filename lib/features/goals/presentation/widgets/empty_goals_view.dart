import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class EmptyGoalsView extends StatelessWidget {
  final VoidCallback onAddGoal;

  const EmptyGoalsView({
    super.key,
    required this.onAddGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.flag_outlined,
              size: 64,
              color: AppColors.grayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'No goals yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Start by creating your first goal',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.grayMedium),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onAddGoal,
              child: const Text('Add goal'),
            ),
          ],
        ),
      ),
    );
  }
}
