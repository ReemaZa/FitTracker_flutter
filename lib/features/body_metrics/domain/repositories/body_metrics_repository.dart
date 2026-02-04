import '../entities/body_metrics.dart';

abstract class BodyMetricsRepository {
  Future<void> saveMetrics(BodyMetrics metrics, int userId);
  Future<List<BodyMetrics>> getAllMetrics(int userId);
}
