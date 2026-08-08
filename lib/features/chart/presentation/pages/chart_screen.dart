import 'package:flutter/material.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../expenses/data/models/category_model.dart';
import '../../../expenses/data/models/expense_model.dart';
import '../widgets/chart_widgets.dart';

class ChartScreen extends StatefulWidget {
  final List<Expense> expenses;

  const ChartScreen({super.key, required this.expenses});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  TransactionType _selectedType = TransactionType.expense;

  List<CategoryBucket> get _filteredBuckets {
    final filteredExpenses =
        widget.expenses.where((e) => e.type == _selectedType).toList();

    final categoriesMap = <String, CategoryModel>{};
    for (var expense in filteredExpenses) {
      categoriesMap[expense.category.id] = expense.category;
    }

    final buckets = <CategoryBucket>[];
    for (var category in categoriesMap.values) {
      final bucket = CategoryBucket.forCategory(filteredExpenses, category);
      if (bucket.totalExpenses > 0) {
        buckets.add(bucket);
      }
    }
    return buckets;
  }

  @override
  Widget build(BuildContext context) {
    final buckets = _filteredBuckets;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n('reports')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: [
                  _selectedType == TransactionType.expense,
                  _selectedType == TransactionType.income,
                ],
                onPressed: (index) {
                  setState(() {
                    _selectedType = index == 0
                        ? TransactionType.expense
                        : TransactionType.income;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(context.l10n('expenses')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(context.l10n('income')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ChartCard(
              title: "Distribution by Category",
              child: CategoryPieChart(buckets: buckets),
            ),
            const SizedBox(height: 16),
            ChartCard(
              title: "Category Totals",
              child: CategoryBarChart(buckets: buckets),
            ),
          ],
        ),
      ),
    );
  }
}
