import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MetricLineChart extends StatelessWidget {
  final String title;
  final List<FlSpot> points;
  final Color color;

  const MetricLineChart({
    super.key,
    required this.title,
    required this.points,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return Card(
        child: SizedBox(
          height: 200,
          child: Center(child: Text('$title: No data')),
        ),
      );
    }

    final minY = points.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxY = points.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.2 == 0 ? 1 : (maxY - minY) * 0.2;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  minY: minY - padding,
                  maxY: maxY + padding,

                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42, // ⭐ IMPORTANT
                        interval: (maxY - minY) / 2,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 11),
                          );
                        },
                      ),
                    ),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: points,
                      isCurved: true,
                      color: color,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
