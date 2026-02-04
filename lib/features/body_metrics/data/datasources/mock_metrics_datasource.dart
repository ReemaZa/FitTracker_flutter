import '../models/body_metrics_model.dart';

class MockMetricsDatasource {
  Future<List<BodyMetricsModel>> fetchUserMetrics(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate delay
    return [
      BodyMetricsModel(
        recordedAt: DateTime(2025, 2, 1),
        heightCm: 175,
        weightKg: 79,
        bmi: 25.9,      
        bodyFat: null,
        waistCm: 90,
        neckCm: 40,
        hipCm: null,
        systolic: 125,
        diastolic: 82,
        pulseRate: null,
      ),
      BodyMetricsModel(
        recordedAt: DateTime(2025, 3, 1),
        heightCm: 175,
        weightKg: 76,
        bmi: 24.8,
        bodyFat: 22.4,
        waistCm: 88,
        neckCm: 39,
        hipCm: null,
        systolic: null,
        diastolic: null,
        pulseRate: 72,
      ),
      BodyMetricsModel(
        recordedAt: DateTime(2025, 4, 1),
        heightCm: 175,
        weightKg: 75,
        bmi: 24.5,
        bodyFat: 21.9,
        waistCm: 87,
        neckCm: 39,
        hipCm: null,
        systolic: 118,
        diastolic: 78,
        pulseRate: 70,
      ),
    ];
  }
}
