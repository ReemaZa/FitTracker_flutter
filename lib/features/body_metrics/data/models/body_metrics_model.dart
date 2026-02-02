import 'package:fit_tracker/features/body_metrics/domain/entities/body_metrics.dart';

class BodyMetricsModel {
  final DateTime recordedAt;
  final double heightCm;
  final double weightKg;
  final double? bmi;
  final double? bodyFat;
  final double? waistCm;
  final double? neckCm;
  final double? hipCm;
  final int? systolic;
  final int? diastolic;
  final int? pulseRate;

  BodyMetricsModel({
    required this.recordedAt,
    required this.heightCm,
    required this.weightKg,
    this.bmi,
    this.bodyFat,
    this.waistCm,
    this.neckCm,
    this.hipCm,
    this.systolic,
    this.diastolic,
    this.pulseRate,
  });

  factory BodyMetricsModel.fromJson(Map<String, dynamic> json) {
    return BodyMetricsModel(
bmi: (json['bmi'] as num).toDouble(),
bodyFat: json['bodyFat'] != null ? (json['bodyFat'] as num).toDouble() : null,
heightCm: (json['heightCm'] as num).toDouble(),
weightKg: (json['weightKg'] as num).toDouble(),
waistCm: json['waistCm'] != null ? (json['waistCm'] as num).toDouble() : null,
neckCm: json['neckCm'] != null ? (json['neckCm'] as num).toDouble() : null,
hipCm: json['hipCm'] != null ? (json['hipCm'] as num).toDouble() : null,
systolic: json['systolic'] as int?,
diastolic: json['diastolic'] as int?,
pulseRate: json['pulseRate'] as int?,
recordedAt: DateTime.parse(json['recordedAt'] as String),

    );
  }

  Map<String, dynamic> toJson() => {
        'recordedAt': recordedAt.toIso8601String(),
        'heightCm': heightCm,
        'weightKg': weightKg,
        'bmi': bmi,
        'bodyFat': bodyFat,
        'waistCm': waistCm,
        'neckCm': neckCm,
        'hipCm': hipCm,
        'systolic': systolic,
        'diastolic': diastolic,
        'pulseRate': pulseRate,
      };

  BodyMetrics toEntity() => BodyMetrics(
        recordedAt: recordedAt,
        heightCm: heightCm,
        weightKg: weightKg,
        bmi: bmi,
        bodyFat: bodyFat,
        waistCm: waistCm,
        neckCm: neckCm,
        hipCm: hipCm,
        systolic: systolic,
        diastolic: diastolic,
        pulseRate: pulseRate,
      );
}
