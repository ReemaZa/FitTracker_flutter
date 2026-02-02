import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/body_metrics.dart';
import '../providers/body_metrics_provider.dart';
import 'metrics_result_page.dart';


class AddMetricsPage extends StatefulWidget {
  
  const AddMetricsPage({super.key});

  @override
  State<AddMetricsPage> createState() => _AddMetricsPageState();
}

class _AddMetricsPageState extends State<AddMetricsPage> {
  final _formKey = GlobalKey<FormState>();

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _waistController = TextEditingController();
  final _neckController = TextEditingController();
  final _hipController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();

  // placeholder value for the current user
  var userId = 2;
  double? _parse(String value) =>
      value.trim().isEmpty ? null : double.tryParse(value);

  void _calculateMetrics() async {
    if (!_formKey.currentState!.validate()) return;
    final heightCm = double.parse(_heightController.text);
    final weightKg = double.parse(_weightController.text);
    final heightM = heightCm / 100;
    // Calculate BMI
    final bmi = weightKg / (heightM * heightM);
    double? bodyFat;
    if (_waistController.text.isNotEmpty && _neckController.text.isNotEmpty) {
      final waist = _parse(_waistController.text)!;
      final neck = _parse(_neckController.text)!;
      final hip = _parse(_hipController.text);

      // For men
      if (hip == null) {
        bodyFat = 495 /
                (1.0324 -
                    0.19077 * (log(waist - neck) / ln10) +
                    0.15456 * (log(heightCm) / ln10)) -
            450;
      } else {
        // For women
        bodyFat = 495 /
                (1.29579 -
                    0.35004 * (log(waist + hip - neck) / ln10) +
                    0.22100 * (log(heightCm) / ln10)) -
            450;
      }
    }

  if (bodyFat == null || bodyFat.isNaN || bodyFat.isInfinite) 
  {
    bodyFat = null;
  }


    final metrics = BodyMetrics(
      recordedAt: DateTime.now(),
      heightCm: heightCm,
      weightKg: weightKg,
      bmi: bmi,
      waistCm: _parse(_waistController.text),
      neckCm: _parse(_neckController.text),
      hipCm: _parse(_hipController.text),
      bodyFat: bodyFat,
      systolic: _parse(_systolicController.text)?.toInt(),
      diastolic: _parse(_diastolicController.text)?.toInt(),
      pulseRate: _parse(_pulseController.text)?.toInt(),
    );

    // Store the metrics using the provider
    await Provider.of<BodyMetricsProvider>(context, listen: false)
        .addMetrics(metrics, userId);

    // Navigate to the result page
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MetricsResultPage(metrics: metrics),
        ),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _neckController.dispose();
    _hipController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Body Metrics')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _numberField(
                  controller: _heightController,
                  label: 'Height (cm) *',
                  required: true),
              _numberField(
                  controller: _weightController,
                  label: 'Weight (kg) *',
                  required: true),
              _numberField(controller: _waistController, label: 'Waist (cm)'),
              _numberField(controller: _neckController, label: 'Neck (cm)'),
              _numberField(controller: _hipController, label: 'Hip (cm)'),
              Row(
                children: [
                  Expanded(
                      child: _numberField(
                          controller: _systolicController,
                          label: 'Systolic BP')),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _numberField(
                          controller: _diastolicController,
                          label: 'Diastolic BP')),
                ],
              ),
              _numberField(controller: _pulseController, label: 'Pulse Rate'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateMetrics,
                  child: const Text('calculate Metrics'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberField({
    required TextEditingController controller,
    required String label,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) =>
                value == null || value.isEmpty ? 'Required field' : null
            : null,
      ),
    );
  }
}
