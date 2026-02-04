import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/body_metrics.dart';
import '../providers/body_metrics_provider.dart';
import '../widgets/metric_line_chart.dart';

class HealthProgressPage extends StatefulWidget {
  const HealthProgressPage({super.key});

  @override
  State<HealthProgressPage> createState() => _HealthProgressPageState();
}

class _HealthProgressPageState extends State<HealthProgressPage> {
    // placeholder value for the current user
  var userId = 2;
  @override
  void initState() {
    super.initState();
    // Load metrics when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BodyMetricsProvider>(context, listen: false).loadMetrics(userId);
    });
  }

  /// Convert metric values to FlSpot safely (skip nulls)
  List<FlSpot> _buildSpots(
    List<BodyMetrics> metrics,
    double? Function(BodyMetrics m) selector,
  ) {
    final spots = <FlSpot>[];

    for (int i = 0; i < metrics.length; i++) {
      final value = selector(metrics[i]);
      if (value != null) {
        spots.add(FlSpot(i.toDouble(), value));
      }
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Progress')),
      body: Consumer<BodyMetricsProvider>(
        builder: (context, provider, child) {
          final metrics = provider.metrics;

          if (metrics.isEmpty) {
            return const Center(child: Text('No metrics available.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              MetricLineChart(
                title: 'BMI',
                points: _buildSpots(metrics, (m) => m.bmi),
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              MetricLineChart(
                title: 'Body Fat %',
                points: _buildSpots(metrics, (m) => m.bodyFat),
                color: Colors.pink,
              ),
              const SizedBox(height: 16),
              MetricLineChart(
                title: 'Systolic BP',
                points: _buildSpots(metrics, (m) => m.systolic?.toDouble()),
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              MetricLineChart(
                title: 'Diastolic BP',
                points: _buildSpots(metrics, (m) => m.diastolic?.toDouble()),
                color: Colors.orange,
              ),
              const SizedBox(height: 16),
              MetricLineChart(
                title: 'Pulse Rate',
                points: _buildSpots(metrics, (m) => m.pulseRate?.toDouble()),
                color: Colors.green,
              ),
            ],
          );
        },
      ),
    );
  }
}
