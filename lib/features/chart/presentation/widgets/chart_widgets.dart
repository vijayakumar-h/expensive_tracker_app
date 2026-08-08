import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../expenses/data/models/expense_model.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const ChartCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPieChart extends StatelessWidget {
  final List<CategoryBucket> buckets;

  const CategoryPieChart({super.key, required this.buckets});

  @override
  Widget build(BuildContext context) {
    if (buckets.isEmpty) {
      return const Center(child: Text("No Data"));
    }

    final totalAmount = buckets.fold<double>(
      0,
      (sum, item) => sum + item.totalExpenses,
    );

    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.amber,
    ];

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: List.generate(buckets.length, (i) {
          final bucket = buckets[i];
          final percentage = totalAmount > 0
              ? (bucket.totalExpenses / totalAmount) * 100
              : 0.0;
          return PieChartSectionData(
            color: colors[i % colors.length],
            value: bucket.totalExpenses,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }),
      ),
    );
  }
}

class CategoryBarChart extends StatelessWidget {
  final List<CategoryBucket> buckets;

  const CategoryBarChart({super.key, required this.buckets});

  @override
  Widget build(BuildContext context) {
    if (buckets.isEmpty) {
      return const Center(child: Text("No Data"));
    }

    final theme = Theme.of(context);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: buckets.fold<double>(
                0, (max, b) => b.totalExpenses > max ? b.totalExpenses : max) *
            1.2,
        barTouchData: const BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index >= 0 && index < buckets.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      buckets[index].category.name,
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(buckets.length, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: buckets[i].totalExpenses,
                color: theme.primaryColor,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }),
      ),
    );
  }
}
