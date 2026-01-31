import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:expensive_tracker_app/features/chart/chart_widgets.dart';

class ChartScreen extends StatefulWidget {
  final List<Expense> expenses;

  const ChartScreen({super.key, required this.expenses});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

enum DateFilter { week, month, year, all }

class _ChartScreenState extends State<ChartScreen> {
  DateFilter _selectedFilter = DateFilter.month;

  List<Expense> get filteredExpenses {
    final now = DateTime.now();
    switch (_selectedFilter) {
      case DateFilter.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return widget.expenses.where((e) {
          return e.date
              .isAfter(startOfWeek.subtract(const Duration(milliseconds: 1)));
        }).toList();
      case DateFilter.month:
        return widget.expenses.where((e) {
          return e.date.year == now.year && e.date.month == now.month;
        }).toList();
      case DateFilter.year:
        return widget.expenses.where((e) {
          return e.date.year == now.year;
        }).toList();
      case DateFilter.all:
        return widget.expenses;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total spend for selected period
    final totalSpend = filteredExpenses
        .where((e) => e.type == TransactionType.expense)
        .fold(0.0, (sum, e) => sum + e.amount);

    final totalIncome = filteredExpenses
        .where((e) => e.type == TransactionType.income)
        .fold(0.0, (sum, e) => sum + e.amount);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Filter Selector
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: DateFilter.values.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _selectedFilter = filter),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        filter.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'Expenses',
                  amount: totalSpend,
                  color: Colors.redAccent,
                  icon: Icons.arrow_downward,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SummaryCard(
                  title: 'Income',
                  amount: totalIncome,
                  color: Colors.green,
                  icon: Icons.arrow_upward,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Charts
          ChartCard(
            title: 'Spending by Category',
            child: ExpensePieChart(expenses: filteredExpenses),
          ),

          ChartCard(
            title: 'Spending Trend',
            child: ExpenseTrendChart(expenses: filteredExpenses),
          ),

          const SizedBox(height: 80), // Bottom padding
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
