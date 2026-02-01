import '../entities/body_metrics.dart';

abstract class BodyMetricsRepository {
  Future<void> saveMetrics(BodyMetrics metrics);
  Future<List<BodyMetrics>> getAllMetrics();
}
