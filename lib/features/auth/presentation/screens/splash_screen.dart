import 'package:flutter/material.dart';
import '../../../../app.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/primary_botton.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.splashScreenGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 40),

                // App title / logo placeholder
                Column(
                  children: [
                    Text(
                      'FitTracker',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.black, // Keep your color
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Build habits. Stay consistent.',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                // Get Started Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: PrimaryButton(
                    label: 'Get Started',
                    variant: PrimaryButtonVariant.white,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => const AppShell(),
                        ),
                      );
                    },                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}