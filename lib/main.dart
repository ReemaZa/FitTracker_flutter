import 'package:fit_tracker/features/body_metrics/data/datasources/mock_metrics_datasource.dart';
import 'package:fit_tracker/features/body_metrics/data/repositories/body_metrics_repository_impl.dart';
import 'package:fit_tracker/features/body_metrics/domain/usecases/get_metrics.dart';
import 'package:fit_tracker/features/body_metrics/domain/usecases/save_metrics.dart';
import 'package:fit_tracker/features/body_metrics/presentation/providers/body_metrics_provider.dart';
import 'package:fit_tracker/features/body_metrics/presentation/screens/add_metrics_page.dart';
import 'package:fit_tracker/features/body_metrics/presentation/screens/health_progress_page.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  final repository = BodyMetricsRepositoryImpl(MockMetricsDatasource());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BodyMetricsProvider(
            saveMetricsUseCase: SaveMetrics(repository),
            getMetricsUseCase: GetMetrics(repository),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
    );
  }
}
