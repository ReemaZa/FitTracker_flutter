import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'gradient_text.dart';

/// Size variants
enum PrimaryButtonSize {
  small,
  medium,
  large,
}

/// Style variants
enum PrimaryButtonVariant {
  gradient,
  white,
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final PrimaryButtonSize size;
  final PrimaryButtonVariant variant;
  final double borderRadius;
  final bool enabled;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.size = PrimaryButtonSize.large,
    this.variant = PrimaryButtonVariant.gradient,
    this.borderRadius = 99,
    this.enabled = true,
  });

  // -----------------------------
  // Size helpers
  // -----------------------------

  double _height(BuildContext context) {
    switch (size) {
      case PrimaryButtonSize.small:
        return 44;
      case PrimaryButtonSize.medium:
        return 52;
      case PrimaryButtonSize.large:
        return 60;
    }
  }

  double _maxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    switch (size) {
      case PrimaryButtonSize.small:
        return screenWidth * 0.55;
      case PrimaryButtonSize.medium:
        return screenWidth * 0.7;
      case PrimaryButtonSize.large:
        return screenWidth * 0.85;
    }
  }

  // -----------------------------
  // Styles
  // -----------------------------

  Color _textColor(BuildContext context) {
    switch (variant) {
      case PrimaryButtonVariant.white:
        return AppColors.brandPrimary;
      case PrimaryButtonVariant.gradient:
        return AppColors.white;
    }
  }

  // -----------------------------
  // Build
  // -----------------------------

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        height: _height(context),
        constraints: BoxConstraints(
          maxWidth: _maxWidth(context),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: variant == PrimaryButtonVariant.white
                ? AppColors.white
                : null,
            gradient: variant == PrimaryButtonVariant.gradient
                ? AppColors.primaryGradient
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: AppColors.grayMedium.withOpacity(0.35),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(width: 8),
                ],
                variant == PrimaryButtonVariant.white
                    ? GradientText(
                  text: label,
                  gradient: AppColors.primaryGradient,
                  style: Theme.of(context).textTheme.labelLarge,
                )
                    : Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}