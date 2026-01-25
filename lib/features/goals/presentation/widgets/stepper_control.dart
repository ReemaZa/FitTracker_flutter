import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StepperControl extends StatelessWidget {
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final String label;

  const StepperControl({
    super.key,
    required this.onMinus,
    required this.onPlus,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(Icons.remove, onMinus),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label),
        ),
        _button(Icons.add, onPlus),
      ],
    );
  }

  Widget _button(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayLight,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
