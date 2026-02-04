import 'package:fit_tracker/features/body_metrics/presentation/screens/add_metrics_page.dart';
import 'package:fit_tracker/features/body_metrics/presentation/screens/health_progress_page.dart';
import 'package:fit_tracker/router/app_router.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
    '/add-metrics': (_) => const AddMetricsPage(),
    '/health-progress':(_) => const HealthProgressPage()
    },

      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
