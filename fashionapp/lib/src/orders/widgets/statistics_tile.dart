import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsTile extends StatelessWidget {
  final Map<String, int> statistics;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;
  const StatisticsTile(
      {super.key,
      required this.statistics,
      required this.isLoading,
      this.error,
      required this.refetch});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        titleSunbeamLayout: true,
        startDegreeOffset: -90,
        sections: statistics.entries.map((entry) {
          final category = entry.key;
          final count = entry.value;
          return PieChartSectionData(
            value: count.toDouble(),
            // title: '$category: $count',
            radius: 30,
            titleStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            color: Colors.primaries[statistics.keys.toList().indexOf(category)],
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
