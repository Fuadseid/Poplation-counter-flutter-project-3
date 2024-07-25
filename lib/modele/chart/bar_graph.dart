import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:practice/modele/pop_model.dart'; // Ensure the correct import path

class MyBarGraph extends StatelessWidget {
  final List<PopBucket> buckets;

  MyBarGraph({super.key, required this.buckets});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: buckets.isNotEmpty
            ? buckets.map((b) => b.number).reduce((a, b) => a > b ? a : b).toDouble()
            : 10,
        minY: 0,
        barGroups: List.generate(buckets.length, (index) {
          return BarChartGroupData(
            x: index * 2,
            barRods: [
              BarChartRodData(
                toY: buckets[index].number.toDouble(),
                width: 15,
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue,
              ),
            ],
          );
        }),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt() ~/ 2;
                if (index >= 0 && index < buckets.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      buckets[index].category.description,
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
