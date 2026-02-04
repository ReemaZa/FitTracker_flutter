import '../entities/body_metrics.dart';
import '../repositories/body_metrics_repository.dart';

class SaveMetrics {
  final BodyMetricsRepository repository;

  SaveMetrics(this.repository);

  Future<void> call(BodyMetrics metrics, int id) async {
    await repository.saveMetrics(metrics, id);
  }
}
