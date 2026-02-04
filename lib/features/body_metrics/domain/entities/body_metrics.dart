class BodyMetrics {
  final DateTime recordedAt;
  final double heightCm;
  final double weightKg;
  final double? waistCm;
  final double? neckCm;
  final double? hipCm;
  final int? systolic;
  final int? diastolic;
  final int? pulseRate;

  // Stored BMI & bodyFat for caching
  final double? bmi;
  final double? bodyFat;

  BodyMetrics({
    required this.recordedAt,
    required this.heightCm,
    required this.weightKg,
    this.waistCm,
    this.neckCm,
    this.hipCm,
    this.systolic,
    this.diastolic,
    this.pulseRate,
    this.bmi,
    this.bodyFat,
  });
}
