import '../../domain/entities/body_metrics.dart';
import '../../domain/repositories/body_metrics_repository.dart';
import '../datasources/remote_metrics_datasource.dart';
import '../models/body_metrics_model.dart';

class BodyMetricsRepositoryImpl implements BodyMetricsRepository {
  final RemoteMetricsDatasource datasource;

  BodyMetricsRepositoryImpl(this.datasource);

  @override
  Future<void> saveMetrics(BodyMetrics metrics, int userId) async {
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

    await datasource.saveMetrics(model, userId);
  }

  @override
  Future<List<BodyMetrics>> getAllMetrics(int userId) async {
    final models = await datasource.fetchUserMetrics(userId);
    return models.map((m) => m.toEntity()).toList();
  }
}
