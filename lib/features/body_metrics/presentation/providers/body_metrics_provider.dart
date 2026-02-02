import 'package:fit_tracker/features/body_metrics/domain/entities/body_metrics.dart';
import 'package:fit_tracker/features/body_metrics/domain/usecases/get_metrics.dart';
import 'package:flutter/material.dart';
import '../../domain/usecases/save_metrics.dart';


class BodyMetricsProvider extends ChangeNotifier {
  final SaveMetrics saveMetricsUseCase;
  final GetMetrics getMetricsUseCase;

  List<BodyMetrics> _metrics = [];
  List<BodyMetrics> get metrics => _metrics;

  BodyMetricsProvider({
    required this.saveMetricsUseCase,
    required this.getMetricsUseCase,
  });

  Future<void> addMetrics(BodyMetrics metrics, int id) async {
    await saveMetricsUseCase(metrics, id);
    await loadMetrics(id);
  }

  Future<void> loadMetrics(int id) async {
    _metrics = await getMetricsUseCase(id);
    notifyListeners();
  }
}
