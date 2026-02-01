import '../repositories/body_metrics_repository.dart';
import '../entities/body_metrics.dart';

class GetMetrics {
  final BodyMetricsRepository repository;

  GetMetrics(this.repository);

  Future<List<BodyMetrics>> call() async {
    return await repository.getAllMetrics();
  }
}
