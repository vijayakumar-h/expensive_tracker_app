import 'package:fl_chart/fl_chart.dart';
import 'package:expensive_tracker_app/utils/common_exports.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const ChartCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class ExpensePieChart extends StatefulWidget {
  final List<Expense> expenses;

  const ExpensePieChart({super.key, required this.expenses});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No data to display")),
      );
    }

    // Group expenses by category
    final Map<String, double> categoryTotals = {};
    for (var e in widget.expenses) {
      if (e.type == TransactionType.expense) {
        categoryTotals.update(
          e.category.name,
          (value) => value + e.amount,
          ifAbsent: () => e.amount,
        );
      }
    }

    if (categoryTotals.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No expenses to chart")),
      );
    }

    final List<PieChartSectionData> sections = [];
    int index = 0;

    // Sort by amount descending
    final sortedEntries = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final totalAmount =
        sortedEntries.fold(0.0, (sum, item) => sum + item.value);

    // Color palette
    final List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];

    for (var entry in sortedEntries) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 16.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      final percentage = (entry.value / totalAmount * 100).toStringAsFixed(1);

      // Use category icon if available, or fallback to color
      // Since we don't have easy access to the CategoryModel object here (only name),
      // we'll stick to basic pie sections for now.

      sections.add(
        PieChartSectionData(
          color: colors[index % colors.length],
          value: entry.value,
          title: '$percentage%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      index++;
    }

    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: sections,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Legend
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sortedEntries.asMap().entries.map((entry) {
              final idx = entry.key;
              final e = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[idx % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.key,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '\$${e.value.toStringAsFixed(1)}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ExpenseTrendChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseTrendChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const SizedBox(height: 200, child: Center(child: Text("No data")));
    }

    // Group by date (day)
    // We'll show last 7 days for simplicity in this view
    // Or we should allow filtering. For now, let's just chart the expenses we have, sorted by date.

    final sortedExpenses = expenses
        .where((e) => e.type == TransactionType.expense)
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (sortedExpenses.isEmpty) return const SizedBox();

    // Aggregate by day
    final Map<DateTime, double> dailyTotals = {};
    for (var e in sortedExpenses) {
      final dateKey = DateTime(e.date.year, e.date.month, e.date.day);
      dailyTotals.update(
        dateKey,
        (value) => value + e.amount,
        ifAbsent: () => e.amount,
      );
    }

    final spots = dailyTotals.entries.map((e) {
      // X axis will be milliseconds since epoch / 1000 / 60 / 60 / 24 or just index
      // Using index for simple trend
      return FlSpot(e.key.millisecondsSinceEpoch.toDouble(), e.value);
    }).toList();

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final date =
                      DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "${date.day}/${date.month}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                },
                interval: 86400000 * 2, // Every 2 days roughly
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Theme.of(context).primaryColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
