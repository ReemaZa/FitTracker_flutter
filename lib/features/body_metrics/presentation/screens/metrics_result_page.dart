import 'dart:math';

import 'package:fit_tracker/features/body_metrics/domain/entities/body_metrics.dart';
import 'package:fit_tracker/features/body_metrics/presentation/providers/body_metrics_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MetricsResultPage extends StatelessWidget {
  final BodyMetrics metrics;

  const MetricsResultPage({super.key, required this.metrics});


  List<String> get advice {
    final List<String> advices = [];

    if (metrics.bmi! >= 25) advices.add('BMI is high: consider regular exercise and healthy diet.');
    if (metrics.bmi! < 18.5) advices.add('BMI is low: consider consulting a nutritionist.');
    if (metrics.systolic != null && metrics.diastolic != null) {
      if (metrics.systolic! >= 130 || metrics.diastolic! >= 80) {
        advices.add('High blood pressure: reduce sodium intake, exercise, and monitor BP.');
      }
    }
    if (metrics.pulseRate != null) {
      if (metrics.pulseRate! > 100) advices.add('High pulse: check for stress or heart issues.');
      if (metrics.pulseRate! < 60) advices.add('Low pulse: could be athletic heart, otherwise consult a doctor.');
    }
    if (metrics.bodyFat != null) {
      if (metrics.bodyFat! > 25) advices.add('Body fat % is high: maintain active lifestyle.');
      if (metrics.bodyFat! < 10) advices.add('Body fat % is low: ensure proper nutrition.');
    }

    return advices.isEmpty ? ['All metrics are within normal range.'] : advices;
  }

  @override
Widget build(BuildContext context) {
    final provider = context.read<BodyMetricsProvider>();

     return Scaffold(
      appBar: AppBar(title: const Text('Metrics Result')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BMI: ${metrics.bmi!.toStringAsFixed(1)}', style: const TextStyle(fontSize: 18)),
            if (metrics.bodyFat != null)
              Text('Body Fat %: ${metrics.bodyFat!.toStringAsFixed(1)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('Advice:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...advice.map((a) => Text('- $a', style: const TextStyle(fontSize: 16))),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save metrics via provider, including BMI and body fat
                  provider.addMetrics(
                    metrics,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Metrics saved successfully!')),
                  );

                  Navigator.pop(context); // Optional: go back after saving
                },
                child: const Text('Save Metrics'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}