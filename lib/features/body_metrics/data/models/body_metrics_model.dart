import '../../domain/entities/body_metrics.dart';

class BodyMetricsModel extends BodyMetrics {
  BodyMetricsModel({
    required DateTime recordedAt,
    required double heightCm,
    required double weightKg,
    double? waistCm,
    double? neckCm,
    double? hipCm,
    int? systolic,
    int? diastolic,
    int? pulseRate,
    double? bmi,
    double? bodyFat,
  }) : super(
          recordedAt: recordedAt,
          heightCm: heightCm,
          weightKg: weightKg,
          waistCm: waistCm,
          neckCm: neckCm,
          hipCm: hipCm,
          systolic: systolic,
          diastolic: diastolic,
          pulseRate: pulseRate,
          bmi: bmi,
          bodyFat: bodyFat,
        );

  factory BodyMetricsModel.fromJson(Map<String, dynamic> json) {
    return BodyMetricsModel(
      recordedAt: DateTime.parse(json['recorded_at']),
      heightCm: (json['height_cm'] as num).toDouble(),
      weightKg: (json['weight_kg'] as num).toDouble(),
      waistCm: json['waist_cm'] != null ? (json['waist_cm'] as num).toDouble() : null,
      neckCm: json['neck_cm'] != null ? (json['neck_cm'] as num).toDouble() : null,
      hipCm: json['hip_cm'] != null ? (json['hip_cm'] as num).toDouble() : null,
      systolic: json['systolic'],
      diastolic: json['diastolic'],
      pulseRate: json['pulse_rate'],
      bmi: (json['bmi'] as num).toDouble(),
      bodyFat: json['body_fat'] != null ? (json['body_fat'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'recorded_at': recordedAt.toIso8601String(),
        'height_cm': heightCm,
        'weight_kg': weightKg,
        'waist_cm': waistCm,
        'neck_cm': neckCm,
        'hip_cm': hipCm,
        'systolic': systolic,
        'diastolic': diastolic,
        'pulse_rate': pulseRate,
        'bmi': bmi,
        'body_fat': bodyFat,
      };
}
