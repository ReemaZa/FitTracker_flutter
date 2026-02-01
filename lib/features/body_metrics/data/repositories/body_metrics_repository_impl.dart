import '../../domain/entities/body_metrics.dart';
import '../../domain/repositories/body_metrics_repository.dart';
import '../datasources/mock_metrics_datasource.dart';
import '../models/body_metrics_model.dart';

class BodyMetricsRepositoryImpl implements BodyMetricsRepository {
  final MockMetricsDatasource datasource;

  BodyMetricsRepositoryImpl(this.datasource);

  @override
  Future<void> saveMetrics(BodyMetrics metrics) async {
    // simulate saving
    final model = BodyMetricsModel(
      recordedAt: metrics.recordedAt,
      heightCm: metrics.heightCm,
      weightKg: metrics.weightKg,
      bmi: metrics.bmi,
      bodyFat: metrics.bodyFat,
      waistCm: metrics.waistCm,
      neckCm: metrics.neckCm,
      hipCm: metrics.hipCm,
      systolic: metrics.systolic,
      diastolic: metrics.diastolic,
      pulseRate: metrics.pulseRate,
    );
    // In mock we do nothing, in real DB we would insert model.toJson()
  }

  @override
  Future<List<BodyMetrics>> getAllMetrics() async {
    return await datasource.fetchUserMetrics('mock-user');
  }
}
